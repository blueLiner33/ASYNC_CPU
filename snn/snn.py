import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import numpy as np
import cv2
import os
from PIL import Image
import json
from sklearn.model_selection import train_test_split
import pickle


class LIFNeuron(nn.Module):
    """Leaky Integrate-and-Fire Neuron with differentiable spike function"""

    def __init__(self, tau=20.0, threshold=1.0, reset=0.0):
        super(LIFNeuron, self).__init__()
        self.tau = tau
        self.threshold = threshold
        self.reset = reset
        self.membrane_potential = None

    def spike_function(self, x):
        """Differentiable spike function using sigmoid approximation"""
        return torch.sigmoid(10 * (x - self.threshold))

    def forward(self, x):
        if self.membrane_potential is None:
            self.membrane_potential = torch.zeros_like(x)

        # LIF dynamics: dv/dt = (-v + I)/tau
        self.membrane_potential = self.membrane_potential * (1 - 1 / self.tau) + x

        # Differentiable spike generation
        spikes = self.spike_function(self.membrane_potential)

        # Soft reset using spikes
        self.membrane_potential = self.membrane_potential * (1 - spikes) + self.reset * spikes

        return spikes

    def reset_state(self):
        self.membrane_potential = None


class LIFFSNN(nn.Module):
    """Simplified and more powerful network: 208-128-64-15"""

    def __init__(self, max_objects=3):
        super(LIFFSNN, self).__init__()

        self.max_objects = max_objects

        # Bigger network with batch norm for better learning
        self.fc1 = nn.Linear(208, 128)  # Bigger hidden layer
        self.bn1 = nn.BatchNorm1d(128)
        self.relu1 = nn.ReLU()
        self.dropout1 = nn.Dropout(0.3)

        self.fc2 = nn.Linear(128, 64)  # Additional layer
        self.bn2 = nn.BatchNorm1d(64)
        self.relu2 = nn.ReLU()
        self.dropout2 = nn.Dropout(0.3)

        self.fc3 = nn.Linear(64, max_objects * 5)  # Output layer

        # Initialize weights better
        self._initialize_weights()

    def _initialize_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Linear):
                nn.init.xavier_uniform_(m.weight)
                nn.init.constant_(m.bias, 0)

    def forward(self, x, time_steps=10):
        batch_size = x.size(0)

        # Deeper network
        h1 = self.fc1(x)
        h1 = self.bn1(h1)
        h1 = self.relu1(h1)
        h1 = self.dropout1(h1)

        h2 = self.fc2(h1)
        h2 = self.bn2(h2)
        h2 = self.relu2(h2)
        h2 = self.dropout2(h2)

        h3 = self.fc3(h2)

        # Reshape to [batch_size, max_objects, 5]
        output = h3.view(batch_size, self.max_objects, 5)

        # Apply sigmoid to all outputs
        return torch.sigmoid(output)

    def get_weights_biases(self):
        """Extract all weights and biases for transfer"""
        params = {}
        params['fc1_weight'] = self.fc1.weight.detach().cpu().numpy()
        params['fc1_bias'] = self.fc1.bias.detach().cpu().numpy()
        params['fc2_weight'] = self.fc2.weight.detach().cpu().numpy()
        params['fc2_bias'] = self.fc2.bias.detach().cpu().numpy()
        params['fc3_weight'] = self.fc3.weight.detach().cpu().numpy()
        params['fc3_bias'] = self.fc3.bias.detach().cpu().numpy()

        # Batch norm parameters
        params['bn1_weight'] = self.bn1.weight.detach().cpu().numpy()
        params['bn1_bias'] = self.bn1.bias.detach().cpu().numpy()
        params['bn1_running_mean'] = self.bn1.running_mean.detach().cpu().numpy()
        params['bn1_running_var'] = self.bn1.running_var.detach().cpu().numpy()

        params['bn2_weight'] = self.bn2.weight.detach().cpu().numpy()
        params['bn2_bias'] = self.bn2.bias.detach().cpu().numpy()
        params['bn2_running_mean'] = self.bn2.running_mean.detach().cpu().numpy()
        params['bn2_running_var'] = self.bn2.running_var.detach().cpu().numpy()

        return params


class KITTIDataset(Dataset):
    def __init__(self, image_dir, label_dir, img_size=(208, 1), split='train', max_objects=5, skip_crowded=False):
        self.image_dir = image_dir
        self.label_dir = label_dir
        self.img_size = img_size
        self.split = split
        self.max_objects = max_objects
        self.skip_crowded = skip_crowded

        # Get all image files
        self.image_files = sorted([f for f in os.listdir(image_dir) if f.endswith('.png')])

        # Filter out images with too many objects if requested
        if skip_crowded:
            self.image_files = self.filter_crowded_images()

        # Split by sequences to prevent data leakage
        self.train_files, self.val_files = self.split_by_sequences()

        if split == 'train':
            self.files = self.train_files
        else:
            self.files = self.val_files

    def filter_crowded_images(self):
        """Remove images with more than max_objects - optimized for speed"""
        filtered_files = []
        skipped_count = 0

        print("Filtering crowded images...")
        for i, img_file in enumerate(self.image_files):
            # Progress indicator for large datasets
            if i % 1000 == 0:
                print(f"  Processed {i}/{len(self.image_files)} images")

            label_file = img_file.replace('.png', '.txt')
            label_path = os.path.join(self.label_dir, label_file)

            if os.path.exists(label_path):
                # Fast line counting without loading full content
                with open(label_path, 'r') as f:
                    num_objects = sum(1 for line in f if line.strip())

                if num_objects <= self.max_objects:
                    filtered_files.append(img_file)
                else:
                    skipped_count += 1
            else:
                filtered_files.append(img_file)  # Keep images without labels

        print(f"✅ Filtered dataset: kept {len(filtered_files)} images, skipped {skipped_count} images with >3 objects")
        return filtered_files

    def split_by_sequences(self):
        """Split by frame groups to prevent data leakage"""
        # Since files are flat (000000.png, 000001.png, etc.),
        # we'll group by frame ranges to avoid temporal leakage

        # Extract frame numbers
        frame_numbers = []
        for file in self.image_files:
            frame_num = int(file.split('.')[0])
            frame_numbers.append((frame_num, file))

        # Sort by frame number
        frame_numbers.sort(key=lambda x: x[0])

        # Group into chunks to avoid consecutive frames in different splits
        chunk_size = 50  # Group every 50 frames together
        chunks = []

        for i in range(0, len(frame_numbers), chunk_size):
            chunk = [item[1] for item in frame_numbers[i:i + chunk_size]]
            chunks.append(chunk)

        # Split chunks 80/20
        train_chunks, val_chunks = train_test_split(chunks, test_size=0.2, random_state=42)

        # Flatten back to file lists
        train_files = []
        val_files = []

        for chunk in train_chunks:
            train_files.extend(chunk)

        for chunk in val_chunks:
            val_files.extend(chunk)

        return train_files, val_files

    def __len__(self):
        return len(self.files)

    def __getitem__(self, idx):
        # Load image
        img_name = self.files[idx]
        img_path = os.path.join(self.image_dir, img_name)
        image = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)

        # Resize and flatten to 208 features
        image = cv2.resize(image, (16, 13))  # 16*13 = 208
        image = image.flatten().astype(np.float32) / 255.0

        # Load labels - MULTIPLE objects per image
        label_name = img_name.replace('.png', '.txt')
        label_path = os.path.join(self.label_dir, label_name)

        # Initialize target for max_objects (3 objects max)
        max_objects = 3
        target = np.zeros((max_objects, 5))  # [x1, y1, x2, y2, confidence]

        if os.path.exists(label_path):
            with open(label_path, 'r') as f:
                lines = f.readlines()

            # Check if image has too many objects (should be rare after filtering)
            if len(lines) > max_objects:
                # This should rarely happen since we filter, but just in case
                pass  # Skip warning to keep training fast

            # Process up to max_objects
            objects_processed = 0
            for i, line in enumerate(lines):
                if objects_processed >= max_objects:
                    break

                parts = line.strip().split()
                if len(parts) >= 8:
                    try:
                        # Extract bounding box: bbox_left bbox_top bbox_right bbox_bottom
                        left = float(parts[4])
                        top = float(parts[5])
                        right = float(parts[6])
                        bottom = float(parts[7])

                        # Quick sanity check coordinates (keep it fast)
                        if left >= 0 and top >= 0 and right > left and bottom > top:
                            # Normalize coordinates (assuming image size ~1200x400)
                            target[objects_processed] = [
                                left / 1200.0,  # x1
                                top / 400.0,  # y1
                                right / 1200.0,  # x2
                                bottom / 400.0,  # y2
                                1.0  # confidence (object exists)
                            ]
                            objects_processed += 1
                    except (ValueError, IndexError):
                        # Skip invalid lines silently to keep training fast
                        continue

        return torch.FloatTensor(image), torch.FloatTensor(target)


def calculate_accuracy(predictions, targets, threshold=0.10, debug=False):
    """Simplified accuracy - just measure coordinate accuracy for existing objects"""
    # predictions: [batch_size, max_objects, 5]
    # targets: [batch_size, max_objects, 5]

    # Only consider objects with confidence > 0.5 in targets (real objects)
    valid_objects = targets[:, :, 4] > 0.5

    if debug:
        print(f"  Debug: Valid objects in batch: {valid_objects.sum().item()}")
        print(f"  Debug: Total possible objects: {valid_objects.numel()}")
        print(f"  Debug: Avg prediction coords: {predictions[:, :, :4].mean().item():.3f}")
        if valid_objects.sum() > 0:
            avg_target = targets[valid_objects][:, :4].mean().item()
            print(f"  Debug: Avg target coords: {avg_target:.3f}")
        else:
            print(f"  Debug: Avg target coords: N/A")

    if valid_objects.sum() == 0:
        return 0.0

    # Calculate coordinate accuracy for all valid objects (ignore confidence for now)
    coord_diff = torch.abs(predictions[:, :, :4] - targets[:, :, :4])  # [batch, objects, 4]
    coord_errors = coord_diff.mean(dim=2)  # Average error per object

    if debug:
        print(f"  Debug: Avg coordinate error: {coord_errors[valid_objects].mean().item():.3f}")
        print(f"  Debug: Threshold: {threshold}")

    # Count accuracy for valid objects
    accurate_objects = (coord_errors < threshold) & valid_objects
    accuracy = accurate_objects.float().sum() / valid_objects.float().sum()

    return accuracy.item()


def multi_object_loss(predictions, targets, epoch=0):
    """Custom loss function for multi-object detection with adaptive confidence"""
    # predictions: [batch_size, max_objects, 5]
    # targets: [batch_size, max_objects, 5]

    # Separate coordinates and confidence
    pred_coords = predictions[:, :, :4]  # [batch, objects, 4]
    pred_conf = predictions[:, :, 4]  # [batch, objects]

    target_coords = targets[:, :, :4]  # [batch, objects, 4]
    target_conf = targets[:, :, 4]  # [batch, objects]

    # Adaptive confidence threshold - start low, increase over time
    conf_threshold = min(0.1 + epoch * 0.01, 0.5)  # 0.1 -> 0.5 over 40 epochs

    # Only compute coordinate loss for objects that exist
    valid_objects = target_conf > 0.5

    if valid_objects.sum() > 0:
        # Always train coordinates for valid objects (remove confidence filtering for now)
        coord_loss = nn.functional.mse_loss(
            pred_coords[valid_objects],
            target_coords[valid_objects]
        )
    else:
        coord_loss = torch.tensor(0.0, device=predictions.device)

    # Confidence loss - make this stronger
    conf_loss = nn.functional.binary_cross_entropy(pred_conf, target_conf)

    # Weight the losses - emphasize coordinate learning early, confidence later
    if epoch < 20:
        total_loss = coord_loss * 2.0 + conf_loss * 0.5  # Focus on coordinates first
    else:
        total_loss = coord_loss * 1.0 + conf_loss * 1.5  # Then focus on confidence

    return total_loss


def train_model(model, train_loader, val_loader, epochs=50, lr=0.001):
    """Train the multi-object SNN model"""
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model = model.to(device)

    # Use custom loss function instead of MSE
    optimizer = optim.Adam(model.parameters(), lr=lr, weight_decay=1e-4)
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='min', factor=0.5, patience=10)

    best_val_loss = float('inf')
    train_losses = []
    val_losses = []
    train_accuracies = []
    val_accuracies = []

    print(f"Training on {device}")
    print(f"Train samples: {len(train_loader.dataset)}")
    print(f"Val samples: {len(val_loader.dataset)}")
    print("=" * 80)

    for epoch in range(epochs):
        # Training phase
        model.train()
        train_loss = 0.0
        train_acc = 0.0
        train_batches = 0

        for batch_idx, (data, target) in enumerate(train_loader):
            data, target = data.to(device), target.to(device)

            optimizer.zero_grad()
            output = model(data)

            # Use custom multi-object loss with epoch info
            loss = multi_object_loss(output, target, epoch)
            loss.backward()
            optimizer.step()

            train_loss += loss.item()
            train_acc += calculate_accuracy(output, target, debug=(batch_idx == 0 and epoch % 10 == 0))
            train_batches += 1

        # Validation phase
        model.eval()
        val_loss = 0.0
        val_acc = 0.0
        val_batches = 0

        with torch.no_grad():
            for data, target in val_loader:
                data, target = data.to(device), target.to(device)
                output = model(data)

                # Use custom multi-object loss with epoch info
                val_loss += multi_object_loss(output, target, epoch).item()
                val_acc += calculate_accuracy(output, target)
                val_batches += 1

        train_loss /= train_batches
        val_loss /= val_batches
        train_acc /= train_batches
        val_acc /= val_batches

        train_losses.append(train_loss)
        val_losses.append(val_loss)
        train_accuracies.append(train_acc)
        val_accuracies.append(val_acc)

        scheduler.step(val_loss)  # Use validation loss for scheduling

        print(
            f'Epoch {epoch + 1:2d}/{epochs}: Train Loss: {train_loss:.6f} | Train Acc: {train_acc:.4f} | Val Loss: {val_loss:.6f} | Val Acc: {val_acc:.4f}')

        # Additional debug info every 10 epochs
        if epoch % 10 == 0:
            print(f"    Debug: Learning rate = {optimizer.param_groups[0]['lr']:.6f}")
            print(f"    Debug: Best val loss so far = {best_val_loss:.6f}")

        # Save best model
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            torch.save(model.state_dict(), 'best_lif_snn_model.pth')

    print("=" * 80)
    print(f"FINAL RESULTS:")
    print(f"Best Validation Loss: {best_val_loss:.6f}")
    print(f"Final Train Accuracy: {train_accuracies[-1]:.4f}")
    print(f"Final Val Accuracy: {val_accuracies[-1]:.4f}")

    return train_losses, val_losses, train_accuracies, val_accuracies


def predict_hazards(model, image_path, device):
    """Predict hazard locations for a single image"""
    # Load and preprocess image
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    original_h, original_w = image.shape

    # Resize and flatten
    image_resized = cv2.resize(image, (16, 13))
    image_flat = image_resized.flatten().astype(np.float32) / 255.0

    # Convert to tensor
    input_tensor = torch.FloatTensor(image_flat).unsqueeze(0).to(device)

    # Predict
    model.eval()
    with torch.no_grad():
        output = model(input_tensor)

    # Convert normalized coordinates to pixel coordinates
    bbox_norm = output.cpu().numpy()[0]

    # Convert to pixel coordinates
    left = int(bbox_norm[0] * original_w)
    top = int(bbox_norm[1] * original_h)
    right = int(bbox_norm[2] * original_w)
    bottom = int(bbox_norm[3] * original_h)

    return [left, top, right, bottom]


def verify_data_loading(dataset, num_samples=3):
    """Verify that data is loading correctly"""
    print("=" * 80)
    print("DATA VERIFICATION:")
    print("=" * 80)

    for i in range(min(num_samples, len(dataset))):
        image, target = dataset[i]
        filename = dataset.files[i]

        print(f"Sample {i + 1}:")
        print(f"  File: {filename}")
        print(f"  Image shape: {image.shape} (should be [208])")
        print(f"  Image range: [{image.min():.3f}, {image.max():.3f}] (should be [0, 1])")
        print(f"  Target shape: {target.shape} (should be [3, 5] for 3 objects)")

        # Show which objects have labels
        valid_objects = target[:, 4] > 0.5
        num_objects = valid_objects.sum().item()
        print(f"  Number of objects: {num_objects}")

        for obj_idx in range(len(target)):
            if target[obj_idx, 4] > 0.5:  # Valid object
                bbox = target[obj_idx, :4]
                conf = target[obj_idx, 4]
                print(
                    f"    Object {obj_idx + 1}: BBox [left, top, right, bottom] = [{bbox[0]:.3f}, {bbox[1]:.3f}, {bbox[2]:.3f}, {bbox[3]:.3f}], Conf: {conf:.3f}")
        print()


def print_model_weights(model):
    """Print all model weights and biases for verification"""
    print("=" * 80)
    print("FINAL MODEL WEIGHTS AND BIASES:")
    print("=" * 80)

    weights_biases = model.get_weights_biases()

    print("Layer 1 (Input -> Hidden): 208 -> 128")
    print("  Weights shape:", weights_biases['fc1_weight'].shape)
    print("  Weight sample (first 3x3):")
    print(weights_biases['fc1_weight'][:3, :3])
    print("  Biases shape:", weights_biases['fc1_bias'].shape)
    print("  Bias sample (first 10):")
    print(weights_biases['fc1_bias'][:10])
    print()

    print("Layer 2 (Hidden -> Hidden): 128 -> 64")
    print("  Weights shape:", weights_biases['fc2_weight'].shape)
    print("  Weight sample (first 3x3):")
    print(weights_biases['fc2_weight'][:3, :3])
    print("  Biases shape:", weights_biases['fc2_bias'].shape)
    print("  Bias sample (first 10):")
    print(weights_biases['fc2_bias'][:10])
    print()

    print("Layer 3 (Hidden -> Output): 64 -> 15")
    print("  Weights shape:", weights_biases['fc3_weight'].shape)
    print("  Weights (first 5 rows):")
    print(weights_biases['fc3_weight'][:5])
    print("  Biases shape:", weights_biases['fc3_bias'].shape)
    print("  Biases (full):")
    print(weights_biases['fc3_bias'])
    print()

    print("Batch Norm Parameters:")
    print(f"  BN1 weights: {weights_biases['bn1_weight'].shape}")
    print(f"  BN2 weights: {weights_biases['bn2_weight'].shape}")
    print()

    return weights_biases


def main():
    # Configuration - UPDATE THESE PATHS TO YOUR ACTUAL DATA LOCATION
    KITTI_ROOT = "/Users/priyankarazdan/Downloads/kitti_dataset"  # Change this to your actual path
    TRAIN_IMG_DIR = os.path.join(KITTI_ROOT, "training", "image_02")
    TRAIN_LABEL_DIR = os.path.join(KITTI_ROOT, "training", "label_02")

    BATCH_SIZE = 32
    EPOCHS = 50
    LEARNING_RATE = 0.01  # Increase learning rate significantly
    MAX_OBJECTS = 3  # Maximum objects per image (3 hazards max)
    SKIP_CROWDED = True  # Skip images with >3 objects (keeps latency low)

    print("Setting up datasets...")

    # Create datasets with crowded image handling
    train_dataset = KITTIDataset(TRAIN_IMG_DIR, TRAIN_LABEL_DIR, split='train',
                                 max_objects=MAX_OBJECTS, skip_crowded=SKIP_CROWDED)
    val_dataset = KITTIDataset(TRAIN_IMG_DIR, TRAIN_LABEL_DIR, split='val',
                               max_objects=MAX_OBJECTS, skip_crowded=SKIP_CROWDED)

    # Create data loaders
    train_loader = DataLoader(train_dataset, batch_size=BATCH_SIZE, shuffle=True)
    val_loader = DataLoader(val_dataset, batch_size=BATCH_SIZE, shuffle=False)

    print("Creating model...")

    # Create model
    model = LIFFSNN()

    # Verify data loading
    print("Verifying train dataset...")
    verify_data_loading(train_dataset, num_samples=3)

    print("Verifying validation dataset...")
    verify_data_loading(val_dataset, num_samples=2)

    print("Starting training...")

    # Train model
    train_losses, val_losses, train_accs, val_accs = train_model(model, train_loader, val_loader,
                                                                 epochs=EPOCHS, lr=LEARNING_RATE)

    print("Training completed!")

    # Load best model
    model.load_state_dict(torch.load('best_lif_snn_model.pth'))

    # Print final weights and biases
    final_weights = print_model_weights(model)

    # Extract and save weights/biases
    print("Extracting weights and biases...")
    weights_biases = model.get_weights_biases()

    # Save to file
    with open('lif_snn_weights_biases.pkl', 'wb') as f:
        pickle.dump(weights_biases, f)

    # Also save as JSON for easier inspection
    weights_biases_json = {}
    for key, value in weights_biases.items():
        if isinstance(value, np.ndarray):
            weights_biases_json[key] = value.tolist()
        else:
            weights_biases_json[key] = value

    with open('lif_snn_weights_biases.json', 'w') as f:
        json.dump(weights_biases_json, f, indent=2)

    print("Weights and biases saved to:")
    print("- lif_snn_weights_biases.pkl (for Python)")
    print("- lif_snn_weights_biases.json (human readable)")

    print("=" * 80)
    print("TRAINING COMPLETE!")
    print("Architecture: 208-40-15 Multi-Object LIF SNN")
    print("Input: 208 features (16x13 grayscale image)")
    print("Hidden: 40 LIF neurons")
    print("Output: 15 values (3 objects × 5 values each)")
    print("Each object: [x1, y1, x2, y2, confidence]")
    print("Ready for transfer to your other neural network!")
    print("=" * 80)


if __name__ == "__main__":
    main()

# Usage example for inference only:
"""
# Load trained model
model = LIFFSNN()
model.load_state_dict(torch.load('best_lif_snn_model.pth'))
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
model = model.to(device)

# Predict on new image
hazard_coords = predict_hazards(model, 'path/to/image.png', device)
print(f"Hazard location: {hazard_coords}")

# Load weights for transfer to another network
with open('lif_snn_weights_biases.pkl', 'rb') as f:
    weights_biases = pickle.load(f)

print("Available parameters:")
for key in weights_biases.keys():
    print(f"- {key}: shape {weights_biases[key].shape if hasattr(weights_biases[key], 'shape') else 'scalar'}")
"""
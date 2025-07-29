//
//	disk.cc
//
//	DLX simulator code to simulate a simple disk.
//
//	Copyright (c) 1999-2003 by Ethan L. Miller
//

static char rcsid[] = "$Id: disk.cc,v 1.3 2003/11/25 02:33:12 elm Exp $";

#include <fcntl.h>
#include <unistd.h>
#include "dlx.h"
#include "dlxdisk.h"

#define	MIN(a,b)	((a) < (b) ? a : b)

Disk::Disk (const char *fn, int sizeInBlocks)
{
  strncpy (filename, fn, sizeof (filename)-1);
  filename[sizeof(filename)-1] = '\0';
  diskSize = sizeInBlocks;
  fd = open (filename, O_CREAT | O_RDWR, 0600);
  if (fd < 0) {
    fprintf (stderr, "WARNING: disk file %s couldn't be opened.\n", filename);
    status = DISK_STATUS_NOTWORKING;
  } else {
    status = DISK_STATUS_IDLE;
  }
  curTrack = 0;
  rotationTime = DISK_ROTATION_TIME;
  blocksPerTrack = DISK_BLOCKS_PER_TRACK;
  activeRequest = -1;
  emptySlot = 0;
  nRequests = 0;
  curDone = 0;
  nDone = 0;
  finishTime = 1e60;
}

int
Disk::StartIo (uint32 req, class Cpu *cpu)
{
  DBPRINTF ('K', "Starting I/O at req 0x%x\n", req);
  if (req == 0) {
    ClearStatus ();
  } else {
    reqAddr[emptySlot] = req;
    reqs[emptySlot].bufPtr = cpu->Memory (req + 0 * sizeof (uint32));
    reqs[emptySlot].startBlock = cpu->Memory (req + 1 * sizeof (uint32));
    reqs[emptySlot].nBlocks = cpu->Memory (req + 2 * sizeof (uint32));
    reqs[emptySlot].opAndStatus = cpu->Memory (req + 3 * sizeof (uint32));
    DBPRINTF ('K', "request for op 0x%x: %d blocks at %d to 0x%x\n",
	      reqs[emptySlot].opAndStatus,
	      reqs[emptySlot].nBlocks,
	      reqs[emptySlot].startBlock,
	      reqs[emptySlot].bufPtr);
    emptySlot = (emptySlot + 1) % DISK_MAX_OUTSTANDING_REQUESTS;
    if (++nRequests == 1) {
      ScheduleNextRequest (cpu);
    }
  }
  return (1);
}

uint32
Disk::FinishIo (class Cpu *cpu)
{
  uint32 	buf[DLX_DISK_BLOCK_SIZE/sizeof (uint32)];
  int		i, j, x;
  int		op;
  uint32	addr;

  x = activeRequest;
  reqs[x].opAndStatus &= 0xffff0000;
  op = reqs[x].opAndStatus >> 16;
  if ((reqs[x].startBlock + reqs[x].nBlocks) * DLX_DISK_BLOCK_SIZE >
      lseek (fd, 0, SEEK_END)) {
    ftruncate (fd, MIN ((reqs[x].startBlock+reqs[x].nBlocks), diskSize) *
	       DLX_DISK_BLOCK_SIZE);
  }
  if (lseek (fd, reqs[x].startBlock * DLX_DISK_BLOCK_SIZE, SEEK_SET) ==
      reqs[x].startBlock * DLX_DISK_BLOCK_SIZE) {
    addr = reqs[x].bufPtr;
    for (i = 0; i < reqs[x].nBlocks; i++) {
      if (! cpu->CheckAddr (addr + DLX_DISK_BLOCK_SIZE - 1)) {
	break;
      }
      if (op == DLX_DISK_IO_READ) {
	DBPRINTF ('K', "Attempting to read from fd %d at offset 0x%x\n",
		  fd, reqs[x].startBlock);
	if (read (fd, buf, sizeof (buf)) != sizeof (buf)) {
	  break;
	}
	for (j = 0; j < sizeof (buf) / sizeof (uint32);
	     j++, addr += sizeof (uint32)) {
	  cpu->SetMemory (addr, buf[j]);
	}
      } else if (op == DLX_DISK_IO_WRITE) {
	DBPRINTF ('K', "Attempting to write to fd %d at offset 0x%x\n",
		  fd, reqs[x].startBlock);
	for (j = 0; j < sizeof (buf) / sizeof (uint32);
	     j++, addr += sizeof (uint32)) {
	  buf[j] = cpu->Memory (addr);
	}
	if (write (fd, buf, sizeof (buf)) != sizeof (buf)) {
	  break;
	}
      }
    }
    reqs[x].opAndStatus |= i;
  } else {
    // Read no blocks!
    reqs[x].opAndStatus |= 0;
  }
  cpu->SetMemory (reqAddr[x] + 3 * sizeof (uint32), reqs[x].opAndStatus);
  nRequests--;
  ScheduleNextRequest (cpu);
  doneRequests[(curDone + nDone) % DISK_MAX_OUTSTANDING_REQUESTS] = x;
  nDone++;
  return (reqAddr[x]);
}

void
Disk::ScheduleNextRequest (class Cpu *cpu)
{
  if (nRequests > 0) {
    activeRequest = (DISK_MAX_OUTSTANDING_REQUESTS + emptySlot - nRequests)
      % DISK_MAX_OUTSTANDING_REQUESTS;
    finishTime = cpu->GetElapsed() + Latency(activeRequest);
  } else {
    finishTime = 1e60;
    activeRequest = -1;
  }
}

double
Disk::Latency (int req)
{
  // Latency is a fixed 10 ms for now.
  return (10000.0);
}

void
Disk::ClearStatus ()
{
  if (nDone > 0) {
    curDone = (curDone + 1) % DISK_MAX_OUTSTANDING_REQUESTS;
    nDone--;
  }
}

uint32
Disk::GetStatus ()
{
  if (nDone > 0) {
    return (reqAddr[doneRequests[curDone]]);
  } else {
    return (0);
  }
}

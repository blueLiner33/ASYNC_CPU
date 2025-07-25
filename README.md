# Async CPU + SNN Hybrid Architecture

## Overview

This project explores combining an asynchronous CPU with a spiking neural network (SNN) acting as a preprocessing stage. The goal is to reduce overall system latency by offloading pattern recognition to the SNN, which then passes signals directly to the async CPU for immediate reaction. Unlike most neuromorphic chips that only use asynchronous signaling between neurons, we integrate SNN output into a fully asynchronous CPU pipeline.

## Experiment

We compare two systems:
1. A fully asynchronous CPU using 4-phase bundled-data handshake logic, with inputs preprocessed by an SNN.
2. A traditional synchronous CPU without SNN preprocessing.

Both systems are fed binary input patterns (e.g., arrays representing shapes like circles). We measure how quickly each system outputs a stop signal after recognizing a specific pattern.

## Real-World Motivation

This hybrid approach could improve latency in time-sensitive applications like autonomous vehicles. For example, faster obstacle detection from SNN preprocessing could allow an async CPU to trigger braking sooner than a synchronous system reliant on full-cycle analysis.

## Challenges

- Correctly implementing 4-phase handshake logic in the async CPU.
- Converting SNN output into handshake-compatible signals.
- Debugging and verifying asynchronous logic.
- Coordinating timing between the spiking domain and the event-driven CPU.

This project demonstrates a novel intersection of neuromorphic preprocessing and asynchronous digital logic, pushing the limits of efficient real-time computation.

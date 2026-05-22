---
title: Configuration options for {{ myt-name }} cluster components
description: The component configuration determines the computing power allocated for each component in a {{ myt-name }} cluster.
---

# Configuration options for {{ myt-name }} cluster components

The component configuration determines the computing power allocated for each component in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available component configuration options

### Exec nodes {#exec-node}

| Type | Number of vCPUs | RAM, GB | GPU | Number of GPUs |
|--------|-----------------|---------|--------|------------|
| c8-m32 | 8 | 32 | — | — |
| c32-m128 | 32 | 128 | — | — |
| c32-m256 | 32 | 256 | — | — |
| c64-m256 | 64 | 256 | — | — |
| c64-m512 | 64 | 512 | — | — |
| c80-m320 | 80 | 320 | — | — |
| c80-m640 | 80 | 640 | — | — |
| gpu-v2-g1 | 8 | 48  | NVIDIA® Tesla® V100 | 1 |
| gpu-v2-g2 | 16 | 96  | NVIDIA® Tesla® V100 | 2 |
| gpu-v2-g4 | 32 | 192 | NVIDIA® Tesla® V100 | 4 |
| gpu-v3-g1 | 28 | 119 | NVIDIA® Ampere® A100 | 1 |
| gpu-v3-g2 | 56 | 238 | NVIDIA® Ampere® A100 | 2 |
| gpu-v3-g4 | 112 | 476 | NVIDIA® Ampere® A100 | 4 |
| gpu-t4i-g1 | 32 | 128 | T4i | 1 |

### Tablet nodes {#tablet-node}

| Type | Number of vCPUs | RAM, GB |
|--------|-----------------|---------|
| c6-m12 | 6 | 12 |
| c8-m16 | 8 | 16 |
| c16-m32 | 16 | 32 |
| c32-m64 | 32 | 64 |
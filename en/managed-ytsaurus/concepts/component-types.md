---
title: Configuration options for {{ myt-name }} cluster components
description: The component configuration determines the computing power allocated for each component in a {{ myt-name }} cluster.
---

# Configuration options for {{ myt-name }} cluster components

The component configuration determines the computing power allocated for each component in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available component configuration options

### Exec nodes {#exec-node}

| Type | Number of vCPUs | RAM, GB |
|--------|-----------------|---------|
| c8-m32 | 8 | 32 |
| c32-m128 | 32 | 128 |
| c32-m256 | 32 | 256 |
| c64-m256 | 64 | 256 |
| c64-m512 | 64 | 512 |
| c80-m320 | 80 | 320 |
| c80-m640 | 80 | 640 |

### Tablet nodes {#tablet-node}

| Type | Number of vCPUs | RAM, GB |
|--------|-----------------|---------|
| c8-m16 | 8 | 16 |
| c16-m32 | 16 | 32 |
| c32-m64 | 32 | 64 |
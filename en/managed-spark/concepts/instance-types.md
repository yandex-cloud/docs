---
title: '{{ msp-full-name }} host classes'
description: The host class determines the computing power allocated for each host in a {{ msp-full-name }} cluster.
---

# {{ msp-full-name }} host classes

The host class determines the computing power allocated for each host in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ msp-full-name }} clusters are deployed on {{ compute-full-name }} VMs.

Configuration types:

* **standard**: Standard VMs with 4:1 RAM to vCPU ratio.
* **memory-optimized**: VMs with an increased RAM to vCPU ratio (8:1).

The full list of possible host configurations on each platform is provided below.

| Host class name | Number of vCPUs | RAM, GB |
|-------------------|-----------------|---------|
| c2-m8             | 2               | 8       |
| c2-m16            | 2               | 16      |
| c4-m16            | 4               | 16      |
| c4-m32            | 4               | 32      |
| c8-m32            | 8               | 32      |
| c8-m64            | 8               | 64      |
| c16-m64           | 16              | 64      |
| c16-m128          | 16              | 128     |
| c32-m128          | 32              | 128     |
| c32-m256          | 32              | 256     |
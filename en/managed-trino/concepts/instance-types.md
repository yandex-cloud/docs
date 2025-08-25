---
title: '{{ mtr-name }} host classes'
description: The host class determines the computing power allocated for each host in a {{ mtr-name }} cluster.
---

# {{ mtr-name }} host classes

The host class determines the computing power allocated for each host in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ mtr-name }} clusters are deployed on {{ compute-full-name }} VM instances powered by Intel Ice Lake.

There are two available configuration types:

* **standard**: Standard VMs with 4:1 RAM to vCPU ratio.
* **memory-optimized**: VMs with an increased RAM to vCPU ratio (8:1).

Below are the available host classes for each configuration.

* **standard**

  | Host class name | Number of vCPUs | RAM, GB |
  |-------------------|-----------------|---------|
  | c4-m16            | 4               | 16      |
  | c8-m32            | 8               | 32      |
  | c16-m64           | 16              | 64      |
  | c32-m128          | 32              | 128     |

* **memory-optimized**

  | Host class name | Number of vCPUs | RAM, GB |
  |-------------------|-----------------|---------|
  | c4-m32            | 4               | 32      |
  | c8-m64            | 8               | 64      |
  | c16-m128          | 16              | 128     |
  | c32-m256          | 32              | 256     |
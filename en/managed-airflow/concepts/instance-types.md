---
title: '{{ maf-name }} host classes'
description: The host class determines the computing power allocated for each host in a {{ maf-name }} cluster.
---

# {{ maf-name }} host classes

The host class determines the computing power allocated for each host in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ maf-name }} clusters are deployed on {{ compute-full-name }} VM instances powered by Intel Ice Lake.

There are two available configuration types:

* **standard**: Standard VMs with 4:1 RAM to vCPU ratio.
* **cpu-optimized**: VMs with a decreased RAM to vCPU ratio (2:1).

Below are the available host classes for each configuration.

* **standard**

  | Host class name | Number of vCPUs | RAM, GB |
  |-------------------|-----------------|---------|
  | c1-m4             | 1               | 4       |
  | c2-m8             | 2               | 8       |
  | c4-m16            | 4               | 16      |
  | c8-m32            | 8               | 32      |

* **cpu-optimized**

  | Host class name | Number of vCPUs | RAM, GB |
  |-------------------|-----------------|---------|
  | c1-m2             | 1               | 2       |
  | c2-m4             | 2               | 4       |
  | c4-m8             | 4               | 8       |
  | c8-m16            | 8               | 16      |
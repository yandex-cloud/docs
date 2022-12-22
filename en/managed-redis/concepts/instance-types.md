---
title: "{{ mrd-name }} host classes"
description: "The host class determines the computing power allocated for each host in the Redis cluster. When you change the host class for a cluster, all existing hosts change to match it. The amount of memory allocated to a host is also determined by the maxmemory configuration parameter for Redis hosts: the max amount of data is 75% of the available memory."
---

# Host classes

The host class determines the computing power allocated for each host in the cluster. When you change the class for a cluster, all existing hosts change to match it.

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the maximum amount of data is {{ mrd-memory-used }} of the available memory. For more information, see [{#T}](memory-management.md).

{% endnote %}


The host class affects the list of available [disk types](./storage.md):

* **hm1**: `network-ssd`, `local-ssd`.
* **hm2**: `network-ssd`, `local-ssd`, `network-ssd-nonreplicated`.
* **hm3**: `network-ssd`, `network-ssd-nonreplicated`.
* **b1**, **b2**, **b3**: `network-ssd`.


The storage space available to the host should be at least two times more than the selected memory size. {{ mrd-name }} technical and organizational limits are given in [{#T}](limits.md).

## Available host classes {#available-flavors}


Configuration types:

* **burstable**: Configurations with a [guaranteed vCPU share](../../compute/concepts/performance-levels.md) under 100%. Those host classes are intended for test loads. We don't recommend using them for production solutions.

   A cluster with this configuration type can only contain one host per cluster or [shard](./sharding.md).

* **high-memory**: Standard configurations for {{ RD }}.

   A cluster with this configuration type may contain several hosts (between 1 and the current [quota](./limits.md)) per cluster or shard. The minimum number of hosts in a cluster [depends](./limits.md#mrd-limits) on the [selected disk type](./storage.md).

| Host class name | Number of CPUs | RAM, GB | CPU performance | Disk <br>size, GB |
|-------------------|----------------|---------|------------------------|----------------------|
| **Intel Broadwell** |
| b1.nano | 2 | 2 | 5% | 4 - 16 |
| b1.small | 2 | 4 | 20% | 8 - 32 |
| hm1.nano | 2 | 8 | 100% | 16 - 64 |
| hm1.micro | 2 | 12 | 100% | 24 - 96 |
| hm1.small | 2 | 16 | 100% | 32 - 128 |
| hm1.medium | 4 | 24 | 100% | 48 - 192 |
| hm1.large | 4 | 32 | 100% | 64 - 256 |
| hm1.xlarge | 4 | 48 | 100% | 96 - 384 |
| hm1.2xlarge | 4 | 64 | 100% | 128 - 512 |
| hm1.3xlarge | 4 | 80 | 100% | 160 - 640 |
| hm1.4xlarge | 8 | 96 | 100% | 192 - 768 |
| hm1.5xlarge | 8 | 128 | 100% | 256 - 1024 |
| hm1.6xlarge | 8 | 160 | 100% | 320 - 1280 |
| hm1.7xlarge | 8 | 192 | 100% | 384 - 1536 |
| hm1.8xlarge | 8 | 224 | 100% | 448 - 1792 |
| hm1.9xlarge | 8 | 256 | 100% | 512 - 2048 |
| **Intel Cascade Lake** |
| b2.nano | 2 | 2 | 5% | 4 - 16 |
| b2.medium | 2 | 4 | 50% | 8 - 32 |
| hm2.nano | 2 | 8 | 100% | 16 - 64 |
| hm2.micro | 2 | 12 | 100% | 24 - 96 |
| hm2.small | 4 | 16 | 100% | 32 - 128 |
| hm2.medium | 4 | 24 | 100% | 48 - 192 |
| hm2.large | 4 | 32 | 100% | 64 - 256 |
| hm2.xlarge | 4 | 48 | 100% | 96 - 384 |
| hm2.96xlarge | 6 | 96 | 100% | 192 - 768 |
| hm2.128xlarge | 8 | 128 | 100% | 256 - 1024 |
| hm2.160xlarge | 10 | 160 | 100% | 320 - 1280 |
| hm2.192xlarge | 12 | 192 | 100% | 384 - 1536 |
| hm2.224xlarge | 14 | 224 | 100% | 448 - 1792 |
| hm2.256xlarge | 16 | 256 | 100% | 512 - 2048 |
| hm2.320xlarge | 20 | 320 | 100% | 640 - 2048 |
| hm2.384xlarge | 24 | 384 | 100% | 768 - 2048 |
| hm2.448xlarge | 28 | 448 | 100% | 896 - 2048 |
| hm2.512xlarge | 32 | 512 | 100% | 1024 - 2048 |
| **Intel Ice Lake** |
| b3-c1-m4 | 2 | 4 | 50% | 8 - 32 |
| hm3-c2-m8 | 2 | 8 | 100% | 16 - 64 |
| hm3-c2-m12 | 2 | 12 | 100% | 24 - 96 |
| hm3-c4-m16 | 4 | 16 | 100% | 32 - 128 |
| hm3-c4-m24 | 4 | 24 | 100% | 48 - 192 |
| hm3-c4-m32 | 4 | 32 | 100% | 64 - 256 |
| hm3-c4-m48 | 4 | 48 | 100% | 96 - 384 |
| hm3-c6-m60 | 6 | 60 | 100% | 120 - 480 |
| hm3-c6-m78 | 6 | 78 | 100% | 156 - 624 |
| hm3-c6-m96 | 6 | 96 | 100% | 192 - 768 |
| hm3-c8-m128 | 8 | 128 | 100% | 256 - 1024 |
| hm3-c12-m192 | 12 | 192 | 100% | 384 - 1536 |
| hm3-c14-m224 | 14 | 224 | 100% | 448 - 1792 |
| hm3-c16-m256 | 16 | 256 | 100% | 512 - 2048 |
| hm3-c20-m320 | 20 | 320 | 100% | 640 - 2048 |
| hm3-c24-m384 | 24 | 384 | 100% | 768 - 2048 |
| hm3-c28-m448 | 28 | 448 | 100% | 896 - 2048 |
| hm3-c32-m512 | 32 | 512 | 100% | 1024 - 2048 |


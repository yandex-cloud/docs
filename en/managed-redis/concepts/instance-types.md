---
title: '{{ mrd-name }} host classes'
description: 'The host class determines the computing power allocated for each host in a Valkey™ cluster. When you change the host class for a cluster, all existing hosts change accordingly. The amount of memory allocated to a host also depends on the maxmemory configuration parameter for Valkey™ hosts: the maximum amount of data equals 75% of available memory.'
---

# {{ VLK }} host classes


The host class determines the computing power allocated for each host in a cluster. When you change the class for a cluster, all existing hosts change to match it.

{% note info %}

The amount of memory allocated to a host also depends on the `maxmemory` configuration parameter for {{ VLK }} hosts: the maximum amount of data equals {{ mrd-memory-used }} of available memory. For more information, see [Memory management](memory-management.md).

{% endnote %}


The host class determines the available [disk types](./storage.md):

* **hm1**: `network-ssd`, `local-ssd`.
* **hm2**, **hm3**: `network-ssd`, `local-ssd`, `network-ssd-nonreplicated`, `network-ssd-io-m3`.
* **b2**, **b3**: `network-ssd`.


The storage space available to the host should be at least twice as large as the selected memory size. For more information on {{ mrd-name }} technical and organizational limitations, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}


Configuration types:

* **burstable**: Configurations with a [guaranteed vCPU share](../../compute/concepts/performance-levels.md) under 100%. Those host classes are intended for test loads. We do not recommend using them for production solutions.

    A cluster with this configuration type can only contain one host per cluster or [shard](./sharding.md).

* **high-memory**: Standard configurations for {{ VLK }}.

    A cluster with this configuration type may contain one or more hosts (within the current [quota](./limits.md)) per cluster or shard. The minimum number of hosts per cluster [depends](./limits.md#mrd-limits) on the [selected disk type](./storage.md).

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [burstable-hosts-deprecation-2023](../../_includes/mdb/burstable-hosts-deprecation-2023.md) %}

| Host class name | Number of CPUs | RAM, GB | CPU performance | Disk <br>size, GB |
|-------------------|----------------|---------|------------------------|----------------------|
| **Intel Broadwell**                                                                          |
| hm1.nano          | 2              | 8       | 100%                   | 16 - 4,096            |
| hm1.micro         | 2              | 12      | 100%                   | 24 - 4,096            |
| hm1.small         | 2              | 16      | 100%                   | 32 - 4,096            |
| hm1.medium        | 4              | 24      | 100%                   | 48 - 4,096            |
| hm1.large         | 4              | 32      | 100%                   | 64 - 4,096            |
| hm1.xlarge        | 4              | 48      | 100%                   | 96 - 4,096            |
| hm1.2xlarge       | 4              | 64      | 100%                   | 128 - 4,096           |
| hm1.3xlarge       | 4              | 80      | 100%                   | 160 - 4,096           |
| hm1.4xlarge       | 8              | 96      | 100%                   | 192 - 4,096           |
| hm1.5xlarge       | 8              | 128     | 100%                   | 256 - 4,096           |
| hm1.6xlarge       | 8              | 160     | 100%                   | 320 - 4,096           |
| hm1.7xlarge       | 8              | 192     | 100%                   | 384 - 4,096           |
| hm1.8xlarge       | 8              | 224     | 100%                   | 448 - 4,096           |
| hm1.9xlarge       | 8              | 256     | 100%                   | 512 - 4,096           |
| **Intel Cascade Lake**                                                                       |
| b2.medium         | 2              | 4       | 50%                    | 8 - 32               |
| hm2.nano          | 2              | 8       | 100%                   | 16 - 8,184            |
| hm2.micro         | 2              | 12      | 100%                   | 24 - 8,184            |
| hm2.small         | 4              | 16      | 100%                   | 32 - 8,184            |
| hm2.medium        | 4              | 24      | 100%                   | 48 - 8,184            |
| hm2.large         | 4              | 32      | 100%                   | 64 - 8,184            |
| hm2.xlarge        | 4              | 48      | 100%                   | 96 - 8,184            |
| hm2.96xlarge      | 6              | 96      | 100%                   | 192 - 8,184           |
| hm2.128xlarge     | 8              | 128     | 100%                   | 256 - 8,184           |
| hm2.160xlarge     | 10             | 160     | 100%                   | 320 - 8,184           |
| hm2.192xlarge     | 12             | 192     | 100%                   | 384 - 8,184           |
| hm2.224xlarge     | 14             | 224     | 100%                   | 448 - 8,184           |
| hm2.256xlarge     | 16             | 256     | 100%                   | 512 - 8,184           |
| hm2.320xlarge     | 20             | 320     | 100%                   | 640 - 8,184           |
| hm2.384xlarge     | 24             | 384     | 100%                   | 768 - 8,184           |
| hm2.448xlarge     | 28             | 448     | 100%                   | 896 - 8,184           |
| hm2.512xlarge     | 32             | 512     | 100%                   | 1024 - 8,184          |
| **Intel Ice Lake**                                                                           |
| b3-c1-m4          | 2              | 4       | 50%                    | 8 - 32               |
| hm3-c2-m8         | 2              | 8       | 100%                   | 16 - 8,184            |
| hm3-c2-m12        | 2              | 12      | 100%                   | 24 - 8,184            |
| hm3-c4-m16        | 4              | 16      | 100%                   | 32 - 8,184            |
| hm3-c4-m24        | 4              | 24      | 100%                   | 48 - 8,184            |
| hm3-c4-m32        | 4              | 32      | 100%                   | 64 - 8,184            |
| hm3-c4-m48        | 4              | 48      | 100%                   | 96 - 8,184            |
| hm3-c6-m60        | 6              | 60      | 100%                   | 120 - 8,184           |
| hm3-c6-m78        | 6              | 78      | 100%                   | 156 - 8,184           |
| hm3-c6-m96        | 6              | 96      | 100%                   | 192 - 8,184           |
| hm3-c8-m128       | 8              | 128     | 100%                   | 256 - 8,184           |
| hm3-c12-m192      | 12             | 192     | 100%                   | 384 - 8,184           |
| hm3-c14-m224      | 14             | 224     | 100%                   | 448 - 8,184           |
| hm3-c16-m256      | 16             | 256     | 100%                   | 512 - 8,184           |
| hm3-c20-m320      | 20             | 320     | 100%                   | 640 - 8,184           |
| **AMD Zen 4**                                                                                |
| m4a-c2-m16        | 2              | 16      | 100%                   | 32 - 8,184            |
| m4a-c4-m32        | 4              | 32      | 100%                   | 64 - 8,184            |
| m4a-c8-m64        | 8              | 64      | 100%                   | 128 - 8,184           |
| m4a-c16-m128      | 16             | 128     | 100%                   | 256 - 8,184           |
| m4a-c32-m256      | 32             | 256     | 100%                   | 512 - 8,184           |
| m4a-c64-m512      | 64             | 512     | 100%                   | 930 - 8,184           |
| m4a-c96-m768      | 96             | 768     | 100%                   | 1,536 - 8,184          |
| m4a-c128-m1024    | 128            | 1,024    | 100%                   | 2,048 - 8,184         |
| m4a-c224-m1792    | 224            | 1,792    | 100%                   | 3,534 - 8,184         |
| **AMD Zen 4 HighFreq**                                                                       |
| m4af-c2-m16       | 2              | 16      | 100%                   | 32 - 8,184            |
| m4af-c4-m32       | 4              | 32      | 100%                   | 64 - 8,184            |
| m4af-c8-m64       | 8              | 64      | 100%                   | 128 - 8,184           |
| m4af-c16-m128     | 16             | 128     | 100%                   | 256 - 8,184           |
| m4af-c32-m256     | 32             | 256     | 100%                   | 512 - 8,184           |
| m4af-c48-m384     | 48             | 384     | 100%                   | 768 - 8,184           |
| m4af-c80-m640     | 80             | 640     | 100%                   | 1,280 - 8,184          |
| hm4af-c2-m20      | 2              | 20      | 100%                   | 40 - 8,184            |
| hm4af-c2-m24      | 2              | 24      | 100%                   | 48 - 8,184            |
| hm4af-c4-m40      | 4              | 40      | 100%                   | 80 - 8,184            |
| hm4af-c4-m48      | 4              | 48      | 100%                   | 93 - 8,184            |
| hm4af-c8-m80      | 8              | 80      | 100%                   | 160 - 8,184           |
| hm4af-c8-m96      | 8              | 96      | 100%                   | 186 - 8,184           |
| hm4af-c16-m160    | 16             | 160     | 100%                   | 279 - 8,184           |
| hm4af-c16-m192    | 16             | 192     | 100%                   | 384 - 8,184           |
| hm4af-c32-m320    | 32             | 320     | 100%                   | 640 - 8,184           |
| hm4af-c32-m384    | 32             | 384     | 100%                   | 768 - 8,184           |
| hm4af-c48-m480    | 48             | 480     | 100%                   | 930 - 8,184           |
| hm4af-c48-m576    | 48             | 576     | 100%                   | 1,152 - 8,184          |
| hm4af-c80-m800    | 80             | 800     | 100%                   | 1,600 - 8,184          |
| hm4af-c80-m960    | 80             | 960     | 100%                   | 1,860 - 8,184          |


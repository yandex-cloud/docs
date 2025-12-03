---
title: '{{ mkf-name }} host classes'
description: The host class determines the computing power allocated for each host in the Apache Kafka cluster. When you change the host class for a cluster, all existing hosts change accordingly. The available storage size does not depend on the host class.
---

# {{ KF }} host classes


The host class determines the computing power allocated for each host in a cluster. When you change the host class for a cluster, all existing hosts change to match it.


The host class determines the available [disk types](./storage.md):

* **s2**, **m2**, **s3**, **m3**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`, `network-ssd-io-m3`.
* **b2**, **b3**: `network-ssd`, `network-hdd`.

The available storage size does not depend on the host class. For storage limitations, see [Quotas and limits](limits.md).


## Available host classes {#available-flavors}


Hosts in {{ mkf-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any platforms {{ compute-name }} supports. To learn more about the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

{% note info %}

For cluster hosts residing in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md), you cannot use local SSD storage if you select Intel Cascade Lake.

{% endnote %}

{% include [instance-types-code](../../_includes/mdb/mkf-instance-types-code.md) %}

| Host class name | Number of vCPUs | Guaranteed vCPU share | RAM, GB | Disk <br>size, GB |
|-------------------|-----------------|---------------------------|---------|----------------------|
| **Intel Cascade Lake**                                                                           |
| b2.medium         | 2               | 50%                       | 4       | 10 - 8,192             |
| m2.micro          | 2               | 100%                      | 16      | 10 - 32,736           |
| m2.small          | 4               | 100%                      | 32      | 10 - 32,736           |
| m2.medium         | 6               | 100%                      | 48      | 10 - 32,736           |
| m2.large          | 8               | 100%                      | 64      | 10 - 32,736           |
| m2.xlarge         | 12              | 100%                      | 96      | 10 - 32,736           |
| m2.2xlarge        | 16              | 100%                      | 128     | 10 - 32,736           |
| m2.3xlarge        | 24              | 100%                      | 192     | 10 - 32,736           |
| m2.4xlarge        | 32              | 100%                      | 256     | 10 - 32,736           |
| m2.5xlarge        | 40              | 100%                      | 320     | 10 - 32,736           |
| m2.6xlarge        | 48              | 100%                      | 384     | 10 - 32,736           |
| m2.7xlarge        | 56              | 100%                      | 448     | 10 - 32,736           |
| m2.8xlarge        | 64              | 100%                      | 512     | 10 - 32,736           |
| s2.micro          | 2               | 100%                      | 8       | 10 - 32,736           |
| s2.small          | 4               | 100%                      | 16      | 10 - 32,736           |
| s2.medium         | 8               | 100%                      | 32      | 10 - 32,736           |
| s2.large          | 12              | 100%                      | 48      | 10 - 32,736           |
| s2.xlarge         | 16              | 100%                      | 64      | 10 - 32,736           |
| s2.2xlarge        | 24              | 100%                      | 96      | 10 - 32,736           |
| s2.3xlarge        | 32              | 100%                      | 128     | 10 - 32,736           |
| s2.4xlarge        | 40              | 100%                      | 160     | 10 - 32,736           |
| s2.5xlarge        | 48              | 100%                      | 192     | 10 - 32,736           |
| s2.6xlarge        | 64              | 100%                      | 256     | 10 - 32,736           |
| **Intel Ice Lake**                                                                               |
| b3-c1-m4          | 2               | 50%                       | 4       | 10 - 8,192             |
| s3-c2-m8          | 2               | 100%                      | 8       | 10 - 32,736           |
| s3-c4-m16         | 4               | 100%                      | 16      | 10 - 32,736           |
| s3-c8-m32         | 8               | 100%                      | 32      | 10 - 32,736           |
| s3-c12-m48        | 12              | 100%                      | 48      | 10 - 32,736           |
| s3-c16-m64        | 16              | 100%                      | 64      | 10 - 32,736           |
| s3-c24-m96        | 24              | 100%                      | 96      | 10 - 32,736           |
| s3-c32-m128       | 32              | 100%                      | 128     | 10 - 32,736           |
| s3-c40-m160       | 40              | 100%                      | 160     | 10 - 32,736           |
| s3-c48-m192       | 48              | 100%                      | 192     | 10 - 32,736           |
| s3-c64-m256       | 64              | 100%                      | 256     | 10 - 32,736           |
| s3-c80-m320       | 80              | 100%                      | 320     | 10 - 32,736           |
| s3-c96-m576       | 96              | 100%                      | 576     | 10 - 32,736           |
| m3-c2-m16         | 2               | 100%                      | 16      | 10 - 32,736           |
| m3-c4-m32         | 4               | 100%                      | 32      | 10 - 32,736           |
| m3-c6-m48         | 6               | 100%                      | 48      | 10 - 32,736           |
| m3-c8-m64         | 8               | 100%                      | 64      | 10 - 32,736           |
| m3-c12-m96        | 12              | 100%                      | 96      | 10 - 32,736           |
| m3-c16-m128       | 16              | 100%                      | 128     | 10 - 32,736           |
| m3-c24-m192       | 24              | 100%                      | 192     | 10 - 32,736           |
| m3-c32-m256       | 32              | 100%                      | 256     | 10 - 32,736           |
| m3-c40-m320       | 40              | 100%                      | 320     | 10 - 32,736           |
| m3-c48-m384       | 48              | 100%                      | 384     | 10 - 32,736           |
| m3-c56-m448       | 56              | 100%                      | 448     | 10 - 32,736           |
| m3-c64-m512       | 64              | 100%                      | 512     | 10 - 32,736           |
| m3-c80-m640       | 80              | 100%                      | 640     | 10 - 32,736           |
| **AMD Zen 4**                                                                                    |
| s4a-c2-m8         | 2               | 100%                      | 8       | 10 - 32,768           |
| s4a-c4-m16        | 4               | 100%                      | 16      | 10 - 32,768           |
| s4a-c8-m32        | 8               | 100%                      | 32      | 10 - 32,768           |
| s4a-c16-m64       | 16              | 100%                      | 64      | 10 - 32,768           |
| s4a-c32-m128      | 32              | 100%                      | 128     | 10 - 32,768           |
| s4a-c64-m256      | 64              | 100%                      | 256     | 10 - 32,768           |
| s4a-c96-m384      | 96              | 100%                      | 384     | 10 - 32,768           |
| s4a-c128-m512     | 128             | 100%                      | 512     | 10 - 32,768           |
| s4a-c224-m896     | 224             | 100%                      | 896     | 10 - 32,768           |
| s4a-c256-m1024    | 256             | 100%                      | 1 024   | 10 - 32,768           |
| m4a-c2-m16        | 2               | 100%                      | 16      | 10 - 32,768           |
| m4a-c4-m32        | 4               | 100%                      | 32      | 10 - 32,768           |
| m4a-c8-m64        | 8               | 100%                      | 64      | 10 - 32,768           |
| m4a-c16-m128      | 16              | 100%                      | 128     | 10 - 32,768           |
| m4a-c32-m256      | 32              | 100%                      | 256     | 10 - 32,768           |
| m4a-c64-m512      | 64              | 100%                      | 512     | 10 - 32,768           |
| m4a-c96-m768      | 96              | 100%                      | 768     | 10 - 32,768           |
| m4a-c128-m1024    | 128             | 100%                      | 1 024   | 10 - 32,768           |
| m4a-c224-m1792    | 224             | 100%                      | 1 792   | 10 - 32,768           |
| **AMD Zen 4 HighFreq**                                                                          |
| s4af-c2-m8        | 2               | 100%                      | 8       | 10 - 32,768           |
| s4af-c4-m16       | 4               | 100%                      | 16      | 10 - 32,768           |
| s4af-c8-m32       | 8               | 100%                      | 32      | 10 - 32,768           |
| s4af-c16-m64      | 16              | 100%                      | 64      | 10 - 32,768           |
| s4af-c32-m128     | 32              | 100%                      | 128     | 10 - 32,768           |
| s4af-c48-m192     | 48              | 100%                      | 192     | 10 - 32,768           |
| s4af-c80-m320     | 80              | 100%                      | 320     | 10 - 32,768           |
| m4af-c2-m16       | 2               | 100%                      | 16      | 10 - 32,768           |
| m4af-c4-m32       | 4               | 100%                      | 32      | 10 - 32,768           |
| m4af-c8-m64       | 8               | 100%                      | 64      | 10 - 32,768           |
| m4af-c16-m128     | 16              | 100%                      | 128     | 10 - 32,768           |
| m4af-c32-m256     | 32              | 100%                      | 256     | 10 - 32,768           |
| m4af-c48-m384     | 48              | 100%                      | 384     | 10 - 32,768           |
| m4af-c80-m640     | 80              | 100%                      | 640     | 10 - 32,768           |


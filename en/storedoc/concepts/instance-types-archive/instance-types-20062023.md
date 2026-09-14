---
title: '{{ mmg-name }} host classes before June 20, 2023'
description: The host class determines the computing power allocated for each host in a {{ SD }} cluster. {{ mmg-name }} host classes before June 20, 2023.
---

# {{ SD }} host classes before June 20, 2023

The host class determines the computing power allocated for each host in a cluster. When you change the host class for a cluster, all existing hosts change accordingly.


The host class determines the available [disk types](.././storage.md):

* **s1**, **s2**, **m2**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`.
* **c3**, **s3**, **m3**: `network-ssd`, `network-hdd`, `network-ssd-nonreplicated`.
* **b1**, **b2**, **b3**: `network-ssd`, `network-hdd`.

For storage size limitations, see [Quotas and limits](../limits.md).


## Available host classes {#available-flavors}


Hosts in {{ mmg-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any platforms {{ compute-name }} supports. To learn more about the platforms, see [{#T}](../../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

Configuration types:

* **s1**, **s2**, **s3**: Standard configurations with 4:1 RAM GB to vCPU ratio.
* **m1**, **m2**, **m3**: Configurations with an increased RAM GB to vCPU ratio (8:1). These configurations are well suited for clusters with high cache requirements.
* **c3**: Configurations with a reduced RAM GB to vCPU ratio (2:1). These configurations may be useful for clusters with higher processor performance requirements.
* **b1**, **b2**, **b3**: Configurations with a guaranteed vCPU share under 100%. This host class is intended for test workloads. The minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 50%.

| Host class name | Number of CPUs | CPU performance | RAM, GB | Disk <br>size, GB |
|-------------------|----------------|------------------------|---------|----------------------|
| **Intel Broadwell**                                                                          |
| b1.nano           | 2              | 5%                     | 2       | 10 - 25              |
| b1.micro          | 2              | 20%                    | 2       | 10 - 50              |
| b1.medium         | 2              | 50%                    | 4       | 10 - 512             |
| s1.micro          | 2              | 100%                   | 8       | 10 - 2232            |
| s1.small          | 4              | 100%                   | 16      | 10 - 2232            |
| s1.medium         | 8              | 100%                   | 32      | 10 - 2232            |
| s1.large          | 16             | 100%                   | 64      | 10 - 2232            |
| s1.xlarge         | 32             | 100%                   | 128     | 10 - 2232            |
| **Intel Cascade Lake**                                                                       |
| b2.nano           | 2              | 5%                     | 2       | 10 - 25              |
| b2.micro          | 2              | 20%                    | 2       | 10 - 50              |
| b2.medium         | 2              | 50%                    | 4       | 10 - 512             |
| m2.micro          | 2              | 100%                   | 16      | 10 - 2232            |
| m2.small          | 4              | 100%                   | 32      | 10 - 2232            |
| m2.medium         | 6              | 100%                   | 48      | 10 - 2232            |
| m2.large          | 8              | 100%                   | 64      | 10 - 2232            |
| m2.xlarge         | 12             | 100%                   | 96      | 10 - 2232            |
| m2.2xlarge        | 16             | 100%                   | 128     | 10 - 2232            |
| m2.3xlarge        | 24             | 100%                   | 192     | 10 - 2232            |
| m2.4xlarge        | 32             | 100%                   | 256     | 10 - 2232            |
| m2.5xlarge        | 40             | 100%                   | 320     | 10 - 2232            |
| m2.6xlarge        | 48             | 100%                   | 384     | 10 - 2232            |
| m2.7xlarge        | 56             | 100%                   | 448     | 10 - 2232            |
| m2.8xlarge        | 64             | 100%                   | 512     | 10 - 2232            |
| s2.micro          | 2              | 100%                   | 8       | 10 - 2232            |
| s2.small          | 4              | 100%                   | 16      | 10 - 2232            |
| s2.medium         | 8              | 100%                   | 32      | 10 - 2232            |
| s2.large          | 12             | 100%                   | 48      | 10 - 2232            |
| s2.xlarge         | 16             | 100%                   | 64      | 10 - 2232            |
| s2.2xlarge        | 24             | 100%                   | 96      | 10 - 2232            |
| s2.3xlarge        | 32             | 100%                   | 128     | 10 - 2232            |
| s2.4xlarge        | 40             | 100%                   | 160     | 10 - 2232            |
| s2.5xlarge        | 48             | 100%                   | 192     | 10 - 2232            |
| s2.6xlarge        | 64             | 100%                   | 256     | 10 - 2232            |
| **Intel Ice Lake**                                                                           |
| b3-c1-m4          | 2              | 50%                    | 4       | 10 - 512             |
| s3-c2-m8          | 2              | 100%                   | 8       | 10 - 2232            |
| s3-c4-m16         | 4              | 100%                   | 16      | 10 - 2232            |
| s3-c8-m32         | 8              | 100%                   | 32      | 10 - 2232            |
| s3-c12-m48        | 12             | 100%                   | 48      | 10 - 2232            |
| s3-c16-m64        | 16             | 100%                   | 64      | 10 - 2232            |
| s3-c24-m96        | 24             | 100%                   | 96      | 10 - 2232            |
| s3-c32-m128       | 32             | 100%                   | 128     | 10 - 2232            |
| s3-c40-m160       | 40             | 100%                   | 160     | 10 - 2232            |
| s3-c48-m192       | 48             | 100%                   | 192     | 10 - 2232            |
| s3-c64-m256       | 64             | 100%                   | 256     | 10 - 2232            |
| s3-c80-m320       | 80             | 100%                   | 320     | 10 - 2232            |
| s3-c96-m576       | 96             | 100%                   | 576     | 10 - 2232            |
| m3-c2-m16         | 2              | 100%                   | 16      | 10 - 2232            |
| m3-c4-m32         | 4              | 100%                   | 32      | 10 - 2232            |
| m3-c6-m48         | 6              | 100%                   | 48      | 10 - 2232            |
| m3-c8-m64         | 8              | 100%                   | 64      | 10 - 2232            |
| m3-c12-m96        | 12             | 100%                   | 96      | 10 - 2232            |
| m3-c16-m128       | 16             | 100%                   | 128     | 10 - 2232            |
| m3-c24-m192       | 24             | 100%                   | 192     | 10 - 2232            |
| m3-c32-m256       | 32             | 100%                   | 256     | 10 - 2232            |
| m3-c40-m320       | 40             | 100%                   | 320     | 10 - 2232            |
| m3-c48-m384       | 48             | 100%                   | 384     | 10 - 2232            |
| m3-c56-m448       | 56             | 100%                   | 448     | 10 - 2232            |
| m3-c64-m512       | 64             | 100%                   | 512     | 10 - 2232            |
| m3-c80-m640       | 80             | 100%                   | 640     | 10 - 2232            |
| c3-c2-m4          | 2              | 100%                   | 4       | 10 - 2232            |
| c3-c4-m8          | 4              | 100%                   | 8       | 10 - 2232            |
| c3-c8-m16         | 8              | 100%                   | 16      | 10 - 2232            |
| c3-c12-m24        | 12             | 100%                   | 24      | 10 - 2232            |
| c3-c16-m32        | 16             | 100%                   | 32      | 10 - 2232            |
| c3-c24-m48        | 24             | 100%                   | 48      | 10 - 2232            |
| c3-c32-m64        | 32             | 100%                   | 64      | 10 - 2232            |
| c3-c40-m80        | 40             | 100%                   | 80      | 10 - 2232            |
| c3-c48-m96        | 48             | 100%                   | 96      | 10 - 2232            |
| c3-c64-m128       | 64             | 100%                   | 128     | 10 - 2232            |
| c3-c80-m160       | 80             | 100%                   | 160     | 10 - 2232            |
| c3-c96-m192       | 96             | 100%                   | 192     | 10 - 2232            |


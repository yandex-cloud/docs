---
title: "Managed Service for SQL Server host classes"
description: "The host class defines the processing power that is allocated to each host in the SQL Server cluster. Changing the host class for the cluster changes the characteristics of all hosts already created in it."
---

# Host classes

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match it.

The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).

## Available host classes {#available-flavors}


Hosts in {{ mms-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below:

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1).
* **hm2**, **hm3**: Configurations with a significant predominance of the number of GB RAM over the number of vCPUs (up to 32:1).

Configurations **m2**, **m3**, **hm2** and **hm3** can be useful for clusters with higher cache requirements.

| Host class name | Number of CPUs | CPU performance | RAM, GB |
|-----------------|----------------|-----------------|---------|
| **Intel Cascade Lake**                                       |
| m2.small        | 4              | 100%            | 32      |
| m2.medium       | 6              | 100%            | 48      |
| m2.large        | 8              | 100%            | 64      |
| m2.xlarge       | 12             | 100%            | 96      |
| m2.2xlarge      | 16             | 100%            | 128     |
| m2.3xlarge      | 24             | 100%            | 192     |
| m2.4xlarge      | 32             | 100%            | 256     |
| m2.5xlarge      | 40             | 100%            | 320     |
| m2.6xlarge      | 48             | 100%            | 384     |
| m2.7xlarge      | 56             | 100%            | 448     |
| m2.8xlarge      | 64             | 100%            | 512     |
| s2.small        | 4              | 100%            | 16      |
| s2.medium       | 8              | 100%            | 32      |
| s2.large        | 12             | 100%            | 48      |
| s2.xlarge       | 16             | 100%            | 64      |
| s2.2xlarge      | 24             | 100%            | 96      |
| s2.3xlarge      | 32             | 100%            | 128     |
| s2.4xlarge      | 40             | 100%            | 160     |
| s2.5xlarge      | 48             | 100%            | 192     |
| s2.6xlarge      | 64             | 100%            | 256     |
| hm2.small       | 4              | 100%            | 16      |
| hm2.medium      | 4              | 100%            | 24      |
| hm2.large       | 4              | 100%            | 32      |
| hm2.xlarge      | 4              | 100%            | 48      |
| hm2.96xlarge    | 6              | 100%            | 96      |
| hm2.128xlarge   | 8              | 100%            | 128     |
| hm2.160xlarge   | 10             | 100%            | 160     |
| hm2.192xlarge   | 12             | 100%            | 192     |
| hm2.224xlarge   | 14             | 100%            | 224     |
| hm2.256xlarge   | 16             | 100%            | 256     |
| hm2.320xlarge   | 20             | 100%            | 320     |
| hm2.384xlarge   | 24             | 100%            | 384     |
| hm2.448xlarge   | 28             | 100%            | 448     |
| hm2.512xlarge   | 32             | 100%            | 512     |
| **Intel Ice Lake**                                           |
| s3-c4-m16       | 4              | 100%            | 16      |
| s3-c8-m32       | 8              | 100%            | 32      |
| s3-c12-m48      | 12             | 100%            | 48      |
| s3-c16-m64      | 16             | 100%            | 64      |
| s3-c24-m96      | 24             | 100%            | 96      |
| s3-c32-m128     | 32             | 100%            | 128     |
| s3-c40-m160     | 40             | 100%            | 160     |
| s3-c48-m192     | 48             | 100%            | 192     |
| s3-c64-m256     | 64             | 100%            | 256     |
| s3-c80-m320     | 80             | 100%            | 320     |
| s3-c96-m576     | 96             | 100%            | 576     |
| m3-c4-m32       | 4              | 100%            | 32      |
| m3-c6-m48       | 6              | 100%            | 48      |
| m3-c8-m64       | 8              | 100%            | 64      |
| m3-c12-m96      | 12             | 100%            | 96      |
| m3-c16-m128     | 16             | 100%            | 128     |
| m3-c24-m192     | 24             | 100%            | 192     |
| m3-c32-m256     | 32             | 100%            | 256     |
| m3-c40-m320     | 40             | 100%            | 320     |
| m3-c48-m384     | 48             | 100%            | 384     |
| m3-c56-m448     | 56             | 100%            | 448     |
| m3-c64-m512     | 64             | 100%            | 512     |
| m3-c80-m640     | 80             | 100%            | 640     |
| hm3-c4-m16      | 4              | 100%            | 16      |
| hm3-c4-m24      | 4              | 100%            | 24      |
| hm3-c4-m32      | 4              | 100%            | 32      |
| hm3-c4-m48      | 4              | 100%            | 48      |
| hm3-c6-m60      | 6              | 100%            | 60      |
| hm3-c6-m78      | 6              | 100%            | 78      |
| hm3-c6-m96      | 6              | 100%            | 96      |
| hm3-c8-m128     | 8              | 100%            | 128     |
| hm3-c8-m160     | 8              | 100%            | 160     |
| hm3-c12-m192    | 12             | 100%            | 192     |
| hm3-c14-m224    | 14             | 100%            | 224     |
| hm3-c16-m256    | 16             | 100%            | 256     |
| hm3-c20-m320    | 20             | 100%            | 320     |
| hm3-c24-m384    | 24             | 100%            | 384     |
| hm3-c28-m448    | 28             | 100%            | 448     |
| hm3-c32-m512    | 32             | 100%            | 512     |


---
title: "Elasticsearch host classes"
description: "The Elasticsearch host class determines the computing power allocated for each host with the specific role in the cluster. When you change the Elasticsearch host class for a role in the cluster, the characteristics change for all of the hosts with this role that were created earlier in the cluster."
keywords:
  - Elasticsearch host classes
  - Elasticsearch
---

# {{ ES }} host classes

The host class determines the computing power allocated for each host with the specific role in the cluster. When you change the host class for a role in the cluster, the characteristics change for all of the hosts with this role that were created earlier in the cluster. For more information about roles, see [{#T}](./index.md).

The host class with the [Data node role](./hosts-roles.md) affects the list of available [disk types](./storage.md):

* **s2**, **m2**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`.
* **s3**, **m3**: `network-ssd`, `network-hdd`, `network-ssd-nonreplicated`.

Only network SSD storage (`network-ssd`) is available for hosts with the Master node role.


The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).


## Available host classes {#available-flavors}


Hosts in {{ mes-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these virtual machines on any standard platform supported by {{ compute-name }}. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

{% include [instance-types-code](../../_includes/mdb/mes-instance-types-code.md) %}

| Host class name | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
|-------------------|-----------------|---------------------------|---------|
| **Intel Cascade Lake** |
| m2.micro | 2 | 100% | 16 |
| m2.small | 4 | 100% | 32 |
| m2.medium | 6 | 100% | 48 |
| m2.large | 8 | 100% | 64 |
| m2.xlarge | 12 | 100% | 96 |
| m2.2xlarge | 16 | 100% | 128 |
| m2.3xlarge | 24 | 100% | 192 |
| m2.4xlarge | 32 | 100% | 256 |
| m2.5xlarge | 40 | 100% | 320 |
| m2.6xlarge | 48 | 100% | 384 |
| m2.7xlarge | 56 | 100% | 448 |
| m2.8xlarge | 64 | 100% | 512 |
| s2.micro | 2 | 100% | 8 |
| s2.small | 4 | 100% | 16 |
| s2.medium | 8 | 100% | 32 |
| s2.large | 12 | 100% | 48 |
| s2.xlarge | 16 | 100% | 64 |
| s2.2xlarge | 24 | 100% | 96 |
| s2.3xlarge | 32 | 100% | 128 |
| s2.4xlarge | 40 | 100% | 160 |
| s2.5xlarge | 48 | 100% | 192 |
| s2.6xlarge | 64 | 100% | 256 |
| **Intel Ice Lake** |
| s3-c2-m8 | 2 | 100% | 8 |
| s3-c4-m16 | 4 | 100% | 16 |
| s3-c8-m32 | 8 | 100% | 32 |
| s3-c12-m48 | 12 | 100% | 48 |
| s3-c16-m64 | 16 | 100% | 64 |
| s3-c24-m96 | 24 | 100% | 96 |
| s3-c32-m128 | 32 | 100% | 128 |
| s3-c40-m160 | 40 | 100% | 160 |
| s3-c48-m192 | 48 | 100% | 192 |
| s3-c64-m256 | 64 | 100% | 256 |
| s3-c80-m320 | 80 | 100% | 320 |
| s3-c96-m576 | 96 | 100% | 576 |
| m3-c2-m16 | 2 | 100% | 16 |
| m3-c4-m32 | 4 | 100% | 32 |
| m3-c6-m48 | 6 | 100% | 48 |
| m3-c8-m64 | 8 | 100% | 64 |
| m3-c12-m96 | 12 | 100% | 96 |
| m3-c16-m128 | 16 | 100% | 128 |
| m3-c24-m192 | 24 | 100% | 192 |
| m3-c32-m256 | 32 | 100% | 256 |
| m3-c40-m320 | 40 | 100% | 320 |
| m3-c48-m384 | 48 | 100% | 384 |
| m3-c56-m448 | 56 | 100% | 448 |
| m3-c64-m512 | 64 | 100% | 512 |
| m3-c80-m640 | 80 | 100% | 640 |


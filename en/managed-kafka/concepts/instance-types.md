---
title: "{{ mkf-name }} host classes"
description: "The host class determines the computing power allocated for each host in the Apache Kafka cluster. When you change the host class for a cluster, all existing hosts change to match it. The available storage doesn't depend on the host class."
---

# Host classes in {{ KF }}

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match it.

{% if audience != "internal" %}

The host class affects the list of available [disk types](./storage.md):

* **s1**, **m1**: `local-ssd`.
* **s2**, **m2**, **s3**, **m3**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`.
* **b2**, **b3**: `network-ssd`, `network-hdd`.

The available storage does not depend on the host class. Storage restrictions are shown under [Quotas and limits in Managed Service for Apache Kafka®](limits.md).

{% endif %}

## Available host classes {#available-flavors}

{% if audience == "internal" %}

| Host class name | Number of CPUs | RAM, GB | I/O limit,<br> MB/s | Max. connection <br>speed, MB/s |
----- | ----- | ----- | ----- | -----
| **Sandy Bridge** |
| db1.nano | 1 | 2 | 5 | 16 |
| db1.micro | 1 | 8 | 20 | 16 |
| db1.small | 2 | 16 | 40 | 32 |
| db1.medium | 4 | 32 | 80 | 32 |
| db1.large | 8 | 64 | 160 | 64 |
| db1.xlarge | 16 | 128 | 320 | 128 |
| m1.micro | 1 | 8 | 20 | 16 |
| m1.small | 2 | 16 | 40 | 32 |
| m1.medium | 4 | 32 | 80 | 32 |
| m1.large | 8 | 64 | 160 | 64 |
| m1.xlarge | 16 | 128 | 320 | 128 |
| **Broadwell** |
| s2.nano | 1 | 4 | 16 | 16 |
| s2.micro | 2 | 8 | 32 | 32 |
| s2.small | 4 | 16 | 64 | 64 |
| s2.medium | 8 | 32 | 128 | 128 |
| s2.large | 12 | 48 | 192 | 192 |
| s2.xlarge | 16 | 64 | 256 | 256 |
| s2.2xlarge | 24 | 96 | 384 | 384 |
| s2.3xlarge | 32 | 128 | 512 | 512 |
| s2.4xlarge | 40 | 160 | 640 | 640 |
| m2.nano | 1 | 8 | 16 | 32 |
| m2.micro | 2 | 12 | 24 | 48 |
| m2.small | 2 | 16 | 32 | 64 |
| m2.medium | 4 | 24 | 48 | 96 |
| m2.large | 4 | 32 | 64 | 128 |
| m2.xlarge | 6 | 48 | 96 | 128 |
| m2.2xlarge | 8 | 64 | 128 | 256 |
| m2.3xlarge | 10 | 80 | 160 | 256 |
| m2.4xlarge | 12 | 96 | 192 | 256 |
| m2.5xlarge | 16 | 128 | 256 | 256 |
| m2.6xlarge | 20 | 160 | 256 | 320 |
| m2.7xlarge | 24 | 192 | 256 | 384 |
| Cascade Lake |
| s3.nano | 1 | 4 | 16 | 16 |
| s3.micro | 2 | 8 | 32 | 32 |
| s3.small | 4 | 16 | 64 | 64 |
| s3.medium | 8 | 32 | 128 | 128 |
| s3.large | 12 | 48 | 192 | 192 |
| s3.xlarge | 16 | 64 | 256 | 256 |
| s3.2xlarge | 24 | 96 | 384 | 384 |
| s3.3xlarge | 32 | 128 | 512 | 512 |
| s3.4xlarge | 40 | 160 | 640 | 640 |
| s3.5xlarge | 48 | 192 | 768 | 768 |
| s3.6xlarge | 64 | 256 | 1024 | 1024 |
| m3.nano | 1 | 8 | 16 | 32 |
| m3.micro | 2 | 12 | 24 | 48 |
| m3.small | 2 | 16 | 32 | 64 |
| m3.medium | 4 | 24 | 48 | 96 |
| m3.large | 4 | 32 | 64 | 128 |
| m3.xlarge | 6 | 48 | 96 | 128 |
| m3.2xlarge | 8 | 64 | 128 | 256 |
| m3.3xlarge | 10 | 80 | 160 | 256 |
| m3.4xlarge | 12 | 96 | 192 | 256 |
| m3.5xlarge | 16 | 128 | 256 | 256 |
| m3.6xlarge | 20 | 160 | 256 | 320 |
| m3.7xlarge | 24 | 192 | 256 | 384 |
| m3.8xlarge | 28 | 224 | 256 | 384 |
| m3.9xlarge | 32 | 256 | 256 | 512 |
| m3.10xlarge | 40 | 320 | 320 | 640 |
| m3.11xlarge | 48 | 384 | 384 | 768 |

{% else %}

Hosts in {{ mkf-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

{% include [instance-types-code](../../_includes/mdb/mkf-instance-types-code.md) %}

| Host class name | Number of vCPUs | Guaranteed vCPU performance | RAM, GB | Disk <br>size, GB |
|-------------------|-----------------|---------------------------|---------|----------------------|
{% if product == "yandex-cloud" %}| **Intel Broadwell** |
| s1.nano | 1 | 100% | 4 | 100 - 1500 |
| s1.micro | 2 | 100% | 8 | 100 - 1500 |
| s1.small | 4 | 100% | 16 | 100 - 1500 |
| s1.medium | 8 | 100% | 32 | 100 - 1500 |
| s1.large | 16 | 100% | 64 | 100 - 1500 |
| s1.xlarge | 32 | 100% | 128 | 100 - 1500 |
| m1.micro | 2 | 100% | 16 | 100 - 1500 |
| m1.small | 4 | 100% | 32 | 100 - 1500 |
| m1.medium | 6 | 100% | 48 | 100 - 1500 |
| m1.large | 8 | 100% | 64 | 100 - 1500 |
| m1.xlarge | 12 | 100% | 96 | 100 - 1500 |
| m1.2xlarge | 16 | 100% | 128 | 100 - 1500 |
| m1.3xlarge | 24 | 100% | 192 | 100 - 1500 |
| m1.4xlarge | 32 | 100% | 256 | 100 - 1500 |
| **Intel Cascade Lake** |
| b2.medium | 2 | 50% | 4 | 10 - 512 |
| m2.micro | 2 | 100% | 16 | 10 - 8184 |
| m2.small | 4 | 100% | 32 | 10 - 8184 |
| m2.medium | 6 | 100% | 48 | 10 - 8184 |
| m2.large | 8 | 100% | 64 | 10 - 8184 |
| m2.xlarge | 12 | 100% | 96 | 10 - 8184 |
| m2.2xlarge | 16 | 100% | 128 | 10 - 8184 |
| m2.3xlarge | 24 | 100% | 192 | 10 - 8184 |
| m2.4xlarge | 32 | 100% | 256 | 10 - 8184 |
| m2.5xlarge | 40 | 100% | 320 | 10 - 8184 |
| m2.6xlarge | 48 | 100% | 384 | 10 - 8184 |
| m2.7xlarge | 56 | 100% | 448 | 10 - 8184 |
| m2.8xlarge | 64 | 100% | 512 | 10 - 8184 |
| s2.micro | 2 | 100% | 8 | 10 - 8184 |
| s2.small | 4 | 100% | 16 | 10 - 8184 |
| s2.medium | 8 | 100% | 32 | 10 - 8184 |
| s2.large | 12 | 100% | 48 | 10 - 8184 |
| s2.xlarge | 16 | 100% | 64 | 10 - 8184 |
| s2.2xlarge | 24 | 100% | 96 | 10 - 8184 |
| s2.3xlarge | 32 | 100% | 128 | 10 - 8184 |
| s2.4xlarge | 40 | 100% | 160 | 10 - 8184 |
| s2.5xlarge | 48 | 100% | 192 | 10 - 8184 |
| s2.6xlarge | 64 | 100% | 256 | 10 - 8184 |{% endif %}
| **Intel Ice Lake** |
| b3-c1-m4 | 2 | 50% | 4 | 10 - 512 |
| s3-c2-m8 | 2 | 100% | 8 | 10 - 8184 |
| s3-c4-m16 | 4 | 100% | 16 | 10 - 8184 |
| s3-c8-m32 | 8 | 100% | 32 | 10 - 8184 |
| s3-c12-m48 | 12 | 100% | 48 | 10 - 8184 |
| s3-c16-m64 | 16 | 100% | 64 | 10 - 8184 |
| s3-c24-m96 | 24 | 100% | 96 | 10 - 8184 |
| s3-c32-m128 | 32 | 100% | 128 | 10 - 8184 |
| s3-c40-m160 | 40 | 100% | 160 | 10 - 8184 |
| s3-c48-m192 | 48 | 100% | 192 | 10 - 8184 |
| s3-c64-m256 | 64 | 100% | 256 | 10 - 8184 |
| s3-c80-m320 | 80 | 100% | 320 | 10 - 8184 |
| s3-c96-m576 | 96 | 100% | 576 | 10 - 8184 |
| m3-c2-m16 | 2 | 100% | 16 | 10 - 8184 |
| m3-c4-m32 | 4 | 100% | 32 | 10 - 8184 |
| m3-c6-m48 | 6 | 100% | 48 | 10 - 8184 |
| m3-c8-m64 | 8 | 100% | 64 | 10 - 8184 |
| m3-c12-m96 | 12 | 100% | 96 | 10 - 8184 |
| m3-c16-m128 | 16 | 100% | 128 | 10 - 8184 |
| m3-c24-m192 | 24 | 100% | 192 | 10 - 8184 |
| m3-c32-m256 | 32 | 100% | 256 | 10 - 8184 |
| m3-c40-m320 | 40 | 100% | 320 | 10 - 8184 |
| m3-c48-m384 | 48 | 100% | 384 | 10 - 8184 |
| m3-c56-m448 | 56 | 100% | 448 | 10 - 8184 |
| m3-c64-m512 | 64 | 100% | 512 | 10 - 8184 |
| m3-c80-m640 | 80 | 100% | 640 | 10 - 8184 |

{% endif %}

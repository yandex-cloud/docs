---
title: "Managed Service for PostgreSQL host classes"
description: "The host class defines the processing power that is allocated to each host in the PostgreSQL cluster. Changing the host class for the cluster changes the characteristics of all hosts already created in it."
---

# {{ PG }} host classes

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match it.

{% if audience != "internal" %}
The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).
{% endif %}

## Available host classes {#available-flavors}

{% if audience == "internal" %}

| Host class name | Number of CPUs | RAM, GB | I/O limit, MB/s | Maximum connection speed, MB/s |
| ----- | ----- | ----- | ----- | ----- |
| **Sandy Bridge** |
| db1.nano | 1 | 2 | 5 | 16 |
| db1.micro | 1 | 8 | 20 | 16 |
| db1.small | 2 | 16 | 40 | 32 |
| db1.medium | 4 | 32 | 80 | 32 |
| db1.large | 8 | 64 | 160 | 64 |
| db1.xlarge | 16 | 128 | 320 | 128 |
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
| **Cascade Lake** |
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

{% else %}

Hosts in {{ mpg-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

{% include [instance-types-code](../../_includes/mdb/instance-types-code-c3.md) %}

| Host class name | Number of CPUs | CPU performance | RAM, GB |
|-------------------|----------------|------------------------|---------|
| {% if product == "yandex-cloud" %} | **Intel Broadwell** |
| b1.nano | 2 | 5% | 2 |
| b1.micro | 2 | 20% | 2 |
| b1.medium | 2 | 50% | 4 |
| s1.micro | 2 | 100% | 8 |
| s1.small | 4 | 100% | 16 |
| s1.medium | 8 | 100% | 32 |
| s1.large | 16 | 100% | 64 |
| s1.xlarge | 32 | 100% | 128 |
| **Intel Cascade Lake** |
| b2.nano | 2 | 5% | 2 |
| b2.micro | 2 | 20% | 2 |
| b2.medium | 2 | 50% | 4 |
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
| s2.6xlarge | 64 | 100% | 256 | {% endif %} |
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
| c3-c2-m4 | 2 | 100% | 4 |
| c3-c4-m8 | 4 | 100% | 8 |
| c3-c8-m16 | 8 | 100% | 16 |
| c3-c12-m24 | 12 | 100% | 24 |
| c3-c16-m32 | 16 | 100% | 32 |
| c3-c24-m48 | 24 | 100% | 48 |
| c3-c32-m64 | 32 | 100% | 64 |
| c3-c40-m80 | 40 | 100% | 80 |
| c3-c48-m96 | 48 | 100% | 96 |
| c3-c64-m128 | 64 | 100% | 128 |
| c3-c80-m160 | 80 | 100% | 160 |
| c3-c96-m192 | 96 | 100% | 192 |

{% endif %}

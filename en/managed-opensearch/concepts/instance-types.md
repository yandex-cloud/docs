# Host classes {{ OS }}

The host class determines the computing power allocated for each host group with the specific role in the cluster. When you change the host class for a host group in the cluster, the characteristics change for all of the hosts that were created earlier in the group. For more information about host groups, see [{#T}](./host-groups.md).

{% if audience != "internal" %}

The available storage doesn't depend on the host class. For storage limitations, see [Quotas and limits](limits.md).

{% endif %}

## Available host classes {#available-flavors}

Hosts in {{ mos-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these virtual machines on any standard platform supported by {{ compute-name }}. {% if audience != "internal" %}For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).{% endif %}

The full list of possible host group configurations on each platform is provided below.

Configuration types:

{% if product == "yandex-cloud" %}

{% if audience != "internal" %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.
* **b3**: Configuration with a guaranteed vCPU share under 100%. This class of hosts is intended for test load, with the minimum recommended host configuration for production solutions being 2 vCPUs with a guaranteed share of 50%.

{% else %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **db1**, **m1**, **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

* **s3**: Standard configuration, with 4:1 GB RAM to vCPU ratio.
* **m3**: Configuration with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.
* **b3**: Configuration with a guaranteed vCPU share under 100%. This class of hosts is intended for test load, with the minimum recommended host configuration for production solutions being 2 vCPUs with a guaranteed share of 50%.

{% endif %}

{% if audience != "internal" %}

| Host class name | Number of vCPUs | Guaranteed<br>vCPU performance | RAM, GB | Disk<br>size, GB |
|-------------------|-----------------|---------------------------|---------|----------------------|
{% if product == "yandex-cloud" %}| **Intel Cascade Lake** |
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
| b3-c1-m4 | 2 | 50% | 4 | 10 - 4096 |
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

{% else %}

| Host class name   | Number of vCPUs | Guaranteed<br>vCPU performance | RAM, GB | Disk<br>size, GB |
|-------------------|-----------------|--------------------------------|---------|------------------|
| **Intel Sandy Bridge**                                                                            |
| db1.small         | 2               | 100%                           | 16      | 10 - 2048        |
| db1.medium        | 4               | 100%                           | 32      | 10 - 2048        |
| db1.large         | 8               | 100%                           | 64      | 10 - 2048        |
| db1.xlarge        | 16              | 100%                           | 128     | 10 - 2048        |
| m1.micro          | 1               | 100%                           | 8       | 10 - 2048        |
| m1.small          | 2               | 100%                           | 16      | 10 - 2048        |
| m1.medium         | 4               | 100%                           | 32      | 10 - 2048        |
| m1.large          | 8               | 100%                           | 64      | 10 - 2048        |
| m1.xlarge         | 16              | 100%                           | 128     | 10 - 2048        |
| **Intel Broadwell**                                                                               |
| m2.nano           | 1               | 100%                           | 8       | 10 - 2048        |
| m2.micro          | 2               | 100%                           | 16      | 10 - 2048        |
| m2.small          | 4               | 100%                           | 32      | 10 - 2048        |
| m2.medium         | 6               | 100%                           | 48      | 10 - 2048        |
| m2.large          | 8               | 100%                           | 64      | 10 - 2048        |
| m2.xlarge         | 12              | 100%                           | 96      | 10 - 2048        |
| m2.2xlarge        | 16              | 100%                           | 128     | 10 - 2048        |
| m2.3xlarge        | 24              | 100%                           | 192     | 10 - 2048        |
| m2.4xlarge        | 32              | 100%                           | 256     | 10 - 2048        |
| m2.5xlarge        | 40              | 100%                           | 320     | 10 - 2048        |
| m2.6xlarge        | 48              | 100%                           | 384     | 10 - 2048        |
| m2.7xlarge        | 56              | 100%                           | 448     | 10 - 2048        |
| s2.nano           | 1               | 100%                           | 4       | 10 - 2048        |
| s2.micro          | 2               | 100%                           | 8       | 10 - 2048        |
| s2.small          | 4               | 100%                           | 16      | 10 - 2048        |
| s2.medium         | 8               | 100%                           | 32      | 10 - 2048        |
| s2.large          | 12              | 100%                           | 48      | 10 - 2048        |
| s2.xlarge         | 16              | 100%                           | 64      | 10 - 2048        |
| s2.2xlarge        | 24              | 100%                           | 96      | 10 - 2048        |
| s2.3xlarge        | 32              | 100%                           | 128     | 10 - 2048        |
| s2.4xlarge        | 40              | 100%                           | 160     | 10 - 2048        |
| **Intel Cascade Lake**                                                                            |
| s3.nano           | 1               | 100%                           | 4       | 10 - 2048        |
| s3.micro          | 2               | 100%                           | 8       | 10 - 2048        |
| s3.small          | 4               | 100%                           | 16      | 10 - 2048        |
| s3.medium         | 8               | 100%                           | 32      | 10 - 2048        |
| s3.large          | 12              | 100%                           | 48      | 10 - 2048        |
| s3.xlarge         | 16              | 100%                           | 64      | 10 - 2048        |
| s3.2xlarge        | 24              | 100%                           | 96      | 10 - 2048        |
| s3.3xlarge        | 32              | 100%                           | 128     | 10 - 2048        |
| s3.4xlarge        | 40              | 100%                           | 160     | 10 - 2048        |
| s3.5xlarge        | 48              | 100%                           | 192     | 10 - 2048        |
| s3.6xlarge        | 64              | 100%                           | 256     | 10 - 2048        |
| m3.nano           | 1               | 100%                           | 8       | 10 - 2048        |
| m3.micro          | 2               | 100%                           | 12      | 10 - 2048        |
| m3.small          | 2               | 100%                           | 16      | 10 - 2048        |
| m3.medium         | 4               | 100%                           | 24      | 10 - 2048        |
| m3.large          | 4               | 100%                           | 32      | 10 - 2048        |
| m3.xlarge         | 6               | 100%                           | 48      | 10 - 2048        |
| m3.2xlarge        | 8               | 100%                           | 64      | 10 - 2048        |
| m3.3xlarge        | 10              | 100%                           | 80      | 10 - 2048        |
| m3.4xlarge        | 12              | 100%                           | 96      | 10 - 2048        |
| m3.5xlarge        | 16              | 100%                           | 128     | 10 - 2048        |
| m3.6xlarge        | 20              | 100%                           | 160     | 10 - 2048        |
| m3.7xlarge        | 24              | 100%                           | 192     | 10 - 2048        |
| m3.8xlarge        | 28              | 100%                           | 224     | 10 - 2048        |
| m3.9xlarge        | 32              | 100%                           | 256     | 10 - 2048        |
| m3.10xlarge       | 40              | 100%                           | 320     | 10 - 2048        |
| m3.11xlarge       | 48              | 100%                           | 384     | 10 - 2048        |

{% endif %}

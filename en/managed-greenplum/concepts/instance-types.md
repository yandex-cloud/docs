# {{ GP }} host classes

The host class determines the computing power allocated for each host in the cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.

{% if audience != "internal" %}

The host class affects the list of available [disk types](./storage.md):

* For master hosts:

   * **s2**, **i2**: `local-ssd`.
   * **s3**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`.
   * **i3**: `network-ssd`, `network-hdd`, `network-ssd-nonreplicated`.

* For segment hosts:

   * **s2**, **i2**: `local-ssd`.
   * **s3**, **i3**: `network-ssd-nonreplicated`.

The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).
{% endif %}

## Available host classes {#available-flavors}

{% if audience == "internal" %}

| Host class name | Number of CPUs | RAM, GB | I/O limit,<br> MB/s | Max. connection <br>speed, MB/s |
----- | ----- | ----- | ----- | -----
| **Cascade Lake** |
| s3.small | 4 | 16 | 64 | 64 |
| s3.medium | 8 | 32 | 128 | 128 |
| s3.large | 12 | 48 | 192 | 192 |
| s3.xlarge | 16 | 64 | 256 | 256 |
| s3.2xlarge | 24 | 96 | 384 | 384 |
| s3.3xlarge | 32 | 128 | 512 | 512 |
| s3.4xlarge | 40 | 160 | 640 | 640 |
| s3.5xlarge | 48 | 192 | 768 | 768 |
| s3.6xlarge | 64 | 256 | 1024 | 1024 |
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

{{ mgp-name }} cluster hosts are deployed on {{ compute-full-name }} virtual machines on{% if product == "yandex-cloud" %} Intel Cascade Lake and{% endif %} Intel Ice Lake [platforms](../../compute/concepts/vm-platforms.md) with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:

{% include [instance-types-code](../../_includes/mdb/mgp-instance-types-code.md) %}

| Host class name | Number of vCPUs | vCPU performance | RAM, GB |
|-------------------|----------------:|:-----------------------:|--------:|
{% if product == "yandex-cloud" %}| **Intel Cascade Lake** |
| s2.medium | 8 | 100% | 32 |
| s2.large | 12 | 100% | 48 |
| i2.2xlarge | 16 | 100% | 128 |
| i2.4xlarge | 32 | 100% | 256 |
| i2.5xlarge | 40 | 100% | 320 |{% endif %}
| **Intel Ice Lake** |
| s3-c8-m32 | 8 | 100% | 32 |
| s3-c12-m48 | 12 | 100% | 48 |
| i3-c16-m128 | 16 | 100% | 128 |
| i3-c32-m256 | 32 | 100% | 256 |
| i3-c40-m320 | 40 | 100% | 320 |

{% else %}

Configuration types:

* **s3**: Standard configuration, with 4:1 RAM (GB) to vCPU ratio.
* **m3**: Configuration with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

| Host class name | Number of vCPUs | vCPU performance | RAM, GB |
|-------------------|----------------:|:-----------------------:|--------:|
| **Intel Cascade Lake or later** |
| s3.small | 4 | 100% | 16 |
| s3.medium | 8 | 100% | 32 |
| s3.large | 12 | 100% | 48 |
| s3.xlarge | 16 | 100% | 64 |
| s3.2xlarge | 24 | 100% | 96 |
| s3.3xlarge | 32 | 100% | 128 |
| s3.4xlarge | 40 | 100% | 160 |
| s3.5xlarge | 48 | 100% | 192 |
| s3.6xlarge | 64 | 100% | 256 |
| m3.medium | 4 | 100% | 24 |
| m3.large | 4 | 100% | 32 |
| m3.xlarge | 6 | 100% | 48 |
| m3.2xlarge | 8 | 100% | 64 |
| m3.3xlarge | 10 | 100% | 80 |
| m3.4xlarge | 12 | 100% | 96 |
| m3.5xlarge | 16 | 100% | 128 |
| m3.6xlarge | 20 | 100% | 160 |
| m3.7xlarge | 24 | 100% | 192 |
| m3.8xlarge | 28 | 100% | 224 |
| m3.9xlarge | 32 | 100% | 256 |
| m3.10xlarge | 40 | 100% | 320 |
| m3.11xlarge | 48 | 100% | 384 |

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

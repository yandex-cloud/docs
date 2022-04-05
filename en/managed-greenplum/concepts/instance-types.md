# Host classes

The host class determines the computing power allocated for each host in the cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.

{% if audience != "internal" %}
The available storage doesn't depend on the host class. For more information about storage restrictions, see [{#T}](limits.md).
{% endif %}

## Available host classes {#available-flavors}

Hosts in {{ mgp-name }} clusters are deployed on {{ compute-full-name }} VMs on the [platforms](../../compute/concepts/vm-platforms.md) Intel Cascade Lake and Intel Ice Lake with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:

{% if audience == "external" %}

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **i2**, **i3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements. Hosts of these configurations use a [software-accelerated network](../../vpc/concepts/software-accelerated-network.md) and its use significantly affects [cluster pricing](../pricing/index.md#prices-hosts).

| Host class name | Number of vCPUs | vCPU performance | RAM, GB |
|-----------------|----------------:|:----------------:|--------:|
| **Intel Cascade Lake**                                         |
| s2.medium       |               8 | 100%             |      32 |
| s2.large        |              12 | 100%             |      48 |
| i2.2xlarge      |              16 | 100%             |     128 |
| i2.4xlarge      |              32 | 100%             |     256 |
| i2.5xlarge      |              40 | 100%             |     320 |
| **Intel Ice Lake**                                             |
| s3-c8-m32       |               8 | 100%             |      32 |
| s3-c12-m48      |              12 | 100%             |      48 |
| i3-c16-m128     |              16 | 100%             |     128 |
| i3-c32-m256     |              32 | 100%             |     256 |
| i3-c40-m320     |              40 | 100%             |     320 |

{% else %}

* **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.

| Host class name | Number of vCPUs | vCPU performance | RAM, GB |
|-----------------|----------------:|:----------------:|--------:|
| **Intel Cascade Lake or later**                                |
| s3.small        |               4 | 100%             |      16 |
| s3.medium       |               8 | 100%             |      32 |
| s3.large        |              12 | 100%             |      48 |
| s3.xlarge       |              16 | 100%             |      64 |
| s3.2xlarge      |              24 | 100%             |      96 |
| s3.3xlarge      |              32 | 100%             |     128 |
| s3.4xlarge      |              40 | 100%             |     160 |
| s3.5xlarge      |              48 | 100%             |     192 |
| s3.6xlarge      |              64 | 100%             |     256 |
| m3.medium       |               4 | 100%             |      24 |
| m3.large        |               4 | 100%             |      32 |
| m3.xlarge       |               6 | 100%             |      48 |
| m3.2xlarge      |               8 | 100%             |      64 |
| m3.3xlarge      |              10 | 100%             |      80 |
| m3.4xlarge      |              12 | 100%             |      96 |
| m3.5xlarge      |              16 | 100%             |     128 |
| m3.6xlarge      |              20 | 100%             |     160 |
| m3.7xlarge      |              24 | 100%             |     192 |
| m3.8xlarge      |              28 | 100%             |     224 |
| m3.9xlarge      |              32 | 100%             |     256 |
| m3.10xlarge     |              40 | 100%             |     320 |
| m3.11xlarge     |              48 | 100%             |     384 |

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}


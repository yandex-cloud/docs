# Host classes

The host class determines the computing power allocated for each host in the cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.

The available storage doesn't depend on the host class. For more information about storage restrictions, see [{#T}](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ mgp-name }} clusters are deployed on {{ compute-full-name }} VMs on the [platforms](../../compute/concepts/vm-platforms.md) Intel Cascade Lake and Intel Ice Lake with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:


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

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}


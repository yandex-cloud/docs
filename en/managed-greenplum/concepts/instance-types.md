# Host classes in {{ GP }}

The host class determines the computing power allocated for each host in the cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.


The host class affects the list of available [disk types](./storage.md):

* For master hosts:

   * **s2**, **i2**: `local-ssd`.
   * **s3**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`.
   * **i3**: `network-ssd`, `network-hdd`, `network-ssd-nonreplicated`.

* For segment hosts:

   * **s2**, **i2**: `local-ssd`.
   * **s3**, **i3**: `network-ssd-nonreplicated`.

The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).

## Available host classes {#available-flavors}


{{ mgp-name }} cluster hosts are deployed on {{ compute-full-name }} virtual machines on Intel Cascade Lake and Intel Ice Lake [platforms](../../compute/concepts/vm-platforms.md) with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:

{% include [instance-types-code](../../_includes/mdb/mgp-instance-types-code.md) %}

| Host class name | Number of vCPUs | vCPU performance | RAM, GB |
|-------------------|----------------:|:-----------------------:|--------:|
 | **Intel Cascade Lake** |
| s2.medium | 8 | 100% | 32 |
| s2.large | 12 | 100% | 48 |
| i2.2xlarge | 16 | 100% | 128 |
| i2.4xlarge | 32 | 100% | 256 |
| i2.5xlarge | 40 | 100% | 320 |  |
| **Intel Ice Lake** |
| s3-c8-m32 | 8 | 100% | 32 |
| s3-c12-m48 | 12 | 100% | 48 |
| i3-c16-m128 | 16 | 100% | 128 |
| i3-c32-m256 | 32 | 100% | 256 |
| i3-c40-m320 | 40 | 100% | 320 |


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

# {{ GP }} host classes

The host class determines the computing power allocated for each host in a cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.


The host class also determines which [disk types](./storage.md) are available:

* **s2**, **i2**: `local-ssd` and `network-ssd-nonreplicated`.
* **s3**, **i3**: `network-ssd`, `network-hdd`, `local-ssd`, and `network-ssd-nonreplicated`.

For segment hosts, the following disk types are available:

* `local-ssd`
* `network-ssd-nonreplicated`

The available storage size does not depend on the host class. For storage limitations, see [{#T}](limits.md).

## Available host classes {#available-flavors}


{{ mgp-name }} cluster hosts are deployed on {{ compute-full-name }} virtual machines on Intel Cascade Lake and Intel Ice Lake [platforms](../../compute/concepts/vm-platforms.md) with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:

{% include [instance-types-code](../../_includes/mdb/mgp-instance-types-code.md) %}

| Host class name | Number of vCPUs | vCPU performance | RAM, GB | Disk <br>size, GB |
|-------------------|----------------:|:-----------------------:|--------:|----------------------|
| **Intel Cascade Lake** |
| s2.medium | 8 | 100% | 32 | 93 - 8184 |
| s2.large | 12 | 100% | 48 | 93 - 8184 |
| i2.2xlarge | 16 | 100% | 128 | 93 - 8184 |
| i2.4xlarge | 32 | 100% | 256 | 93 - 8184 |
| i2.5xlarge | 40 | 100% | 320 | 93 - 8184 |
| **Intel Ice Lake** |
| s3-c8-m32 | 8 | 100% | 32 | 10 - 8192 |
| s3-c12-m48 | 12 | 100% | 48 | 10 - 8192 |
| i3-c16-m128 | 16 | 100% | 128 | 10 - 8192 |
| i3-c32-m256 | 32 | 100% | 256 | 10 - 8192 |
| i3-c40-m320 | 40 | 100% | 320 | 10 - 8192 |


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

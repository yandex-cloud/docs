# Host classes

The host class determines the computing power allocated for each host in the cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. Once a cluster is created, you cannot change its host classes.

The available storage doesn't depend on the host class. For more information about storage restrictions, see [{#T}](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ mgp-name }} clusters are deployed on {{ compute-full-name }} VMs on the [platforms](../../compute/concepts/vm-platforms.md) Intel Cascade Lake and Intel Ice Lake with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

Configuration types:

* **s2**, **s3**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**, **m3**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with higher cache requirements.
* **c3**: Configurations with a reduced GB RAM to vCPU ratio (2:1). These configurations can be useful for clusters with higher processor performance requirements.

| Host class name | Number of CPUs | CPU performance | RAM, GB |
| ------------------- | ---------------- | ------------------------ | --------- |
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
| m2.9xlarge | 80 | 100% | 640 |
| m2.10xlarge | 80 | 100% | 400 |
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
| s2.7xlarge | 80 | 100% | 320 |
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

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}


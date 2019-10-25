# Host classes

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match.

For {{ mrd-name }}, the host classes are determined by the CPU power and RAM size:

* For small amounts of data and low load, you can create clusters with a low performance guarantee (`b1`), same as for virtual machines with a [guaranteed vCPU share under 100%](../../compute/concepts/performance-levels.md).
* For high-load or performance-intensive systems, use standard hosts (`hm1`).

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host with 8 GB RAM, `maxmemory` is set to 6 GB.

{% endnote %}

The hard disk space available to the host should be at least two times more than the selected memory size. For technical and organizational limitations of {{ mrd-name }}, see [{#T}](limits.md).

The available storage does not depend on the host class. For storage limitations, see [{#T}](limits.md). w

## Available host classes {#available-flavors}

| Host class name | Number of CPUs | RAM, GB |
| ----- | ----- | ----- |
| b1.nano | `burstable` | 2 |
| b1.small | `burstable` | 4 |
| hm1.nano | `high-memory` | 8 |
| hm1.micro | `high-memory` | 12 |
| hm1.small | `high-memory` | 16 |
| hm1.medium | `high-memory` | 24 |
| hm1.large | `high-memory` | 32 |
| hm1.xlarge | `high-memory` | 48 |
| hm1.2xlarge | `high-memory` | 64 |
| hm1.3xlarge | `high-memory` | 80 |
| hm1.4xlarge | `high-memory` | 96 |
| hm1.5xlarge | `high-memory` | 128 |
| hm1.6xlarge | `high-memory` | 160 |
| hm1.7xlarge | `high-memory` | 192 |
| hm1.8xlarge | `high-memory` | 224 |
| hm1.9xlarge | `high-memory` | 256 |


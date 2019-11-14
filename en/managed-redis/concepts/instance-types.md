# Host classes

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match it.

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host with 8 GB RAM, `maxmemory` is set to 6 GB.

{% endnote %}

The hard disk space available to the host should be at least two times more than the selected memory size. For technical and organizational limitations of {{ mrd-name }}, see [{#T}](limits.md).

The available storage does not depend on the host class. For storage limitations, see [{#T}](limits.md). w

## Available host classes {#available-flavors}

Configuration types:

* **b1, b2**: Configurations with a [guaranteed vCPU share](../../compute/concepts/performance-levels.md) below 100%. Those host classes are intended for test loads. We don't recommend using them for production solutions.
* **hm1, hm2**: Standard configurations for {{ RD }}.

| Host class name | RAM, GB | Disk size, GB |
| ----- | ----- | ----- |
| b1.nano | 2 | 4 - 16 |
| b1.small | 4 | 8 - 32 |
| hm1.nano | 8 | 16 - 64 |
| hm1.micro | 12 | 24 - 96 |
| hm1.small | 16 | 32 - 128 |
| hm1.medium | 24 | 48 - 192 |
| hm1.large | 32 | 64 - 256 |
| hm1.xlarge | 48 | 96 - 384 |
| hm1.2xlarge | 64 | 128 - 512 |
| hm1.3xlarge | 80 | 160 - 640 |
| hm1.4xlarge | 96 | 192 - 768 |
| hm1.5xlarge | 128 | 256 - 1024 |
| hm1.6xlarge | 160 | 320 - 1280 |
| hm1.7xlarge | 192 | 384 - 1536 |
| hm1.8xlarge | 224 | 448 - 1792 |
| hm1.9xlarge | 256 | 512 - 2048 |


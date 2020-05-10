# Host configurations

The host configuration determines the computing power allocated for each host in the cluster. When you change the host configuration for a cluster, all existing hosts change to match it.

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host with 8 GB RAM, `maxmemory` is set to 6 GB.

{% endnote %}

The hard disk space available to the host should be at least two times more than the selected memory size. For technical and organizational limitations of {{ mrd-name }}, see [{#T}](limits.md).

## Available host configurations {#available-flavors}

Configuration types:

* **burstable**: Configurations with a [guaranteed vCPU share](../../compute/concepts/performance-levels.md) below 100%. Those host classes are intended for test loads. We don't recommend using them for production solutions.
* **high-memory**: Standard configurations for {{ RD }}.

| vCPU | RAM, GB | Guaranteed vCPU performance | Disk size, GB |
| ----- | ----- | ----- | ----- |
| 2 | 2 | 5% | 4 - 16 |
| 2 | 4 | 20% | 8 - 32 |
| 2 | 8 | 100% | 16 - 64 |
| 2 | 12 | 100% | 24 - 96 |
| 2 | 16 | 100% | 32 - 128 |
| 4 | 24 | 100% | 48 - 192 |
| 4 | 32 | 100% | 64 - 256 |
| 4 | 48 | 100% | 96 - 384 |
| 4 | 64 | 100% | 128 - 512 |
| 4 | 80 | 100% | 160 - 640 |
| 8 | 96 | 100% | 192 - 768 |
| 8 | 128 | 100% | 256 - 1024 |
| 8 | 160 | 100% | 320 - 1280 |
| 8 | 192 | 100% | 384 - 1536 |
| 8 | 224 | 100% | 448 - 1792 |
| 8 | 256 | 100% | 512 - 2048 |


#### Quotas {#mmg-quotas}

| Type of limit                                              | Value   |
|------------------------------------------------------------|---------|
| Number of clusters per cloud                               | 16      |
| Total number of processor cores for all DB hosts per cloud | 96      |
| Total virtual memory for all DB hosts per cloud            | 640 GB  |
| Total storage capacity for all clusters per cloud          | 4096 GB |

#### Limits {#mmg-limits}

| Type of limit | Minimum value | Maximum value |
| ----- | ----- | ----- |
| Host class | b1.nano ([5%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 2 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of shards in a cluster | 1 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 3 | 7 |
| Number of hosts per cluster | 1 host (clusters are unsharded at [creation](../../managed-mongodb/operations/cluster-create.md)) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | 10 GB | 605 GB |
| Amount of data on the host when using local storage | 100 GB | 600 GB |

{% include [mmg-conn-limits](mmg-conn-limits.md) %}

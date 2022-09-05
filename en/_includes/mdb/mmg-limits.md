#### Quotas {#mmg-quotas}

| Limits | Value |
| :------------------------------------------------------------------------------- | :--------- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 96 |
| Total virtual memory for all DB hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mmg-limits}

| Limits | Minimum value | Maximum value |
| :----------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------- | :------------------------------------------------- |
| Host class | b1.nano ([5%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 2 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of shards per cluster | 1 | 10 |
| Number of hosts in a shard when using HDD or SSD network storage | 1 | 7 |
| Number of hosts in a shard when storing data on non-replicated or local SSDs<sup>*</sup> | 3 | 7 |
| Number of hosts per cluster | 1 or 3 hosts depending on the [storage type](../../managed-mongodb/concepts/storage.md#storage-type-selection), a cluster is [created](../../managed-mongodb/operations/cluster-create.md) non-sharded | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using HDD or SSD network storage | 10 GB | 1 TB |
| Amount of data on the host when using non-replicated SSD storage | 93 GB | 1 TB |
| Amount of data on the host when using local SSD storage<sup>*</sup> | 100 GB | 1 TB |

{% include [storage-limitations-mmg](./mmg/storage-limitations-note.md) %}

{% include [mmg-conn-limits](./mmg/conn-limits.md) %}

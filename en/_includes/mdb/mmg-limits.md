#### Quotas {#mmg-quotas}

| Type of limit | Value |
|:-------------------------------------------------------------------------------|:---------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all database hosts per cloud | 96 |
| Total virtual memory for all database hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mmg-limits}

| Type of limit | Minimum value | Maximum value |
|:-----------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of shards per cluster | 1 | 10 |
| Number of hosts per shard when using network HDD or network SSD storage | 1 | 7 |
| Number of hosts per shard when using non-replicated or local SSD storage^*^ | 3 | 7 |
| Number of hosts per cluster | 1 or 3 hosts depending on the [disk type](../../managed-mongodb/concepts/storage.md#storage-type-selection); the cluster [is created](../../managed-mongodb/operations/cluster-create.md) in an unsharded state. | 70 (10 shards, 7 hosts) |
| Amount of data per host when using network HDD or SSD storage | 10 GB | 2048 GB |
| Amount of data per host when using non-replicated SSD storage | 93 GB | 2232 GB |
| Amount of data per host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake)^*^ | 100 GB | 1500 GB |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)^*^ | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |
| Number of databases per cluster | 1 | {{ all-mdb.max-databases }} |

{% include [storage-limitations-mmg](./mmg/storage-limitations-note.md) %}

{% include [mmg-conn-limits](./mmg/conn-limits.md) %}

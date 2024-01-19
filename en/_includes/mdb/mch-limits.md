
#### Quotas {#mch-quotas}

| Type of limit | Value |
|:-------------------------------------------------------------------------------|:---------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all database hosts per cloud | 96 |
| Total virtual memory for all database hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mch-limits}

| Type of limit | Minimum value | Maximum value |
|:----------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of {{ CH }} hosts in a non-sharded cluster when using HDD or SSD network storage | 1 | 7 |
| Number of {{ CH }} hosts in a non-sharded cluster when using non-replicated SSD storage | 3 | 7 |
| Number of {{ CH }} hosts in a non-sharded cluster when using local SSD storage | 2 | 7 |
| Number of shards in a sharded cluster | 1 | 50 |
| Number of hosts in a shard when using network HDD or SSD storage | 1 | 7 |
| Number of hosts in a shard when using non-replicated SSD storage | 3 | 7 |
| Number of hosts in a shard when using local SSD storage | 2 | 7 |
| Total number of hosts per cluster | 1 | 353 (50 shards × 7 hosts + 3 {{ ZK }} hosts) |
| Amount of data on the host when using network HDD or SSD storage | 10 GB | 4096 GB |
| Amount of data on the host when using non-replicated SSD storage | 93 GB | 8184 GB |
| Amount of data on the host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the host when using local SSD storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |
| Number of databases per cluster | 1 | {{ all-mdb.max-databases }} |


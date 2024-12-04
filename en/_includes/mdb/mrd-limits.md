#### Quotas {#mrd-quotas}

| Type of limit                                                                | Value |
|:-------------------------------------------------------------------------------|:---------|
| Number of clusters per cloud                                            | 16       |
| Total number of processor cores for all database hosts per cloud | 64       |
| Total virtual memory for all database hosts per cloud   | 512 GB   |
| Total storage capacity for all clusters per cloud                     | 4,096 GB  |

#### Limits {#mrd-limits}


| Type of limit                                                                                           | Minimum value                  | Maximum value                             |
|:----------------------------------------------------------------------------------------------------------|:--------------------------------------|:--------------------------------------------------|
| Host class                                                             | b2.medium (`burstable`, 4 GB RAM)      | hm3-c32-m512 (32 vCPU Intel Ice Lake, 512 GB RAM) |
| Number of hosts per unsharded cluster                                                              | 1 or 3 depending on the [disk type](../../managed-redis/concepts/storage.md#storage-type-selection)                              | 7                                                 |
| Number of shards in a sharded cluster                                                                | 1                                     | 10                                                |
| Number of hosts per shard when using network SSD storage                               | 1                                     | 7                                                 |
| Number of hosts per shard when using local SSD storage^*^                 | 2                                     | 7                                                 |
| Number of hosts per shard when using non-replicated SSD storage^*^           | 3                                     | 7                                                 |
| Number of hosts per sharded cluster                                                                | 1, 2, or 3 hosts depending on the [disk type](../../managed-redis/concepts/storage.md#storage-type-selection)                 | 70 (10 shards, 7 hosts)                         |
| Amount of data per host when using network SSD storage                                   | Twice the selected amount of RAM | 4,096 GB                                           |
| Amount of data per host when using non-replicated SSD storage^*^               | Twice the selected amount of RAM but at least 93 GB                                  | 8,184 GB                                           |
| Amount of data per host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake)^*^                     | Twice the selected amount of RAM but at least 100 GB                                 | 1,500 GB                                           |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)^*^ | Twice the selected amount of RAM but at least {{ local-ssd-v3-step }}                               | {{ local-ssd-v3-max }}                                        |
| Number of cluster connections | — | 65 000 |

{% include [storage-limitations-mrd](./mrd/storage-limitations-note.md) %}


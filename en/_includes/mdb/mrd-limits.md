#### Quotas {#mrd-quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of CPU cores for all database hosts per cloud 
`mdb.cpu.count` | 64 ||
|| Total virtual memory for all database hosts per cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters per cloud 
`mdb.ssd.size` | 4,096 GB ||
|| Number of GPUs 
`mdb.gpu.count` | 0 ||
|#

#### Limits {#mrd-limits}


| Type of limit                                                                                           | Minimum value                  | Maximum value                             |
|:----------------------------------------------------------------------------------------------------------|:--------------------------------------|:--------------------------------------------------|
| Host class                                                                                               | b2.medium (`burstable`, 4 GB RAM)    | m4a-c224-m1792 (224 vCPUs, AMD Zen 4, 1,792 GB RAM) |
| Number of hosts per unsharded cluster                                                              | 1 or 3 depending on the [disk type](../../managed-valkey/concepts/storage.md#storage-type-selection)                              | 7                                                 |
| Number of shards per sharded cluster                                                                | 1                                     | 10                                                |
| Number of hosts per shard when using a network SSD storage or an ultra high-speed network SSD storage with three replicas | 1                                     | 7                                                 |
| Number of hosts per shard when using a local SSD storage^*^                 | 2                                     | 7                                                 |
| Number of hosts per shard when using a non-replicated SSD storage^*^           | 3                                     | 7                                                 |
| Number of hosts per sharded cluster                                                                | 1, 2, or 3 hosts depending on the [disk type](../../managed-valkey/concepts/storage.md#storage-type-selection)                 | 70 (10 shards × 7 hosts)                         |
| Amount of data per host when using a SSD network storage | Twice the selected amount of RAM | 4,096 GB                                           |
| Amount of data per host when using a non-replicated SSD storage^*^ or an ultra high-speed network SSD storage with three replicas | Twice the selected amount of RAM but at least 93 GB                                  | 8,184 GB                                           |
| Amount of data per host when using a local SSD storage (for Intel Broadwell and Intel Cascade Lake)^*^                     | Twice the selected amount of RAM but at least 100 GB                                 | 1,500 GB                                           |
| Amount of data per host when using a local SSD storage (for Intel Ice Lake)^*^ | Twice the selected amount of RAM but at least {{ local-ssd-v3-step }}                               | {{ local-ssd-v3-max }}                                        |
| Number of cluster connections | — | 65 000 |

{% include [storage-limitations-mrd](./mvk/storage-limitations-note.md) %}


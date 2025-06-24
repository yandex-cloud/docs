
#### Quotas {#mch-quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of processor cores for all database hosts per cloud 
`mdb.cpu.count` | 64 ||
|| Total virtual memory for all database hosts per cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters per cloud 
`mdb.ssd.size` | 4,096 GB ||
|#

#### Limits {#mch-limits}

| Type of limit                                                                                                                  | Minimum value                                                                                                                                  | Maximum value                            |
|:----------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class                                                                                                                       | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of {{ CH }} hosts per non-sharded cluster when using an HDD or SSD network storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                                                                                                                     | 7                                                |
| Number of {{ CH }} hosts in a non-sharded cluster when using non-replicated SSD storage                   | 3                                                                                                                                                     | 7                                                |
| Number of {{ CH }} hosts in a non-sharded cluster when using local SSD storage                         | 2                                                                                                                                                     | 7                                                |
| Number of shards in a sharded cluster                                                                                        | 1                                                                                                                                                     | 50                                               |
| Number of hosts per shard when using an HDD or SSD network storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                                                                                                                     | 7                                                |
| Number of hosts in a shard when using non-replicated SSD storage                                               | 3                                                                                                                                                     | 7                                                |
| Number of hosts in a shard when using local SSD storage                                                     | 2                                                                                                                                                     | 7                                                |
| Total number of hosts per cluster                                                                                          | 1                                                                                                                                                     | 353 (50 shards × 7 hosts + 3 {{ ZK }} hosts)    |
| Amount of data per host when using network HDD or SSD storage (for Intel Broadwell and Intel Cascade Lake) | 10 GB                                                                                                                                                 | 4,096 GB                                          |
| Amount of data per host when using network HDD or SSD storage (for Intel Ice Lake)                          | 10 GB                                                                                                                                                 | 8,192 GB                                          |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                                                                                                                                 | 16,368 GB                                        |
| Amount of data per host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake)     | 100 GB                                                                                                                                                | 1,500 GB                                          |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)                          | {{ local-ssd-v3-step }}                                                                                                                               | {{ local-ssd-v3-max }}                           |
| Number of databases per cluster                                                                                            | 1                                                                                                                                                     | {{ all-mdb.max-databases }}                      |

#### Limits on the maximum number of objects {#mch-objects-limits}

The limits on the maximum number of objects in a cluster have two threshold values:

* _Soft limit_: When reached, the `system.warnings` [system table](https://clickhouse.com/docs/en/operations/system-tables/system_warnings) will display a warning.

* _Hard limit_: When reached, creating new objects of this type will end with an error message.

    {% note info "Note" %}

    The _hard limit_ threshold only works in {{ CH }} 25.2 and higher.

    {% endnote %}

| Type of limitation             | Soft limit | Hard limit |
|:----------------------------|:-----------|:-----------|
| Number of databases       | 500        | 1000       |
| Number of tables           | 5000       | 10000      |
| Number of views    | 5000       | 10000      |
| Number of external dictionaries | 500        | 1000       |

All limits are implemented based on [{{ CH }} server settings](https://clickhouse.com/docs/operations/server-configuration-parameters/settings). You cannot change them.

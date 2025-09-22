#### Quotas {#mkf-quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of processor cores for all database hosts per cloud 
`mdb.cpu.count` | 64 ||
|| Total virtual memory for all database hosts per cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters per cloud 
`mdb.ssd.size` | 4,096 GB ||
|#


#### Limits {#mkf-limits}

| Type of limit                                                                                                      | Minimum value                                                                                  | Maximum value                            |
|:---------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class                                                                                                          | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of brokers per cluster when using an HDD or SSD network storage, or an ultra high-speed network storage with three replicas (SSD) | 1                                                                                                     | 36                                               |
| Number of brokers in a cluster when using non-replicated or local SSDs | 3                                                                                                     | 36                                               |
| Amount of data on the broker when using SSD network storage                                            | 10 GB                                                                                                 | 32,768 GB                                          |
| Amount of data on the broker when using HDD network storage                                            | 10 GB                                                                                                 | 2,048 GB                                          |
| Amount of data per broker when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                                                                                 | 8,184 GB                                          |
| Amount of data on the broker when using local SSD storage (for Intel Cascade Lake)       | 100 GB                                                                                                | 1,500 GB                                          |
| Amount of data on the broker when using local SSD storage (for Intel Ice Lake)           | {{ local-ssd-v3-step }}                                                                               | {{ local-ssd-v3-max }}                           |
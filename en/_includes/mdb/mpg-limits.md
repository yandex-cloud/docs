#### Quotas {#mpg-quotas}

#|
|| Type of limit | Value ||
|| Connection time-to-live | 12 hours ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of processor cores for all database hosts per cloud 
`mdb.cpu.count` | 64 ||
|| Total virtual memory for all database hosts per cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters per cloud 
`mdb.ssd.size` | 4,096 GB ||
|#

#### Limits {#mpg-limits}

| Type of limit                                                                                                               | Minimum value                                                                            | Maximum value                            |
|:------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class                                                                                                                   | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of hosts per cluster when using an HDD or SSD network storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                                                               | 16                                               |
| Number of hosts per cluster when using non-replicated SSD or local SSD storage            | 3                                                                                               | 16                                               |
| Amount of data per host when using network SSD storage                                                       | 10 GB                                                                                           | 4,096 GB                                          |
| Amount of data per host when using network HDD storage                                                       | 10 GB                                                                                           | 2,048 GB                                          |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                                                                           | 10,230 GB                                         |
| Amount of data per host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB                                                                                          | 1,500 GB                                          |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)                      | {{ local-ssd-v3-step }}                                                                         | {{ local-ssd-v3-max }}                           |
| Connections per user                                                                                        | 1                                                                                               | 15,985                                            |
| Number of databases per cluster                                                                                        | 1                                                                                               | {{ all-mdb.max-databases }}                                             |
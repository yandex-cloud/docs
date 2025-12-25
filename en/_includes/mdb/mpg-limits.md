#### Quotas {#mpg-quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of CPU cores for all database hosts in a single cloud 
`mdb.cpu.count` | 64 ||
|| Total amount of virtual memory for all database hosts in a single cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters in a single cloud 
`mdb.ssd.size` | 4,096 GB ||
|| Number of GPUs 
`mdb.gpu.count` | 0 ||
|#

#### Limits {#mpg-limits}

| Type of limit                                                                                                               | Minimum value                                                                            | Maximum value                            |
|:------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class                                                                                                                   | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m4a-c224-m1792 (224 vCPU AMD Zen 4, 1,792 GB RAM) |
| Number of hosts per cluster configured with either HDD/SSD network storage or an ultra-fast triple-replicated SSD network storage | 1                                                                                               | 16                                               |
| Number of hosts per cluster configured with either non-replicated or local SSD storage            | 3                                                                                               | 16                                               |
| Data volume per host with SSD network storage                                                       | 10 GB                                                                                           | 4,096 GB                                          |
| Data volume per host with HDD network storage                                                       | 10 GB                                                                                           | 2,048 GB                                          |
| Data volume per host with either non-replicated SSD storage or ultra-fast triple-replicated SSD network storage | 93 GB                                                                                           | 10,230 GB                                         |
| Data volume per host with SSD local storage (for Intel Broadwell and Intel Cascade Lake platforms) | 100 GB                                                                                          | 1,500 GB                                          |
| Data volume per host with SSD local storage (for Intel Ice Lake platform)                      | {{ local-ssd-v3-step }}                                                                         | {{ local-ssd-v3-max }}                           |
| Connections per user                                                                                        | 1                                                                                               | 15,985                                            |
| Number of databases per cluster                                                                                        | 1                                                                                               | {{ all-mdb.max-databases }}                                             |
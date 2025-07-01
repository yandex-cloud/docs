#### Quotas {#mspqr-quotas}

#|
|| Limit type | Value ||
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

#### Limits {#mspqr-limits}

| Type of limit                                                        | Minimum value                                                                                                                                             | Maximum value                                |
|:---------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------|
| Host class                                                           | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m4a-c80-m640 (80 vCPU AMD Zen 3, 640 GB RAM) |
| Number of hosts per cluster when using an HDD or SSD network storage | 1                                                                                                                                                         | 7                                            |
| Amount of data per host when using an HDD or SSD network storage     | 10 GB                                                                                                                                                     | 512 GB                                       |
| Connections per user                                                 | 1                                                                                                                                                         | 15,985                                       |
| Number of databases per cluster                                      | 1                                                                                                                                                         | {{ all-mdb.max-databases }}                  |

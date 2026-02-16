#### Quotas {#mspqr-quotas}

#|
|| Type of limit | Value ||
|| Connection TTL | 12 hours ||
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

#### Limits {#mspqr-limits}

For {{ PG }} cluster limits, see [this {{ mpg-name }} guide](../../managed-postgresql/concepts/limits.md#mpg-limits).

| Type of limit                            | Minimum value                                                                                                                                      | Maximum value                        |
|:-------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------|
| Host class                                | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m4a-c80-m640 (80 vCPU AMD Zen 3, 640 GB RAM) |
| Number of shards per cluster               | 1                                                                                                                                                         | No limits                                |
| Number of `INFRA` hosts per cluster       | 1                                                                                                                                                         | 7                                            |
| Number of `ROUTER` hosts per cluster      | 1                                                                                                                                                         | No limits                                |
| Number of `COORDINATOR` hosts per cluster | 1                                                                                                                                                         | 5                                            |
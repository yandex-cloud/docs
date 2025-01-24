#### Quotas {#mmy-quotas}

| Type of limit                                                                | Value |
|:-------------------------------------------------------------------------------|:---------|
| Number of clusters per cloud                                            | 16       |
| Total number of processor cores for all database hosts per cloud | 96       |
| Total virtual memory for all database hosts per cloud   | 640 GB   |
| Total storage capacity for all clusters per cloud                     | 4,096 GB  |

#### Limits {#mmy-limits}

| Type of limit                                                                                                               | Minimum value                                                                               | Maximum value                                |
|:------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------|:-----------------------------------------------------|
| Host class                                                                                                                   | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Broadwell, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Cascade Lake, 640 GB RAM) |
| Number of hosts per cluster when using an HDD or SSD network storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                                                                  | 7                                                    |
| Number of hosts per cluster when using non-replicated SSD or local SSD storage            | 3                                                                                                  | 7                                                    |
| Amount of data per host when using network SSD storage                                                       | 10 GB                                                                                              | 6,144 GB                                              |
| Amount of data per host when using network HDD storage                                                       | 10 GB                                                                                              | 2,048 GB                                              |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                                                                              | 8,184 GB                                              |
| Amount of data per host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB                                                                                             | 1,500 GB                                              |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)                      | {{ local-ssd-v3-step }}                                                                            | {{ local-ssd-v3-max }}                               |
| Number of databases per cluster                                                                                        | 1                                                                                                  | {{ all-mdb.max-databases }}                                                 |
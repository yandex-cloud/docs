#### Quotas {#mmy-quotas}

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

#### Limits {#mmy-limits}

| Type of limit                                                                                                               | Minimum value                                                                               | Maximum value                                |
|:------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------|:-----------------------------------------------------|
| Host class                                                                                                                   | b1.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPUs, Intel Broadwell, 4 GB RAM) | m4a-c224-m1792 (224 vCPU, AMD Zen 4, 1,792 GB RAM) |
| Number of hosts per cluster configured with either HDD/SSD network storage or an ultra high-speed SSD network storage with three replicas | 1                                                                                                  | 7                                                    |
| Number of hosts per cluster configured with either non-replicated or local SSD storage            | 3                                                                                                  | 7                                                    |
| Amount of data per host with SSD network storage                                                       | 10 GB                                                                                              | 6,144 GB                                              |
| Amount of data per host with HDD network storage                                                       | 10 GB                                                                                              | 2,048 GB                                              |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network SSD storage with three replicas | 93 GB                                                                                              | 8,184 GB                                              |
| Amount of data per host when using a local SSD storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB                                                                                             | 1,500 GB                                              |
| Amount of data per host when using a local SSD storage (for Intel Ice Lake)                      | {{ local-ssd-v3-step }}                                                                            | {{ local-ssd-v3-max }}                               |
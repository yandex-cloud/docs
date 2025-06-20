#### Quotas {#quotas}

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


#### Limits {#limits}

| Type of limit                                                                                               | Minimum value                             | Maximum value                            |
|:--------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|:-------------------------------------------------|
| Host class                                                                                                   | s2.medium (8 vCPU Intel Cascade Lake, 32 GB RAM) | i3-c40-m320 (40 vCPU Intel Ice Lake, 320 GB RAM) |
| Number of master hosts in the cluster                                                                         | 2                                                | 2                                                |
| Number of segment hosts in the cluster                                                                        | 2                                                | 32                                               |
| Number of segments per host                                                                                  | 1                                                | 16                                               |
| Amount of data on the host when using HDD network storage                                       | 10 GB                                            | 2048 GB                                          |
| Amount of data per host when using network SSD storage                                       | 10 GB                                            | 8,192 GB                                          |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                            | 8,184 GB                                          |
| Amount of data on the host when using local SSD storage (for Intel Cascade Lake)  | 100 GB                                           | 1,500 GB                                          |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)      | {{ local-ssd-v3-step }}                          | {{ local-ssd-v3-max }}                           |
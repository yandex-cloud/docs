#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud 
`mdb.clusters.count` | 16 ||
|| Total number of processor cores for all hosts per cloud 
`mdb.cpu.count` | 64 ||
|| Total virtual memory for all hosts per cloud 
`mdb.memory.size` | 512 GB ||
|| Total storage capacity for all clusters per cloud 
`mdb.ssd.size` | 4,096 GB ||
|#

#### Limits {#limits}

| Type of limit                                                                                                                    | Minimum value                                      | Maximum value                                       |
|:-----------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------|:------------------------------------------------------------|
| Host class                                                                                                                        | b2.medium (2 vCPU Intel Cascade Lake, 4 GB RAM, 50% vCPU) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM, 100% vCPU) |
| Number of `OPENSEARCH` type host groups                                                                                          | 1                                                         | 10                                                          |
| Number of hosts per `OPENSEARCH` type group when using an HDD or SSD network storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                         | 10                                                          |
| Number of hosts per `OPENSEARCH` type group when using non-replicated or local SSD storage | 3                                                         | 10                                                          |
| Number of `DASHBOARDS` type host groups                                                                                          | 1                                                         | 1                                                           |
| Number of hosts per `DASHBOARDS` type group                                                                                       | 1                                                         | 2                                                           |
| Amount of data on the host when using network HDD or SSD storage                                  | 16 GB                                                     | 4,096 GB                                                     |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network storage with three replicas (SSD) | 93 GB                                                     | 8,184 GB                                                     |
| Amount of data on the host when using local SSD storage (for Intel Cascade Lake)                       | 100 GB                                                    | 1,500 GB                                                     |
| Amount of data per host when using local SSD storage (for Intel Ice Lake)                           | {{ local-ssd-v3-step }}                                   | {{ local-ssd-v3-max }}                                      |
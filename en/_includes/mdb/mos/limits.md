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
|| Number of GPUs 
`mdb.gpu.count` | 0 ||
|#

#### Limits {#limits}

| Type of limit                                                                                                                                                                         | Minimum value                                      | Maximum value                                       |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------|:------------------------------------------------------------|
| Host class                                                                                                                                                                             | b2.medium (2 vCPUs Intel Cascade Lake, 4 GB RAM, 50% vCPU) | m4a-c224-m1792 (224 vCPUs AMD Zen 4, 1,792 GB RAM, 100% vCPU) |
| Number of `OPENSEARCH` host groups                                                                                                                                               | 1                                                         | 10                                                          |
| Number of hosts per `OPENSEARCH` group when using a network HDD or SSD storage or an ultra high-speed network storage with three replicas (SSD) | 1                                                         | 10                                                          |
| Number of hosts per `OPENSEARCH` group when using a non-replicated or local SSD storage                                                      | 3                                                         | 10                                                          |
| Number of `DASHBOARDS` host groups                                                                                                                                               | 1                                                         | 1                                                           |
| Number of hosts per `DASHBOARDS` group                                                                                                                                            | 1                                                         | 2                                                           |
| Amount of data per host when using a network HDD or SSD storage                                                                                       | 16 GB                                                     | 4,096 GB                                                     |
| Amount of data per host when using a non-replicated SSD storage or an ultra high-speed network SSD storage with three replicas              | 93 GB                                                     | 8,184 GB                                                     |
| Amount of data per host when using a local SSD storage (for Intel Cascade Lake)                                                                            | 100 GB                                                    | 1,500 GB                                                     |
| Amount of data per host when using a local SSD storage (for Intel Ice Lake)                                                                                | {{ local-ssd-v3-step }}                                   | {{ local-ssd-v3-max }}                                      |
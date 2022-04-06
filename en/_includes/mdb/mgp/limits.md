## Quotas {#quotas}

| Type of limit                                              | Value   |
|------------------------------------------------------------|---------|
| Number of clusters per cloud                               | 16      |
| Total number of processor cores for all DB hosts per cloud | 96      |
| Total virtual memory for all DB hosts per cloud            | 640 GB  |
| Total storage capacity for all clusters per cloud          | 4096 GB |

## Limits {#limits}

| Type of limit                                                                                 | Minimum value                                    | Maximum value                                    |
|-----------------------------------------------------------------------------------------------|--------------------------------------------------|--------------------------------------------------|
| Host class                                                                                    | s2.medium (8 vCPU Intel Cascade Lake, 32 GB RAM) | i3-c40-m320 (40 vCPU Intel Ice Lake, 320 GB RAM) |
| Number of master hosts per cluster                                                            | 2                                                | 2                                                |
| Number of segment hosts per cluster                                                           | 2                                                | 32                                               |
| Number of segments per host                                                                   | 1                                                | 16                                               |
| Amount of data on the host when using standard network storage                                | 10 GB                                            | 2048 GB                                          |
| Amount of data on the host when using fast network storage                                    | 10 GB                                            | 8192 GB                                          |
| Amount of data on the host when using non-replicated network storage (for segment hosts only) | 93 GB                                            | 8184 GB                                          |
| Amount of data on the host when using local storage                                           | 100 GB                                           | 1500 GB                                          |

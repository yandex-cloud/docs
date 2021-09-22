## Quotas {#quotas}

| Type of limit                                              | Value   |
|------------------------------------------------------------|---------|
| Number of clusters per cloud                               | 16      |
| Total number of processor cores for all DB hosts per cloud | 64      |
| Total virtual memory for all DB hosts per cloud            | 512 GB  |
| Total storage capacity for all clusters per cloud          | 4096 GB |


## Limits {#limits}

{% if state == "public-preview" %}

| Type of limit                                                           | Minimum value                                  | Maximum value                                                |
|-------------------------------------------------------------------------|------------------------------------------------|--------------------------------------------------------------|
| Host class                                                              | s2.micro (2 vCPU Intel Cascade Lake, 8 GB RAM) | m2.9xlarge (80 vCPU Intel Cascade Lake, 640 GB RAM)          |
| Number of master hosts per cluster                                      | 1                                              | 2                                                            |
| Number of segment hosts per cluster                                     | 2                                              | 32                                                           |
| Number of segments per host                                             | 1                                              | Is equal to the number of vCPUs for the selected class of host segments |
| Amount of data on the host when using standard network storage          | 10 GB                                          | 2048 GB                                                      |
| Amount of data on the host when using fast network storage              | 10 GB                                          | 4096 GB                                                      |
| Amount of data on the host when using local storage                     | 100 GB                                         | 1500 GB                                                      |

{% else %}

| Type of limit                                                                                             | Minimum value                                  | Maximum value                                                |
|-----------------------------------------------------------------------------------------------------------|------------------------------------------------|--------------------------------------------------------------|
| Host class                                                                                                | s2.micro (2 vCPU Intel Cascade Lake, 8 GB RAM) | m2.9xlarge (80 vCPU Intel Cascade Lake, 640 GB RAM)          |
| Number of master hosts per cluster                                                                        | 1                                              | 2                                                            |
| Number of segment hosts per cluster                                                                       | 2                                              | 32                                                           |
| Number of segments per host                                                                               | 1                                              | Is equal to the number of vCPUs for the selected class of host segments |
| Amount of data on the host when using standard network storage                                            | 10 GB                                          | 2048 GB                                                      |
| Amount of data on the host when using fast network storage                                                | 10 GB                                          | 4096 GB                                                      |
| Amount of data on the host when using non-replicated network storage (only for segment hosts)             | 93 GB                                          | 8184 GB                                                      |
| Amount of data on the host when using local storage                                                       | 100 GB                                         | 1500 GB                                                      |

{% endif %}

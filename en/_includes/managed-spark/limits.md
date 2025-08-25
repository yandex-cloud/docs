#### Quotas {#quotas}

| Type of limit                                                                                | Value |
|:-----------------------------------------------------------------------------------------------|:---------|
| Number of clusters per cloud                                                            | 2        |
| Total number of processor cores for all hosts for drivers and executors per cloud | 128      |
| Total virtual memory for all hosts for drivers and executors per cloud   | 256 GB   |

#### Limits {#limits}

| Type of limit                               | Minimum value     | Maximum value          |
|:----------------------------------------------|:-------------------------|:-------------------------------|
| Host class                                   | c2-m8 (2 vCPUs, 8 GB RAM) | c32-m256 (32 vCPUs, 256 GB RAM) |
| Number of hosts for drivers per cluster    | 0                        | 100                            |
| Number of hosts for executors per cluster | 0                        | 100                            |
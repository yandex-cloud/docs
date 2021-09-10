#### Quotas {#mpg-quotas}

| Type of limit                                              | Value   |
|------------------------------------------------------------|---------|
| Number of clusters per cloud                               | 16      |
| Total number of processor cores for all DB hosts per cloud | 96      |
| Total virtual memory for all DB hosts per cloud            | 640 GB  |
| Total storage capacity for all clusters per cloud          | 4096 GB |

#### Limits {#mpg-limits}

| Type of limit | Minimum value | Maximum value |
|---------------|---------------|---------------|
| Host class | b1.nano ([5%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 2 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of hosts in a cluster when using standard or fast network storage | 1 | 7 |
| Number of hosts in a cluster when using non-replicated network storage or fast local storage | 3 | 7 |
| Amount of data on the host when using standard or fast network storage | 10 GB | 2048 GB |
| Amount of data on the host when using non-replicated network storage | 93 GB | 8192 GB |
| Amount of data on the host when using local storage | 100 GB | 1400 GB |

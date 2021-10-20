#### Quotas {#mkf-quotas}

| Type of limit                                                  | Value   |
|----------------------------------------------------------------|---------|
| Number of clusters per cloud                                   | 16      |
| Total number of processor cores for all broker hosts per cloud | 96      |
| Total virtual memory for all broker hosts per cloud            | 640 GB  |
| Total storage capacity for all clusters per cloud              | 4096 GB |

#### Limits {#mkf-limits}

| Type of limit | Minimum value | Maximum value |
|---------------|---------------|---------------|
| Host class | b2.medium ([50%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Cascade Lake, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of broker hosts in a cluster when using standard or fast network storage | 1 | 7 |
| Number of broker hosts in a cluster when using non-replicated network storage or fast local storage | 3 | 7 |
| Amount of data on the broker host when using fast network storage | 10 GB | 4096 GB |
| Amount of data on the broker host when using standard network storage | 10 GB | 2048 GB |
| Amount of data on the broker host when using non-replicated network storage | 93 GB | 8184 GB |
| Amount of data on the broker host when using local storage | 100 GB | 1500 GB |

#### Quotas {#mkf-quotas}

| Type of limit | Value |
|:-----------------------------------------------------------------------------|:---------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all broker hosts per cloud | 96 |
| Total virtual memory for all broker hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |


#### Limits {#mkf-limits}

| Type of limit | Minimum value | Maximum value |
|:---------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| Host class | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of brokers in a cluster when using HDD or SSD network storage | 1 | 36 |
| Number of brokers in a cluster when using non-replicated or local SSDs | 3 | 36 |
| Amount of data on the broker when using SSD network storage | 10 GB | 4096 GB |
| Amount of data on the broker when using HDD network storage | 10 GB | 2048 GB |
| Amount of data on the broker when using non-replicated SSD storage | 93 GB | 8184 GB |
| Amount of data on the broker when using local SSD storage (for Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the broker when using local SSD storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |

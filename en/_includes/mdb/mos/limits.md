#### Quotas {#quotas}

| Type of limit | Value |
|:--------------------------------------------------------------------|:---------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all hosts per cloud | 96 |
| Total virtual memory for all hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#limits}

| Type of limit | Minimum value | Maximum value |
|:-----------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------|:------------------------------------------------------------|
| Host class | b2.medium (2 vCPU Intel Cascade Lake, 4 GB RAM, 50% vCPU) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM, 100% vCPU) |
| Number of `OPENSEARCH` host groups | 1 | 10 |
| Number of hosts in a group of the `OPENSEARCH` type when using HDD or SSD network storage | 1 | 10 |
| Number of hosts in a group of the `OPENSEARCH` type when using non-replicated or local SSDs | 3 | 10 |
| Number of `DASHBOARDS` host groups | 1 | 1 |
| Number of hosts in a group of the `DASHBOARDS` type | 1 | 2 |
| Amount of data on the host when using HDD or SSD network storage | 10 GB | 4096 GB |
| Amount of data on the host when using non-replicated SSD storage | 93 GB | 8184 GB |
| Amount of data on the host when using local SSD storage (for the Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the host when using local SSD storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |

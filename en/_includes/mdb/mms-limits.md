#### Quotas {#mms-quotas}

| Limits | Value |
|:-------|:---------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all the database hosts in a cloud | 96 |
| Total virtual memory for all DBs per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mms-limits}

| Limits | Minimum value | Maximum value |
|:-------|:--------------|:--------------|
| Host class | s1.micro (2 vCPU Intel Broadwell, 8 GB RAM) | m3-c16-m128 (16 vCPU Intel Ice Lake, 128 GB RAM) for Standard Edition, m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) for Enterprise Edition |
| Number of vCPUs per cluster | 2 | 24 for Standard Edition and 448 for Enterprise Edition |
| Amount of RAM per cluster | 8 GB | 128 GB for Standard Edition, 4480 GB for Enterprise Edition |
| Number of hosts in a cluster when using standard or fast network storage | 1 | 1 for Standard Edition and 7 for Enterprise Edition |
| Number of hosts in a cluster when using non-replicated network storage or fast local storage | 3 for Enterprise Edition | 7 for Enterprise Edition |
| Amount of data on the host when using fast network storage | 10 GB | 4096 GB |
| Amount of data on the host when using standard network storage | 10 GB | 2048 GB |
| Amount of data on the host when using non-replicated network storage | 93 GB | 8184 GB |
| Amount of data on the host when using local storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the host when using local storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |


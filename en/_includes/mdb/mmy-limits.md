#### Quotas {#mmy-quotas}

| Limits | Value |
| :------------------------------------------------------------------------------- | :--------- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 96 |
| Total virtual memory for all DB hosts per cloud | 640 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mmy-limits}

| Limits | Minimum value | Maximum value |
| :------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------ | :----------------------------------------------------- |
| Host class | b1.nano (2 × {% if audience != "internal" %}[5%](../../compute/concepts/performance-levels.md){% else %}5%{% endif %} vCPU Intel Broadwell, 2 GM RAM) | m3-c80-m640 (80 vCPU Intel Cascade Lake, 640 GB RAM) |
| Number of hosts in a cluster when using HDD network or SSD network storage | 1 | 7 |
| Number of hosts in a cluster when storing data on non-replicated or local SSDs | 3 | 7 |
| Amount of data on the host when using SSD network storage | 10 GB | 4096 GB |
| Amount of data on the host when using HDD network storage | 10 GB | 2048 GB |
| Amount of data on the host when using non-replicated SSD storage | 93 GB | 8184 GB |
| Amount of data on the host when using local SSD storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the host when using local SSD storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |

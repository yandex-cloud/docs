#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud
`managed-trino.clusters.count` | 10 ||
|| Total number of processor cores for all cluster components per cloud
`managed-trino.cpu.count` | 120 ||
|| Total virtual memory for all cluster components per cloud
`managed-trino.memory.size` | 480 GB ||
|#

#### Limits {#limits}

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Host class                    | c4-m16 (4 vCPUs, 16 GB RAM) | c8-m32 (8 vCPUs, 32 GB RAM) |
| Number of workers per cluster | 1                          | 64                         |
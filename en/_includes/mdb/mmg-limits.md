#### Quotas

| Type of limit | Value |
| ----- | ----- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 64 |
| Total virtual memory for all DB hosts per cloud | 512 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | b1.nano ([5%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 2 GB RAM) |
| Highest host class | m2.8xlarge (64 vCPU Intel Cascade Lake, 512 GB RAM) |
| Maximum number of shards per cluster {{ MG }} | 10 |
| Maximum number of hosts per shard | 7 |
| Maximum number of hosts per cluster | 70 (10 shards × 7 hosts) |
| Maximum storage capacity for a cluster | 512 GB |
| Maximum number of simultaneous connections to a single cluster host | Depends on the total amount of RAM on the host, see below |

{% include [mmg-conn-limits](mmg-conn-limits.md) %}


#### Quotas {#mch-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 64 |
| Total virtual memory for all DB hosts per cloud | 512 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mch-limits}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | b1.nano ([5%](../../compute/concepts/performance-levels.md) × 2 vCPU Intel Broadwell, 2 GB RAM) |
| Highest host class | m2.8xlarge (64 vCPU Intel Cascade Lake, 512 GB RAM) |
| Maximum number of shards per cluster | 50 |
| Maximum number of hosts per shard | 7 |
| Maximum number of hosts per cluster | 353 (50 shards × 7 hosts + 3 {{ ZK }} hosts) |
| Maximum amount of data on the host when using network storage | 4096 GB |
| Maximum amount of data on the host when using local storage | 1400 GB |


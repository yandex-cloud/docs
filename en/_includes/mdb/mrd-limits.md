#### Quotas

| Type of limit | Value |
| ----- | ----- |
| Number of clusters per cloud | 8 |
| Total number of processor cores for all DB hosts per cloud | 8 |
| Total virtual memory for all hosts per cloud | 32 GB |
| Total disk storage capacity for all clusters per cloud | 200 GB |

#### Limits

{% if audience == "internal" %}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | b1.nano (`burstable` with 2 GB RAM) |
| Highest host class | hm1.9xlarge (`high-memory` with 256 GB RAM) |
| Maximum number of hosts per cluster | 7 |
| Minimum disk size per cluster | 2 times more than the amount of RAM selected |
| Maximum disk size per cluster | 8 times more than the amount of RAM selected |
| Minimum number of shards in a sharded cluster | 3 |
| Maximum number of shards in a sharded cluster | 10 |
| Minimum number of hosts per shard | 1 |
| Maximum number of hosts per shard | 7 |

{% else %}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | b1.nano (`burstable` with 2 GB RAM) |
| Highest host class | hm1.9xlarge (`high-memory` with 256 GB RAM) |
| Maximum number of hosts per cluster | 7 |
| Minimum disk size per cluster | 2 times more than the amount of RAM selected |
| Maximum disk size per cluster | 8 times more than the amount of RAM selected |

{% endif %}


#### Quotas {#mrd-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 64 |
| Total virtual memory for all DB hosts per cloud | 512 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mrd-limits}


| Type of limit | Minimum value | Maximum value |
| ----- | ----- | ---- |
| Host class | b1.nano (`burstable` with 2 GB RAM) | hm3-c32-m512 (32 vCPU Intel Ice Lake, 512 GB RAM) |
| Number of hosts in an unsharded cluster | 1 | 7 |
| Number of shards in a sharded cluster | 3 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 2 | 7 |
| Number of hosts in a sharded cluster | 3 (3 shards × 1 host) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | Twice the amount of RAM selected | {{ mrd-max-disk-size }} |
| Amount of data on the host when using local storage | 100 GB | 1500 GB |

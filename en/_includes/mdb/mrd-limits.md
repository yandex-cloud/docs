#### Quotas {#mrd-quotas}

| Limits | Value |
|:-------|:------|
| Number of clusters per cloud | 16 |
| Total number of processor cores for all the database hosts in a cloud | 64 |
| Total virtual memory for all DBs per cloud | 512 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mrd-limits}

{% if audience == "internal" %}

| Limits | Minimum value | Maximum value |
|:-------|:--------------|:--------------|
| Host class | b1.nano (`burstable` with 2 GB RAM) | hm3-c32-m512 (32 vCPU Intel Ice Lake, 512 GB RAM) |
| Number of hosts in an unsharded cluster | 1 | 7 |
| Number of shards in a sharded cluster | 3 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 2 | 7 |
| Number of hosts in a sharded cluster | 3 (3 shards × 1 host) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | Twice the amount of RAM selected | {{ mrd-max-disk-size }} |
| Amount of data on the host when using local storage (for Intel Broadwell and Intel Cascade Lake) | Twice the amount of RAM selected in increments of 100 GB | 1500 GB |
| Amount of data on the host when using local storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |

{% else %}

| Limits | Minimum value | Maximum value |
|:-------|:--------------|:--------------|
| Host class | b1.nano (`burstable` with 2 GB RAM) | hm3-c32-m512 (32 vCPU Intel Ice Lake, 512 GB RAM) |
| Number of hosts in an unsharded cluster | 1 | 7 |
| Number of shards in a sharded cluster | 3 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 2 | 7 |
| Number of hosts in a sharded cluster | 3 (3 shards × 1 host) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | Twice the amount of RAM selected | {{ mrd-max-disk-size }} |
| Amount of data on the host when using local storage (for Intel Broadwell and Intel Cascade Lake) | 100 GB | 1500 GB |
| Amount of data on the host when using local storage (for Intel Ice Lake) | {{ local-ssd-v3-step }} | {{ local-ssd-v3-max }} |

{% endif %}


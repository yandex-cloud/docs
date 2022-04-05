#### Quotas {#mrd-quotas}

| Limits | Value |
| :------------------------------------------------------------------------------- | :--------- |
| Number of clusters per cloud | 16 |
| Total number of processor cores for all DB hosts per cloud | 64 |
| Total virtual memory for all DB hosts per cloud | 512 GB |
| Total storage capacity for all clusters per cloud | 4096 GB |

#### Limits {#mrd-limits}


| Limits | Minimum value | Maximum value |
| :---------------------------------------------------------------------------------------------------------- | :-------------------------------------- | :-------------------------------------------------- |
| Host class | b1.nano (`burstable` with 2 GB RAM) | hm3-c32-m512 (32 vCPU Intel Ice Lake, 512 GB RAM) |
| Number of hosts in an unsharded cluster | 1 or 3 depending on the [storage type](../../managed-redis/concepts/storage.md#storage-type-selection) | 7 |
| Number of shards in a sharded cluster | 3 | 10 |
| Number of hosts in a shard when using SSD network storage | 1 | 7 |
| Number of hosts in a shard when using local SSD storage<sup>*</sup> | 2 | 7 |
| Number of hosts in a shard when using non-replicated SSD storage<sup>*</sup> | 3 | 7 |
| Number of hosts in a sharded cluster | 3, 6, or 9 hosts depending on the [storage type](../../managed-redis/concepts/storage.md#storage-type-selection) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using SSD network storage | Twice the amount of RAM selected | 4096 GB |
| Amount of data on the host when using non-replicated SSD storage<sup>*</sup> | Twice the amount of RAM selected, but no less than 93 GB | 8184 GB |
| Amount of data on the host when using local SSD storage<sup>*</sup> | Twice the amount of RAM selected, but no less than 100 GB | 1500 GB |

{% include [storage-limitations-mrd](./mrd/storage-limitations-note.md) %}

# Disk types in {{ mrd-name }}


{{ mrd-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mrd/storage-type.md) %}

## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ RD }} cluster depends on the disk type you select and whether you enabled [sharding](./sharding.md):

| Disk type | Non-sharded clusters | Sharded cluster |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Network SSD storage (`network-ssd`) | 1 host or more | 3 hosts or more (3 shards, 1 host) |
| Local SSD storage (`local-ssd`) | 3 hosts or more | 6 hosts or more (3 shards, 2 hosts) |
| Non-replicated SSD storage (`network-ssd-nonreplicated`) | 3 hosts or more | 9 hosts or more (3 shards, 3 hosts) |

For more information about limits on the number of hosts per cluster or shard, see [{#T}](./limits.md).


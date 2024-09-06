# Disk types in {{ mrd-name }}



{{ mrd-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mrd/storage-type.md) %}

## Selecting the disk type during cluster creation {#storage-type-selection}

The number of hosts you can create together with a {{ RD }} cluster depends on the disk type you select and whether you enabled [sharding](./sharding.md):

| Disk type | Non-sharded clusters | Sharded clusters |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Network SSD storage (`network-ssd`) | 1 host or more | 1 host or more (1 shard × 1 host) |
| Local SSD storage (`local-ssd`) | 3 hosts or more | 2 hosts or more (1 shard × 2 hosts) |
| Non-replicated SSD storage (`network-ssd-nonreplicated`) | 3 hosts or more | 3 hosts or more (1 shard × 3 hosts) |

Sharded clusters with the **local-ssd** disk type and only one host per shard are not considered fault-tolerant. You cannot create such a cluster.

For more information about limits on the number of hosts per cluster or shard, see [Quotas and limits](./limits.md).


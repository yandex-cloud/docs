# Disk types


{{ mrd-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mrd/storage-type.md) %}


## Specifics of local SSD storage {#local-storage-features}

This storage does not provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mrd-name }} cluster using this type of storage, a three-host fault-tolerant configuration is automatically set up.

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}


## Choice of disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created together with a {{ RD }} cluster depends on the disk type you select and on whether you enable [sharding](./sharding.md):

| Disk type | Non-sharded clusters | Sharded clusters |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Network SSD storage (`network-ssd`) | ⩾ 1 host | ⩾ 3 hosts (3 shards × 1 host) |
| Local SSD storage (`local-ssd`) | ⩾ 3 hosts | ⩾ 6 hosts (3 shards × 2 hosts) |
| Non-replicated SSD storage (`network-ssd-nonreplicated`) | ⩾ 3 hosts | ⩾ 9 hosts (3 shards × 3 hosts) |

Additional hosts are required to ensure fault tolerance.

For more information about limits on the number of hosts per cluster or shard, see [{#T}](./limits.md).


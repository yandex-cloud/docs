# Storage in {{ mmg-name }}

{% if audience != "internal" %}

{{ mmg-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mmg/storage-type.md) %}

## Specifics of local SSD storage {#Local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mmg-name }} cluster using local storage, a 3-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Choice of storage type during cluster creation {#storage-type-selection}

The number of hosts that can be created with a {{ MG }} cluster depends on the storage type selected:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts (to ensure fault tolerance, a minimum of three hosts is necessary).

* With `network-hdd` or `network-ssd` storage, you can add any number of hosts within the [current quota](./limits.md).

For more information about limits on the number of hosts per cluster or [shard](./sharding.md), see [{#T}](./limits.md).

{% else %}

{{ mmg-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disk storage (`local-hdd`): Uses slower but larger disks. Available only for hosts powered by Broadwell or Cascade Lake and with at least eight vCPUs. `local-hdd` storage has a fixed volume: 10240 GB for Broadwell and 12800 GB for Cascade Lake.

You can create a cluster of three or more hosts (a minimum of three hosts is required for fault tolerance).

{% endif %}

## Managing disk space {#manage-storage-space}

{% include [mmg-readonly-safeguard.md](../../_includes/mdb/mmg-readonly-safeguard.md) %}

After switching to read-only mode:

* Write operations will not be allowed on the host and only read operations will be possible.
* If the host was a [primary replica](replication.md) before switching to read-only mode, this role will be automatically assigned to another cluster host, because the primary replica role requires permission to write to the disk.

If the amount of data in the cluster keeps growing, all the hosts will switch to read-only mode, one by one, and the cluster will stop accepting data to write.

### Maintaining the health of a cluster {#read-only-solutions}

To make sure a cluster is operational when the host switches to read-only:
* [Increase the disk space on the host](../operations/update.md#change-disk-size). Once there is enough space on the host, {{ yandex-cloud }} disables read-only mode automatically.
* [Add additional shards to the cluster](../operations/shards.md#add-shard). Read-only mode won't be lifted on this host, but the cluster will be able to continue working normally provided there is free disk space on the other shards.
* Contact [technical support]({{ link-console-support }}) and ask them to temporarily disable this host's read-only mode to manually delete a part of the data.

   {% note alert %}

   If you run out of free disk space completely, {{ MG }} will crash and the cluster will be disabled.

   {% endnote %}

* [Force the synchronization](../operations/hosts.md#resetup) of data between hosts. This can help when a large amount of data was deleted from the cluster, but the disk space was not released (marked as available for reuse).

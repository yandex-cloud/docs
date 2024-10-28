# Storage in {{ mmg-name }}


{{ mmg-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mmg/storage-type.md) %}

## Selecting the disk type during cluster creation {#storage-type-selection}

The number of hosts you can create together with a {{ MG }} cluster depends on the selected disk type:

* When using storage on local SSDs (`local-ssd`) or non-replicated SSDs (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant.

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* With HDD (`network-hdd`) or SSD (`network-ssd`) network storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster or [shard](./sharding.md), see [Quotas and limits](./limits.md).


## Disk space management {#manage-storage-space}

{% include [mmg-readonly-safeguard.md](../../_includes/mdb/mmg-readonly-safeguard.md) %}

After a transition to read-only mode:

* Write queries stop being allowed on the host. You can only make read queries.
* If the host was a [primary replica](replication.md) before switching to read-only mode, this role will be automatically assigned to another cluster host, because the primary replica role requires permission to write to the disk.

If the amount of data in the cluster keeps growing, all hosts will switch to read-only mode one by one and the cluster will stop accepting data to write.

### Maintaining a cluster in operable condition {#read-only-solutions}

To keep your cluster up and running as the host is switching over to read-only:
* [Increase the disk space on the host](../operations/update.md#change-disk-size). Once there is enough space on the host, {{ yandex-cloud }} will clear read-only mode automatically.
* [Add more shards to the cluster](../operations/shards.md#add-shard). The read-only mode will not be cleared on this host, but the cluster will be able to keep working normally as long as there is free disk space on the other shards.
* Ask [support]({{ link-console-support }}) to temporarily suspend read-only mode on this host to manually delete some of the data.

   {% note alert %}

   If free disk space drops to zero, {{ MG }} will crash and the cluster will stop operating.

   {% endnote %}

* [Force data synchronization](../operations/hosts.md#resetup) between hosts. This can help when a large amount of data was deleted from the cluster, but the disk space was not released (marked as available for reuse).

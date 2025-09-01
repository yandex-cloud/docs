---
title: Storage in {{ mmg-full-name }}
description: In this article, you will learn what storage is in {{ mmg-name }}, how to manage disk space, and how to select the right disk type when creating a cluster.
---

# {{ mmg-name }} storage


{{ mmg-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mmg/storage-type.md) %}

## Selecting disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ SD }} cluster depends on the selected disk type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)

   This cluster will be fault-tolerant.

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* You can add any number of hosts within the current quota when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster or [shard](./sharding.md), see [Quotas and limits](./limits.md).



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Disk space management {#manage-storage-space}

{% include [mmg-readonly-safeguard.md](../../_includes/mdb/mmg-readonly-safeguard.md) %}

After switching to read-only mode:

* Write queries stop being allowed on the host. You can only make read queries.
* If the host was a [primary replica](replication.md) before switching to read-only mode, this role will be automatically assigned to another cluster host as the primary replica should be able to write to the disk.

If the cluster's data volume keeps growing, all hosts will enter read-only mode one by one and the cluster will eventually stop accepting data for writing.

### Maintaining a cluster in operable condition {#read-only-solutions}

To keep your cluster up and running as the host is switching over to read-only:
* [Increase the disk space on the host](../operations/update.md#change-disk-size). Once there is enough space on the host, {{ yandex-cloud }} will clear read-only mode automatically.
* [Add more shards to the cluster](../operations/shards.md#add-shard). Read-only mode will not be cleared on this host, but the cluster will be able to keep working normally as long as there is free disk space on the other shards.
* Ask [support]({{ link-console-support }}) to temporarily suspend the read-only mode on this host to manually delete some of the data.

   {% note alert %}

   If free disk space drops to zero, {{ SD }} will crash and the cluster will stop operating.
  
   {% endnote %}

* [Force data synchronization](../operations/hosts.md#resetup) between hosts. This can help when a large amount of data was deleted from the cluster, but the disk space was not released (marked as available for reuse).

## Use cases {#examples}

* [{#T}](../tutorials/data-migration.md)
* [{#T}](../tutorials/storedoc-migration-with-data-transfer)
* [{#T}](../tutorials/storedoc-versions)
* [{#T}](../tutorials/profiling.md)

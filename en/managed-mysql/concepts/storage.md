---
title: Disk types in {{ mmy-full-name }}
description: In this article, you will learn about disk types in {{ mmy-name }} and discover how to select the right disk type when creating a cluster.
---

# {{ mmy-name }} storage



{{ mmy-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mmy/storage-type.md) %}

## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts you can create together with a {{ MY }} cluster depends on the selected disk type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)

   This cluster will be [highly available](high-availability.md).

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* You can add any number of hosts within the [current quota](./limits.md) when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)
    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Disk space management {#manage-storage-space}

When the storage is more than 95% full, the host will automatically switch to read-only mode. Also, the `read_only = 1` system variable will be set on the master host.

In this mode, the `INSERT`, `DELETE`, and `UPDATE` queries fail with an error.

To recover a {{ mmy-name }} cluster from read-only mode, [increase its storage size](../operations/update.md#change-disk-size).


To monitor storage utilization, [set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration).


### Automatic increase of storage size {#disk-size-autoscaling}

Automatic storage size increase prevents situations where the disk runs out of free space and hosts switch to read-only mode. The storage size increases upon reaching the specified threshold percentage of the total capacity. There are two thresholds:

* Scheduled increase threshold: To plan this increase, an algorithm analyzes data from the last few hours and estimates how quickly the storage is filling up. If the calculations show that the specified threshold will be exceeded by the start of the nearest [maintenance window](maintenance.md#maintenance-window), the system schedules a storage increase. If a check at the maintenance start shows that the threshold was indeed exceeded, the storage size is increased.

* Immediate increase threshold: When reached, the storage size increases immediately.

You can use one or both thresholds. If you set both thresholds, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mmy/storage-resize-steps.md) %}

You can configure automatic increase of storage size when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md). If you set the scheduled increase threshold, you also need to configure the [maintenance window](maintenance.md#maintenance-window) schedule.

{% note warning %}

* Automatic increase of storage size is not supported on dedicated hosts.

* While resizing the storage, cluster hosts will be unavailable.

* You cannot decrease the storage size.

{% endnote %}


## Use cases {#examples}

* [{#T}](../tutorials/sync-mysql.md)
* [{#T}](../tutorials/bitrix-shop/index.md)
* [{#T}](../tutorials/bitrix-website/index.md)
* [{#T}](../tutorials/opencart/index.md)


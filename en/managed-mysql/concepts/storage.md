---
title: Disk types in {{ mmy-full-name }}
description: In this article, you will learn about disk types in {{ mmy-name }} and discover how to select the right disk type when creating a cluster.
---

# Storage in {{ mmy-name }}



{{ mmy-name }} allows you to use network and local storage drives for database clusters. Network disks are based on network blocks, i.e., virtual disks in the {{ yandex-cloud }} infrastructure. Local drives are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mmy/storage-type.md) %}

## Selecting the disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ MY }} cluster depends on the selected disk type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)

   This cluster will be [highly available](high-availability.md).

   Storage on local SSDs increases your cluster costs: you pay for the cluster even if it is stopped. For more information, see the [pricing policy](../pricing.md).

* You can add any number of hosts within the [current quota](./limits.md) when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)
    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Managing disk space {#manage-storage-space}

When the storage is more than 97% full, {{ mmy-name }} automatically switches the host to `read-only` mode. Also, the `read_only = 1` system variable will be set on the master host.

In this mode, the `INSERT`, `DELETE`, and `UPDATE` queries fail with an error.

To recover a {{ mmy-name }} cluster from read-only mode, [increase its storage size](../operations/update.md#change-disk-size).


To monitor storage utilization, [set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration).


### Automatic storage expansion {#disk-size-autoscaling}

Automatic storage size increase prevents situations where the disk runs out of free space and hosts switch to read-only mode. The storage size increases upon reaching the specified threshold percentage of the total capacity. There are two thresholds:

* Scheduled expansion threshold: To schedule such an expansion, an algorithm analyzes data from the last few hours and estimates how quickly the storage is filling up. If the calculations show that the threshold will be exceeded by the start of the nearest [maintenance window](maintenance.md#maintenance-window), the system schedules a storage expansion. If a check at the maintenance start shows that the threshold was indeed exceeded, the storage size is increased.

* Immediate expansion threshold: When reached, the storage expands immediately.

You can use one or both thresholds. If you set both thresholds, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mmy/storage-resize-steps.md) %}

You can configure automatic storage expansion when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md). If you set the scheduled increase threshold, you also need to configure the [maintenance window](maintenance.md#maintenance-window) schedule.

{% note warning %}

* Automatic storage expansion is not supported on dedicated hosts.

* When scaling your storage, the cluster hosts will be unavailable.

* You cannot reduce the storage size.

{% endnote %}


## Use cases {#examples}

* [{#T}](../tutorials/sync-mysql.md)
* [{#T}](../tutorials/bitrix-shop/index.md)
* [{#T}](../tutorials/bitrix-website/index.md)
* [{#T}](../tutorials/opencart/index.md)


---
title: Storage in {{ mpg-full-name }}
description: In this article, you will learn what storage is in {{ mpg-name }}, how to manage disk space, and how to select the right disk type when creating a cluster.
---

# Storage in {{ mpg-name }}



{{ mpg-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, i.e., virtual disks in the {{ yandex-cloud }} infrastructure. Local drives are physically located on the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/mpg/storage-type.md) %}

## Selecting disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ PG }} cluster depends on the selected disk type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)

    This cluster will be fault-tolerant.

    Storage on local SSDs increases your cluster costs: you pay for the cluster even if it is stopped. For more information, see the [pricing policy](../pricing.md).

* You can add any number of hosts within the current quota when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)
    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).




## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Managing disk space {#manage-storage-space}

When the storage usage exceeds 97%, the host automatically switches to read-only mode. All DBs get the `DEFAULT_TRANSACTION_READ_ONLY = TRUE` setting through the `ALTER DATABASE` query.

In this mode, the `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


You can monitor storage utilization on cluster hosts [by setting up alerts in {{ monitoring-full-name }}](../operations/storage-space.md#set-alert):


### Recovering a cluster from read-only mode {#read-only-solutions}

Use one of these methods:

* [Increase the storage capacity](../operations/storage-space.md#change-disk-size) to exceed the threshold value. {{ mpg-short-name }} will then disable read-only mode automatically.

* [Disable read-only mode manually](../operations/storage-space.md#read-only-solutions) and free up storage space by deleting some data.

    {% note alert %}

    When doing so, make sure the amount of free disk space never reaches zero. Otherwise, with the fail-safe mechanism disabled, {{ PG }} will crash, rendering the cluster inoperable.

    {% endnote %}

### Automatic storage expansion {#auto-rescale}

Automatic storage size increase prevents situations where the disk runs out of free space and hosts switch to read-only mode. The storage size increases upon reaching the specified threshold percentage of the total capacity. There are two thresholds:

* Scheduled expansion threshold: To schedule such an expansion, an algorithm analyzes data from the last few hours and estimates how quickly the storage is filling up. If the calculations show that the threshold will be exceeded by the start of the nearest [maintenance window](maintenance.md#maintenance-window), the system schedules a storage expansion. If a check at the maintenance start shows that the threshold was indeed exceeded, the storage size is increased.

* Immediate expansion threshold: When reached, the storage size increases immediately.

You can use either one or both thresholds. If you set both, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}

You can configure automatic storage expansion when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/storage-space.md#disk-size-autoscale). If you set the scheduled increase threshold, you also need to configure the maintenance window schedule.

{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

## Use cases {#examples}

* [{#T}](../tutorials/data-recording.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/mlflow-datasphere.md)
* [{#T}](../tutorials/datalens.md)

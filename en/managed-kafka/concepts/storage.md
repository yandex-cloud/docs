---
title: Storage in {{ mkf-full-name }}
description: In this article, you will learn what a storage is in {{ mkf-name }}, its minimum size, and the maximum size of a log segment. You will also learn about the automatic storage size increase mechanism and some things you should consider when selecting disk type for your new cluster.
---

# Storage in {{ mkf-name }}


{{ mkf-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on [broker servers](brokers.md).

{% include [storage-type-nrd](../../_includes/mdb/mkf/storage-type.md) %}


## Selecting the disk type during cluster creation {#storage-type-selection}


The number of broker hosts you can create together with an {{ KF }} cluster depends on the selected disk type:

* With local SSDs (`local-ssd`) or non-replicated SSDs (`network-ssd-nonreplicated`), you can create a cluster with three or more broker hosts.

    This cluster will be fail-safe only if it meets all [fault tolerance conditions](index.md#fault-tolerance).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of broker hosts within the current quota.

For more information about limits on the number of broker hosts per cluster, see [Quotas and limits](./limits.md).



## Minimum storage size {#minimal-storage-size}

In order to work, each [topic](topics.md#topics) requires space in broker host storage. The amount of such space depends on the replication factor and the number of [partitions](topics.md#partitions). If there is not enough available storage space, you will not be able to create a new topic.

{% note tip %}

You can always [increase](../operations/storage-space.md#change-disk-size) the storage size up to the current [quota]({{ link-console-quotas }}).

{% endnote %}

You can calculate the minimum storage size for all topics using the formula below:

`2 × maximum log segment size × number of partitions in cluster × replication factor`

If topic partitions are evenly distributed, divide the value calculated with this formula by the number of broker hosts.

## Maximum log segment size {#maximum-log-segment-size}

At least two log segments are required for each replica of a topic partition. You can set the maximum size of such a segment:
* [At the topic level](../operations/cluster-topics.md#update-topic) using the [Segment bytes](settings-list.md#settings-topic-segment-bytes) setting.
* Globally at the [cluster level](../operations/cluster-update.md#change-kafka-settings) using the [Log segment bytes](settings-list.md#settings-log-segment-bytes) setting.

Thus, the minimum storage size for all topics is: `2 × maximum log segment size × number of partitions in cluster × replication factor`. If the cluster partitions are evenly distributed, you can divide the resulting value by the number of brokers to determine the required storage size per broker.

By default, the segment size is 1 GB.

## Disk space management {#manage-storage-space}

Upon {{ KF }} logs reaching 97% storage capacity, the host automatically switches to read-only mode. The {{ mkf-name }} cluster denies any requests for writing messages to a topic.


You can monitor storage utilization on cluster hosts [by setting up alerts in {{ monitoring-full-name }}](../operations/storage-space.md#set-alert):


### Recovering a cluster from read-only mode {#read-only-solutions}

Use one of these methods:

* [Increase the storage capacity](../operations/storage-space.md#change-disk-size) so that it exceeds the threshold value. The {{ mkf-name }} cluster will then automatically disable the read-only mode.
* [Set up](../operations/storage-space.md#disk-size-autoscale) automatic storage size increase.

### Automatic increase of storage size {#auto-rescale}

Automatic storage size increase prevents situations where the disk runs out of free space and the host switches to read-only. The storage size increases upon reaching the specified trigger threshold: a percentage of the total capacity. There are two thresholds:

* Scheduled increase threshold: When reached, the storage size increases during the next [maintenance window](maintenance.md#maintenance-window).
* Immediate increase threshold: When reached, the storage size increases immediately.

You can use either one or both thresholds. If you set both, make sure the immediate increase threshold is higher than the scheduled one.

{% include [storage-resize-steps](../../_includes/mdb/mkf/storage-resize-steps.md) %}

You can configure automatic increase of the storage size when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/storage-space.md#disk-size-autoscale). If you set the scheduled increase threshold, you also need to configure the maintenance window schedule.

{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

---
title: Storage in {{ mch-full-name }}
description: In this article, you will learn about disk types in {{ mch-name }}, hybrid storage features, and discover how to select the right disk type when creating a cluster.
alternate:
  - href: en/managed-clickhouse/concepts/storage.md
    type: text/markdown
    title: Markdown version
---

# Storage in {{ mch-name }}


{{ mch-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, i.e., virtual drives in the {{ yandex-cloud }} infrastructure. Local drives are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}



## Hybrid storage {#hybrid-storage-features}

Hybrid storage in {{ mch-name }} integrates two data storage tiers:

* Cluster storage: Frequently accessed (hot) data resides on fast storage media (cluster network drives).
* Object storage: Rarely used (cold) data resides in the less expensive and slower [{{ objstorage-full-name }}](../../storage/).

[Policies](#storage-policies) define whether to write new data to cluster or object storage. For example, under the default policy, new data is initially written to cluster storage. {{ CH }} handles this data using its standard workflows, including segmentation into partitions and data parts. Then {{ CH }} monitors data access frequency and automatically moves colder files to object storage. Automatic reverse migration from object to cluster storage is not supported, but you can move data manually using the `MOVE PARTITION` and `MOVE PART` commands.

The object storage uses a service bucket with unlimited storage capacity. Its [storage class](../../storage/concepts/storage-class.md) is **standard**, and you cannot change it. The [{{ objstorage-name }} limits](../../storage/concepts/limits.md) apply to the object storage.


Storing cold data and its backups in hybrid storage counts towards the total [cluster usage cost](../pricing.md#rules-storage).


You can enable hybrid storage when [creating](../operations/hybrid-storage.md#cluster-create) or [updating](../operations/hybrid-storage.md#cluster-update) a cluster.

{% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}


### Pros and cons of hybrid storage {#advantages}

Key benefits of using hybrid storage include:

* Fast network drives deliver high-speed processing for active data. This achieves low latency and high speeds for analytical queries.
* Rarely used (cold) data resides in the less expensive and slower object storage, reducing storage costs.
* Automated data management. You can set conditions, such as disk capacity thresholds or [TTL](#ttl), to trigger automatic data migration between storage tiers, or move data manually.
* Simplified scaling. When you add a new replica to a cluster with hybrid storage, only the hot data on network drives is copied. Object storage data is not duplicated. This reduces resource consumption and allows for faster scaling.
* Access to data via a single interface. {{ CH }} abstracts its storage infrastructure from data consumers, so users can run both rare queries against cold data and frequent queries to hot data via a single interface.

Hybrid storage constraints:

* Slower access to object storage.
* Hybrid storage is only available for [MergeTree tables]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree). For other table engines, data is only placed in the cluster storage.
* Once hybrid storage is enabled in a cluster, you cannot revert to standard storage.


### Available storage policies {#storage-policies}

You can distribute data between cluster and object storage using storage policies set at the database table level.

{% note info %}

You cannot create new storage policies or update the existing ones.

{% endnote %}

In a {{ mch-name }} cluster with hybrid storage enabled, the following storage policies are available:

* `default`: Cluster automatically manages data placement depending on the following:

    * [Hybrid storage settings](#hybrid-storage-settings).
    * Table [TTL](#ttl) settings.

* `local`: For a table with this policy, rows can only be placed in the cluster storage. No data is moved between storage tiers.

* `object_storage`: For a table with this policy, rows can only be placed in the object storage. No data is moved between storage tiers.

Storage policies do not affect merge operations for data parts.

For more information about storage policies and their settings, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes).


### Merge operations {#comparison-operations}

Inserting data into MergeTree tables creates immutable data parts sorted by primary key. Over time, the number of these parts can grow, creating query processing overhead. To address this, {{ CH }} runs regular background merges of small data parts into larger ones.

[Merge operations]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) are controlled by the following [hybrid storage settings](#hybrid-storage-settings):

* [prefer_not_to_merge](#hybrid-storage-settings): Enables or disables merging data parts within object storage.
* `max_data_part_size_bytes`: Sets the maximum merged data part size in object storage. You can only configure this setting by submitting a request to support.

You can also adjust merge behavior using [settings](./settings-list.md) available in the cluster. Use the `merge` keyword to search for those settings. Examples include:

* **Max bytes to merge at max space in pool**
* **Merge max block size**
* **Merge tree max bytes to use cache**


### Hybrid storage settings {#hybrid-storage-settings}


A {{ mch-name }} cluster with enabled hybrid storage has the following settings:

{% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

You can specify hybrid storage settings when [creating](../operations/hybrid-storage.md#cluster-create) or [updating](../operations/hybrid-storage.md#change-hybrid-storage) a cluster.

For more on hybrid storage settings, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes).


### TTL {#ttl}

TTL (time-to-live) is a tool you can use to restrict the lifetime of your data. Once the specified time interval expires, you can automatically delete, move, or aggregate table rows and columns. You can configure moving rows with the expired TTL to the object storage and set the TTL value when [creating a table](../tutorials/hybrid-storage.md#create-table) or later on.

If there is enough free space in the cluster storage, only the rows with the expired TTL are moved to the object storage. Thus you can move the data to the object storage in parts before your cluster storage is filled up.

While specifying TTL for hybrid storage is optional, doing so gives you explicit control over what data is moved to object storage. Without a defined TTL, data is only moved to the object storage when you run out of space in your cluster storage.

Data is moved between cluster and object storage in [parts]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes) rather than row by row. For optimal performance, align your TTL expression with your [partitioning key]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) to ensure that all rows within a part share the same expiration time. This prevents situations where a data part contains a mix of rows destined for different storage tiers, which can block expired data from moving to the object storage. In the simplest setup, your TTL expression should use the same columns as the partitioning key.

For more information on configuring TTL, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-ttl).



## Selecting the disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ CH }} cluster depends on the selected disk type:

* With local SSD storage (`local-ssd`), you can create a cluster with two or more hosts.

    Storage on local SSDs increases your cluster costs: you pay for the cluster even if it is stopped. For more information, see the [pricing policy](../pricing.md).

* With non-replicated network SSD storage (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts.

* You can add any number of hosts within the current quota when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)
    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).


## Disk encryption {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}



## Managing disk space {#manage-storage-space}

In {{ mch-name }}, if your storage runs out of space, `INSERT` queries, background merges, and mutations are suspended. They will resume automatically after [you expand the storage](../operations/update.md#change-disk-size).


To monitor your storage utilization, [set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration).



### Automatic storage expansion {#autoscaling}

To prevent situations where the disk runs out of free space and insert queries, background merges, and mutations get suspended, [set up automatic storage size increase](../operations/update.md#change-additional-settings) for {{ CH }} and a coordination service, {{ CK }} or {{ ZK }}. This will trigger storage increase when you reach a preset threshold, i.e., a percentage of the total storage size. There are two thresholds:

* Scheduled expansion threshold: To schedule such an expansion, an algorithm analyzes data from the last few hours and estimates how quickly the storage is filling up. If the calculations show that the specified threshold will be exceeded by the start of the nearest [maintenance window](maintenance.md#maintenance-window), the system schedules a storage expansion. When initiating maintenance, the system will check whether the threshold is indeed exceeded, and if so, expand the storage.

* Immediate expansion threshold: When reached, the storage expands immediately.

You can use either one or both thresholds. If you set both, make sure the immediate expansion threshold is not lower than the scheduled one.

For a scheduled expansion, you need to [set up a maintenance window](../operations/cluster-maintenance.md#set-maintenance-window) schedule.

{% include [storage-resize-steps](../../_includes/mdb/mch/storage-resize-steps.md) %}

The automatic storage size increase settings for {{ CH }} apply to all existing shards. New shards will use the settings of the oldest shard.

You can configure automatic storage expansion when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#change-additional-settings).

{% note warning %}

* You cannot decrease the storage size.
* When scaling your storage, the cluster hosts will be unavailable.

{% endnote %}


## Use cases {#examples}

* [{#T}](../tutorials/hybrid-storage.md)
* [How to set up {{ CH }} hybrid storage: a KazanExpress case study](https://yandex.cloud/ru/blog/posts/2022/11/clickhouse-kazanexpress)
* [{#T}](../tutorials/sharding.md)

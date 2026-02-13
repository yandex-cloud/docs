---
title: Storage in {{ mch-full-name }}
description: In this article, you will learn about disk types in {{ mch-name }}, hybrid storage features, and discover how to select the right disk type when creating a cluster.
---

# Storage in {{ mch-name }}


{{ mch-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, i.e., virtual disks in the {{ yandex-cloud }} infrastructure. Local drives are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

## Hybrid storage features {#hybrid-storage-features}

If you enable the **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** setting when creating or updating a cluster, you will be able to distribute data between the cluster storage and object storage in [{{ objstorage-full-name }}](../../storage/). Thus your data will be placed in either a cluster or object storage, depending on the storage policy you specify. For example, you can choose to store your frequently used (hot) data in the cluster storage and rarely used (cold) data in the less expensive and slower object storage.

{% note warning %}

Hybrid storage is only available for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For other table engines, data is only placed in the cluster storage.

{% endnote %}

The object storage uses a service bucket with unlimited storage capacity. Its [storage class](../../storage/concepts/storage-class.md) is **standard**, and you cannot change it. The [{{ objstorage-name }} limits](../../storage/concepts/limits.md) apply to the object storage.

To start using hybrid storage:

1. Create a cluster of the appropriate type. You do not need to configure the object storage.

1. Add databases and tables to the cluster. If the default storage policy does not work for certain tables, set the appropriate policies for these tables:

    * To set a policy when creating a table, specify the `storage_policy` setting:

        ```sql
        CREATE TABLE table_with_non_default_policy (
            <table_schema>
        ) ENGINE = MergeTree
        ...
        SETTINGS storage_policy = '<storage_policy_type>';
        ```

    * To create or update the policy for an existing table, run this query:

        ```sql
        ALTER TABLE table_with_non_default_policy
        MODIFY SETTING storage_policy = '<storage_policy_type>';
        ```

See our example in [Using hybrid storage](../tutorials/hybrid-storage.md).

To monitor the amount of space [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table parts occupy in {{ objstorage-full-name }}, use the `ch_s3_disk_parts_size` [metric](../tutorials/hybrid-storage.md#metrics) in {{ monitoring-full-name }}. It is only available for {{ mch-name }} clusters with hybrid storage.

Storing cold data and its backups in hybrid storage counts towards the total [cluster usage cost](../pricing.md#prices-storage).

### Available storage policies {#storage-policies}

{% note info %}

You cannot create new storage policies or update the existing ones.

{% endnote %}

A {{ mch-name }} cluster with enabled hybrid storage supports the following storage policies:

* `default`: Cluster automatically manages data placement depending on the following:

    * [Hybrid storage settings](#hybrid-storage-settings).
    * Table [TTL]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) (time-to-live) settings.

    If there is enough free space in the cluster storage, only the rows with the expired TTL are moved to the object storage. Thus you can move the data to the object storage in parts before your cluster storage is filled up.

    You can configure moving rows with the expired TTL to the object storage and set the TTL value when creating a table or later on.

* `local`: For a table with this policy, rows can only be placed in the cluster storage. No data is moved between the storages.

* `object_storage`: For a table with this policy, rows can only be placed in the object storage. No data is moved between the storages.

Storage policies do not affect [merge operations]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) for data parts. With any storage policy, you can:

* Enable and disable the `prefer_not_to_merge` setting that merges stored data parts. This setting is available in the [CLI and API](../operations/update.md#change-hybrid-storage).
* Set any `max_data_part_size_bytes` value for the maximum size of the data part you can get upon merging smaller ones.

However, you can change the behavior of these operations using the [settings](./settings-list.md) available in the cluster.

To view current policy settings, run this query:

```sql
SELECT *
FROM system.storage_policies;
```

For more information about storage policies and their settings, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).

### Hybrid storage settings {#hybrid-storage-settings}


A {{ mch-name }} cluster with enabled hybrid storage has the following settings:

* `data_cache_enabled`: Enables caching data accessed from the object storage in the cluster storage. The default value is `true` (enabled).

    In this case, cold data accessed from the object storage is moved to high-speed drives for faster processing.

* `data_cache_max_size`: Sets the maximum cache size, in bytes, allocated in the cluster storage for data accessed from the object storage. If no value is set, the maximum cache size defaults to half the size of the cluster storage.
* `move_factor`: Sets the minimum percentage of free space in the cluster storage. If your free space percentage is below this value, the data will be moved to {{ objstorage-full-name }}. The minimum value is `0`, the maximum value is `1`, and the default value is `0.01`.

    Data parts are queued up in descending order by size. The number of data parts that will be moved is determined by the `move_factor` condition.

* `prefer_not_to_merge`: Disables [merging of data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) in cluster and object storages. Merges are enabled by default.

    Once inserted into the table, the data is saved as a data part and sorted by its primary key. Then, {{ CH }} runs a background merge of data parts belonging to the same partition into a larger data part within 10 to 15 minutes after the insertion. You can use the [system.parts]({{ ch.docs }}/operations/system-tables/parts#system_tables-parts) system table to view the merged data parts and partitions.

You can specify hybrid storage settings when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-hybrid-storage) a cluster.

For more information about setting up hybrid storage, see [this {{ CH }} guide](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).

## Selecting the disk type when creating a cluster {#storage-type-selection}

The number of hosts you can create together with a {{ CH }} cluster depends on the selected disk type:

* With local SSD storage (`local-ssd`), you can create a cluster with two or more hosts.

    This cluster will be fault-tolerant.

    Storage on local SSDs increases your cluster costs: you pay for the cluster even if it is stopped. For more information, see the [pricing policy](../pricing.md).

* With non-replicated network SSD storage (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts.

    This cluster will be fault-tolerant.

* You can add any number of hosts within the current quota when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)
    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



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

For a scheduled expansion, you need to set up a [maintenance window](maintenance.md#maintenance-window) schedule.

{% include [storage-resize-steps](../../_includes/mdb/mch/storage-resize-steps.md) %}

The automatic storage size increase settings for {{ CH }} apply to all existing shards. New shards will use the settings of the oldest shard.

You can configure automatic storage expansion when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#change-additional-settings).

{% note warning %}

* You cannot decrease the storage size.
* When scaling your storage, the cluster hosts will be unavailable.

{% endnote %}

## Use cases {#examples}

* [{#T}](../tutorials/hybrid-storage.md)
* [{#T}](../tutorials/sharding.md)
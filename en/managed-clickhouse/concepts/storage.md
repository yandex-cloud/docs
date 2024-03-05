# Disk types in {{ mch-name }}


{{ mch-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

## Hybrid storage {#hybrid-storage-features}

If you enable the **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** setting when creating or updating a cluster, you will be able to distribute data between cluster storage and [{{ objstorage-full-name }}](../../storage/) object storage. Thus your data will reside in either cluster or object storage, depending on the storage policy you specify. For example, you can choose to store your frequently used (_hot_) data in cluster storage and the rarely used (_cold_) data in the less expensive and slower object storage.

{% note warning %}

Hybrid storage is only available for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For tables powered by other engines, only cluster storage can be used.

{% endnote %}

Object storage uses a service bucket with unlimited storage capacity. It has the Standard [storage class](../../storage/concepts/storage-class.md), which cannot be changed. [{{ objstorage-name }} service limits](../../storage/concepts/limits.md) apply to object storage.

To start using hybrid storage:

1. Create a cluster of the appropriate type with {{ CH }} version {{ mch-ck-version }} or higher. You do not need to configure object storage.

1. Add databases and tables to the cluster. If the default storage policy is not suitable for some tables, set the appropriate policies for these tables:

   * To set the the policy when creating a table, configure the `storage_policy` setting:

      ```sql
      CREATE TABLE table_with_non_default_policy (
          <table_schema>
      ) ENGINE = MergeTree
      ...
      SETTINGS storage_policy = '<storage_policy_type>';
      ```

   * To create or update the policy for an existing table, run the following query:

      ```sql
      ALTER TABLE table_with_non_default_policy
      MODIFY SETTING storage_policy = '<storage_policy_type>';
      ```

See an example in the [Using hybrid storage](../tutorials/hybrid-storage.md) tutorial.

To track the amount of space used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table chunks in {{ objstorage-full-name }}, use the `ch_s3_disk_parts_size` [metric](../tutorials/hybrid-storage.md#metrics) in {{ monitoring-full-name }}. It is only available for {{ mch-name }} clusters with hybrid storage set up.

### Available storage policies {#storage-policies}

{% note info %}

You cannot create new storage policies or update the existing ones.

{% endnote %}

A {{ mch-name }} cluster with enabled hybrid storage supports the following storage policies:

* `default`: The cluster automatically manages data placement depending on:

   * [Hybrid storage settings](#hybrid-storage-settings).
   * Table [TTL]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) (time-to-live) settings.

   If there is enough free space in the cluster storage, only the rows with the expired TTL are moved to object storage. This operation allows you to move part of the data to object storage before the cluster storage becomes full.

   You can configure moving the expired rows to object storage and set the TTL value when creating a table or later.

* `local`: In tables with this policy, rows are placed only in cluster storage. There is no data transfer between storages.

* `object storage`: In tables with this policy, rows are placed only in object storage. There is no data transfer between storages.

Storage policies do not affect [merge operations]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) for data parts. With any storage policy, you can:

* Enable and disable the `prefer_not_to_merge` setting that merges stored data parts. This setting is available in the [CLI and API](../operations/update.md#change-hybrid-storage).
* Set any `max_data_part_size_bytes` value for the maximum size of the data part you will get on merging smaller ones.

However, you can configure the behavior of these operations using the [ClickHouse settings](./settings-list.md) available in the cluster.

You can view up-to-date policy settings with the following query:

```sql
SELECT *
FROM system.storage_policies;
```

For more information about storage policies and their settings, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).

### Hybrid storage settings {#hybrid-storage-settings}

A {{ mch-name }} cluster with enabled hybrid storage has the following settings:

* `data_cache_enabled`: Allows you to cache data requested from object storage in cluster storage. This setting is enabled by default (set to `true`).

   In this case, <q>cold</q> data requested from object storage is written to fast drives where data processing takes less time.

* `data_cache_max_size`: Sets the maximum cache size (in bytes) allocated in cluster storage for data requested from object storage. The default value is `1073741824` (1 GB).
* `move_factor`: Sets the minimum share of free space in cluster storage. If the actual value is less than this setting value, the data is moved to {{ objstorage-full-name }}. The minimum value is `0`, the maximum one is `1`, and the default one is `0.01`.

   Data parts are queued up in descending order according to size, and then as many of them are moved as will satisfy the `move_factor` condition.

* `prefer_not_to_merge`: Disables [merging of data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) in cluster and object storage. The merge functionality is enabled by default.

   Once inserted into the table, the data is saved as a data part and sorted based on the primary key. Next the data parts belonging to the same partition are merged in the background into a larger data part within 10 to 15 minutes after the insertion. You can use the [system.parts]({{ ch.docs }}/operations/system-tables/parts#system_tables-parts) system table to view the merged data parts and partitions.

You can specify hybrid storage settings when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-hybrid-storage) a cluster.

For more information about setting up hybrid storage, see the [{{ CH }} documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ CH }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) storage, you can create a cluster with two or more hosts.

   This cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: you are charged for it even if it is not running. You can find more information in the [pricing policy](../pricing.md).

* With non-replicated network SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant.

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



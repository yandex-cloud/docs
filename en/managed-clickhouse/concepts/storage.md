# Disk types in {{ mch-name }}


{{ mch-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

If you enable the **Hybrid storage** setting when creating or updating a cluster, you will be able distribute data between cluster storage and [{{ objstorage-full-name }}](../../storage/) object storage. For example, you can store frequently used (_hot_) data in cluster storage and rarely used (_cold_) data in less expensive and slower object storage. For details, see [{#T}](#hybrid-storage-features).

## Hybrid storage {#hybrid-storage-features}

Hybrid storage provides fault tolerance for data storage and allows you to manage data placement for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables, the data is placed either in cluster or object storage depending on the storage policy set for the tables.

{% note warning %}

Data in tables other than MergeTree tables is stored only in cluster storage.

{% endnote %}

To start using hybrid storage:

1. Create a cluster of the appropriate type with {{ CH }} version {{ mch-ck-version }} or higher. You do not need to configure object storage.

1. Add databases and tables to the cluster. If the default storage policy is not suitable for some tables, set the appropriate policies for these tables:

   * To set the the policy when creating a table, configure the `storage_policy` setting:

      ```sql
      CREATE TABLE table_with_non_default_policy (
          <table_schema>
      ) ENGINE = MergeTree
      ...
      SETTINGS storage_policy = '<storage policy type>';
      ```

   * To create or update the policy for an existing table, run the following query:

      ```sql
      ALTER TABLE table_with_non_default_policy
      MODIFY SETTING storage_policy = '<storage policy type>';
      ```

See an example in the [Using hybrid storage](../tutorials/hybrid-storage.md) tutorial.

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

Storage policies do not affect [merge operations]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) for data chunks:

* Merging data chunks in storage (the `prefer_not_to_merge` policy setting) is permitted.
* This does not restrict the maximum size of the resulting data chunk (the `max_data_part_size_bytes` value setting), which you may get after merging smaller chunks.

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

   Data chunks to move are enqueued from the largest to the smallest value. Next, the amount of data chunks that is equal to the value at which the `move_factor` condition is met, is moved.

You can specify hybrid storage settings when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-hybrid-storage) a cluster.

For more information about setting up hybrid storage, see the [{{ CH }} documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ CH }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) storage, you can create a cluster with two or more hosts.

   This cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: it is charged even if not running. You can find more information in the [pricing policy](../pricing.md).

* With non-replicated network SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant.

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



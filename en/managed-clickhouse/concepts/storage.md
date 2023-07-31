# Disk types in {{ mch-name }}


{{ mch-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure.  Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

If you enable the **Hybrid storage** setting when creating or updating a cluster, you'll be able distribute data between cluster storage and [{{ objstorage-full-name }}](../../storage/) object storage. For example, you can store frequently used "hot" data in cluster storage and rarely used "cold" data in less expensive and slower object storage. For details, see [{#T}](#hybrid-storage-features).


## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using this disk type, a 2-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}


## Hybrid storage {#hybrid-storage-features}

Hybrid storage provides fault tolerance for data storage and lets you manage data placement for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables: the data is placed either in cluster or object storage depending on the storage policy set for the tables.

{% note warning %}

Data in tables other than MergeTree tables is stored only in cluster storage.

{% endnote %}

To start using hybrid storage:

1. Create a cluster of the appropriate type with {{ CH }} version {{ mch-ck-version }} or higher. You don't need to configure object storage.

1. Add databases and tables to the cluster. If the default storage policy is not suitable for some tables, set the appropriate policies for these tables:

   * To set the the policy when creating a table, configure the `storage_policy` setting:

      ```sql
      CREATE TABLE table_with_non_default_policy (
          <table_schema>
      ) ENGINE = MergeTree
      ...
      SETTINGS storage_policy = '<storage policy type>';
      ```

   * To create or update the policy for an existing table, run the request:

      ```sql
      ALTER TABLE table_with_non_default_policy
      MODIFY SETTING storage_policy = '<storage policy type>';
      ```

See an example in the [Using hybrid storage](../tutorials/hybrid-storage.md) tutorial.

### Available storage policies {#storage-policies}

{% note info %}

You can't create new storage policies or update existing ones.

{% endnote %}

A {{ mch-name }} cluster with enabled hybrid storage supports the following storage policies:

* `default`: The cluster automatically manages data placement depending on:

   * [Hybrid storage settings](#hybrid-storage-settings).
   * Table [TTL]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) (time-to-live) settings.

   If there's enough free space in cluster storage, only the rows with the expired TTL are moved to object storage. This operation allows some data to be moved to object storage before cluster storage becomes full.

   You can configure the moving of expired rows to object storage and set the TTL value when creating a table or later.

* `local`: In tables with this policy, rows are placed only in cluster storage. Data is not transferred between storages.

* `object storage`: In tables with this policy, rows are placed only in object storage. Data is not transferred between storages.

Storage policies don't affect [merge operations]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) for data chunks:

* Merging data chunks in storage (the `prefer_not_to_merge` policy setting) is permitted.
* Doesn't restrict the maximum size of the resulting data chunk (the `max_data_part_size_bytes` value setting), which you may get after merging smaller chunks.

However, you can configure the behavior of these operations using the [ClickHouse settings](./settings-list.md) available in the cluster.

You can view up-to-date policy settings with the following query:

```sql
SELECT *
FROM system.storage_policies;
```

For more information about storage policies and their settings, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).

### Hybrid storage settings {#hybrid-storage-settings}

A {{ mch-name }} cluster with enabled hybrid storage has the following settings:

* `data_cache_enabled`: Lets you cache data requested from object storage in cluster storage. Defaults to `true` (enabled).

   In this case, <q>cold</q> data requested from object storage is written to fast drives where data processing takes less time.

* `data_cache_max_size`: Sets the maximum cache size (in bytes) allocated in cluster storage for data requested from object storage. The default value is `1073741824` (1 GB).
* `move_factor`: Sets the minimum share of free space in cluster storage. If the actual value is less than this setting value, the data is moved to {{ objstorage-full-name }}. The minimum value is `0` and the maximum value is `1`. Defaults to `0.01`.

   Data chunks to move are enqueued from the largest to the smallest value. Next, the amount of data chunks is moved that is equal to the value at which the `move_factor` condition is met.

You can specify hybrid storage settings when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-hybrid-storage) a cluster.

For more information about setting up hybrid storage, see the [{{ CH }} documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes).


## Choice of disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ CH }} cluster depends on the selected disk type:

* If you use local SSD storage (`local-ssd`), you can create a cluster with two or more hosts (a minimum of two hosts is required for fault tolerance).
* With network HDD `network-hdd` or network SSD `network-ssd` storage, you can add any number of hosts within the [current quota](./limits.md).
* If you use non-replicated network SSD storage (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts (a minimum of three hosts is required to ensure fault tolerance).

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



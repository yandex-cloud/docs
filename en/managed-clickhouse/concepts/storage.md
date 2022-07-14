# Storage types

{% if audience != "internal" %}

{{ mch-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

If you enable the **Hybrid storage** setting when creating or updating a cluster, you'll be able distribute data between cluster storage and [{{ objstorage-full-name }}](../../storage/) object storage. For example, you can store frequently used "hot" data in cluster storage and rarely used "cold" data in less expensive and slower object storage. For details, see [{#T}](#hybrid-storage-features).

## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Hybrid storage {#hybrid-storage-features}

Hybrid storage provides fault tolerance for data storage and lets you manage data placement for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables: the data is placed either in cluster or object storage depending on the storage policy set for the tables.

{% note warning %}

Data in tables other than MergeTree tables is stored only in cluster storage.

{% endnote %}

To start using hybrid storage:

1. Create a cluster of the appropriate type. You don't need to configure object storage.

1. Add databases and tables to the cluster. If the default storage policy isn't suitable for some tables, set the appropriate policies for these tables:

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

For an example, see [{#T}](../tutorials/hybrid-storage.md).

### Available storage policies {#storage-policies}

{% note info %}

You can't create new storage policies or update existing ones.

{% endnote %}

A {{ mch-name }} cluster with enabled hybrid storage supports the following storage policies:

* `default`: A cluster automatically manages placement of data depending on the amount of free disk space in cluster storage and table [TTL]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) (time to live) settings.

   If there's less than {{ mch-hs-move-factor }} of free space (fixed `move_factor` setting for the storage policy), some data from the tables with this policy will be moved to object storage.

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

## Choice of storage type during cluster creation {#storage-type-selection}

The number of hosts that can be created with a {{ CH }} cluster depends on the storage type selected:

* When using local SSD storage (`local-ssd`), you can create a cluster with two or more hosts (a minimum of two hosts is required for fault tolerance).
* With `network-hdd` or `network-ssd` storage, you can add any number of hosts within the [current quota](./limits.md).
* If you use non-replicated network SSD storage (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts (to ensure fault tolerance, a minimum of three hosts is necessary).

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).

{% else %}

{{ mch-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disk storage (`local-hdd`): Uses slower but larger disks. Available only for hosts powered by Broadwell or Cascade Lake and with at least eight vCPUs. `local-hdd` storage has a fixed volume: 10240 GB for Broadwell and 12800 GB for Cascade Lake.

You can create a cluster of three or more hosts (a minimum of three hosts is required for fault tolerance).

{% endif %}

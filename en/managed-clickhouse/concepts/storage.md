# Storage types


{{ mch-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/storage-type-nrd.md) %}
- Hybrid storage: Frequently used <q>hot</q> data is stored on standard (`network-hdd`) or fast (`network-ssd`) network storage devices. Rarely used <q>cold</q> data is stored in slower and less expensive [{{ objstorage-full-name }}](../../storage/).

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

- Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fail-safe configuration is automatically set up.
- You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Non-replicated network storage features {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Hybrid storage {#hybrid-storage-features}

Hybrid storage provides fault tolerant data storage and lets you manage data placement for [MergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/) tables: the data is automatically moved from local or network storage to {{ objstorage-name }} when it becomes outdated.

Data can be transferred to {{ objstorage-name }} only for tables on the MergeTree engine. Data from other tables is stored as usual: in local or network storage.

When inserting into a MergeTree table, one of two behaviors is possible:
- Data is placed on local or network storage in the cluster for fast inserts. Then, when the [TTL](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) value (lifetime) expires, such rows are moved in the background to {{ objstorage-name }}.

  You can configure moving expired rows to {{ objstorage-name }} and set TTL when creating a table or later.

- Data is placed directly in object storage if local or network storage is full. In this case, the inserting may take longer.

To start using hybrid storage, [create](../operations/cluster-create.md#create-cluster) a cluster of the appropriate type with {{ CH }} version {{ mch-hs-version }} or higher. You don't need to configure object storage. For an example, see [{#T}](../tutorials/hybrid-storage.md).

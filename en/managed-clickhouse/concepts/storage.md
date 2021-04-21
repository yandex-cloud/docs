# Storage types

{% if audience != "internal" %}

{{ mch-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type.md](../../_includes/mdb/storage-type.md) %}

- Hybrid storage is a win-win solution. Frequently used "hot" data is stored on network storage disks, while rarely used "cold" data is stored in [{{ objstorage-full-name }} object storage](../../storage).

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fail-safe configuration is automatically set up.
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Hybrid storage {#hybrid-storage-features}

{% include [mch-hybrid-storage-preview-combined-note](../../_includes/mdb/mch-hybrid-storage-preview-combined-note.md) %}

Hybrid storage provides fault tolerance for data storage and allows you to manage data placement for [MergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/) tables: the data is automatically moved from local or network storage to {{ objstorage-name }} when it becomes outdated.

To start using hybrid storage, you only need to [create](../operations/cluster-create.md#create-cluster) a cluster of the appropriate type with {{ CH }} version {{ mch-hs-version }} or higher. You don't need to configure object storage. For an example, see [{#T}](../tutorials/hybrid-storage.md).

Cold data can be transferred to {{ objstorage-name }} only for tables on the MergeTree engine. Data from other tables is stored as usual — on local or network storage.

When inserting into a MergeTree table, one of two behaviors is possible:

- Data is placed on local or network storage in the cluster for fast inserts. Then, when the [TTL](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) value (lifetime) expires, such rows are moved in the background to {{ objstorage-name }}.

  You can configure moving expired rows to {{ objstorage-name }} and set TTL when creating a table or later. For an example of TTL use, see [{#T}](../tutorials/hybrid-storage.md).

- Data is placed directly in object storage if local or network storage is full. In this case, the inserting may take longer.

{% else %}

{{ mch-name }} lets you use local storage for database clusters. Local storage is organized on disks that are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Fast local storage (`local-ssd`): The fastest disks. This storage can be from 10 to 2048 GB in size.
* Slow local storage (`local-hdd`): A slower but large storage type. Available only for hosts powered by Broadwell or Cascade Lake and with at least eight vCPUs. The `local-hdd` storage has a fixed volume: 10240 GB for Broadwell and 12800 GB for Cascade Lake.

{% endif %}


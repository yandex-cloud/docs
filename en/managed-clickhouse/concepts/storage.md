# Storage types

{% if audience != "internal" %}

{{ mch-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mch/storage-type.md) %}

* Hybrid storage: Frequently used <q>hot</q> data is stored in HDD network or SSD network storage. Rarely used <q>cold</q> data is stored in slower and less expensive [{{ objstorage-full-name }}](../../storage/).

## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Hybrid storage {#hybrid-storage-features}

Hybrid storage provides fault tolerant data storage and lets you manage data placement for [MergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/) tables: the data is automatically moved from local or network storage to {{ objstorage-name }} when it becomes outdated.

Data can be transferred to {{ objstorage-name }} only for tables on the MergeTree engine. Data from other tables is stored as usual: in local or network storage.

When inserting into a MergeTree table, one of two behaviors is possible:
* Data is placed on local or network storage in the cluster for fast inserts. Then, when the [TTL](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl) value (lifetime) expires, such rows are moved in the background to {{ objstorage-name }}.

  You can configure moving expired rows to {{ objstorage-name }} and set TTL when creating a table or later.

* Data is placed directly in object storage if local or network storage is full. In this case, the inserting may take longer.

To start using hybrid storage, [create](../operations/cluster-create.md#create-cluster) a cluster of the appropriate type with {{ CH }} version {{ mch-hs-version }} or higher. You don't need to configure object storage. For an example, see [{#T}](../tutorials/hybrid-storage.md).

{% else %}

{{ mch-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Local SSD storage (`local-ssd`): The fastest disks. This storage can be from 10 to 2048 GB in size.
* Standard local disk storage (`local-hdd`): Uses slower but larger disks. Available only for hosts powered by Broadwell or Cascade Lake and with at least eight vCPUs. The `local-hdd` storage has a fixed volume: 10240 GB for Broadwell and 12800 GB for Cascade Lake.

{% endif %}

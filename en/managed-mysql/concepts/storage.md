# Disk types in {{ mmy-name }}


{{ mmy-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mmy/storage-type.md) %}


## Specifics of local SSD storage {#Local-storage-features}

Local SSD storage does not provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage does not provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. This is why, when creating a new {{ mmy-name }} cluster using this disk type, a three-host fail-safe configuration is automatically set up.
* You are charged for a cluster with this storage type even if it is stopped. You can find more information in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ MY }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts (a minimum of three hosts is required for fault tolerance).
* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the [current quota](./limits.md).

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).



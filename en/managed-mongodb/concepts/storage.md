# Storage types

{{ mmg-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mmg/storage-type.md) %}

## Specifics of local SSD storage {#Local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mmg-name }} cluster using local storage, a 3-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Choice of storage type during cluster creation {#storage-type-selection}

The number of hosts that can be created with a {{ MG }} cluster depends on the storage type selected:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts (to ensure fault tolerance, a minimum of three hosts is necessary).

* With `network-hdd` or `network-ssd` storage, you can add any number of hosts within the [current quota](./limits.md).

For more information about limits on the number of hosts per cluster or [shard](./sharding.md), see [{#T}](./limits.md).


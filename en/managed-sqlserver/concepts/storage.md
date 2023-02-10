# Disk types

{% if audience != "internal" %}

{{ mms-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/mms/storage-type.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for stored data and affects the overall pricing for the cluster:

* This storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. So, when creating a new {{ mms-name }} cluster using this type of storage, a 3-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Choice of disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created together with a {{ MS }} cluster depends on the disk type selected:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts (to ensure fault tolerance, a minimum of three hosts is necessary).
* With network HDD `network-hdd` or network SSD `network-ssd` storage, you can add any number of hosts within the [current quota](./limits.md).

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).

{% else %}

{{ mms-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can select the following disk types for data storage:

* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disks (`local-hdd`): A slower but large storage option. Available only for hosts powered by Cascade Lake processors with at least eight vCPUs. `local-hdd` for Cascade Lake has a constant size of 12800 GB.

{% endif %}

# Storage types

{% if audience != "internal" %}

{{ mch-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the Yandex.Cloud infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type.md](../../_includes/mdb/storage-type.md) %}

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fail-safe configuration is automatically set up.
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

{% else %}

{{ mch-name }} lets you use local storage for database clusters. Local storage is organized on disks that are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Fast local storage (`local-ssd`): The fastest disks. This storage can be from 10 to 2048 GB in size.
* Slow local storage (`local-hdd`): A slower but large storage type. Available only for hosts powered by Broadwell or Cascade Lake and with at least eight vCPUs. The `local-hdd` storage has a fixed volume: 10240 GB for Broadwell and 12800 GB for Cascade Lake.

{% endif %}


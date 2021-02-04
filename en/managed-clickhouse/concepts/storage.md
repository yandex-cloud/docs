# Storage types


{{ mch-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the Yandex.Cloud infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type.md](../../_includes/mdb/storage-type.md) %}

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mch-name }} cluster using local storage, a 2-host fail-safe configuration is automatically set up.
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).


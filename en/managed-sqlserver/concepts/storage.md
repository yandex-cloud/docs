---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Storage types

{{ mms-name }} lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/storage-type-nrd.md) %}

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for data storage and affects the overall pricing for the cluster:

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. Therefore, when creating a new {{ mms-name }} cluster using local storage, a 3-host fault-tolerant configuration is automatically set up.
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Non-replicated network storage features {#network-nrd-storage-features}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

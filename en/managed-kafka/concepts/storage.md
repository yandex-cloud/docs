---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Storage types


{{ mkf-name }} lets you use network and local storage for clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks that are physically located on [broker servers](brokers.md).

{% include [mkf-storage-type](../../_includes/mdb/storage-type.md) %}

## Local storage features {#local-storage-features}

Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. To ensure fault tolerance, create clusters of two or more hosts.

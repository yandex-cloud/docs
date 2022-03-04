# Storage types

In {{ mgp-name }}, network and local storage is used for DB clusters. Network storage uses network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage uses physical disks in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/storage-type-nrd.md) %}

In a {{ mgp-name }} cluster, the type of storage for master hosts and segment hosts may differ.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Local storage features {#local-storage-features}

* A single master host with local storage is not fault-tolerant: if a local disk fails, data is permanently lost. Therefore, when using local storage for master hosts, you can only select a configuration with two master hosts.

* For the downtime of a {{ mgp-name }} cluster, billing of computing resources (vCPU and RAM):
    * Continues for hosts using local storage.
    * Discontinues for hosts without local storage.

## Non-replicated network storage features {#network-nrd-storage-features}

A single master host with non-replicated network storage is not fault-tolerant: if a disk fails, data is permanently lost. Therefore, when using non-replicated network storage for master hosts, you can only select a configuration with two master hosts.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

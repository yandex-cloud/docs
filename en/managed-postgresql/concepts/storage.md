# Storage types

Managed Service for PostgreSQL lets you use network and local storage for database clusters. Network storage is based on network blocks, which are virtual disks in the Yandex.Cloud infrastructure. Local storage is organized on disks that are physically located in the database host servers.

{% include [storage-type.md](../../_includes/mdb/storage-type.md) %}

{% note info %}

Local storage does not provide fault tolerance: if a local disk fails, data is permanently lost. Therefore, when creating a new Managed Service for PostgreSQL cluster using local storage, a 3-host fail-safe configuration is automatically set up.

{% endnote %}


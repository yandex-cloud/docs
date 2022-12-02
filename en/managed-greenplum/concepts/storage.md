# Disk types in {{ mgp-name }}


{{ mgp-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type](../../_includes/mdb/mgp/storage-type.md) %}

In a {{ mgp-name }} cluster, the type of disks for master hosts and segment hosts may differ.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSDs do not provide fault-tolerant storage and impact the cost of the entire cluster: a cluster with this type of storage is charged even if it is not running. Read more in the [pricing policy](../pricing).


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

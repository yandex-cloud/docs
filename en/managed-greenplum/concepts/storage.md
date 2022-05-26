# Storage types

{% if audience != "internal" %}

{{ mgp-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

In a {{ mgp-name }} cluster, the type of storage for master hosts and segment hosts may differ.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSDs do not provide fault-tolerant storage and impact the cost of the entire cluster: a cluster with this type of storage is charged even if it is not running. Read more in the [pricing policy](../pricing).

{% else %}

{{ mgp-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:

* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disk storage (`local-hdd`): Uses slower but larger disks. Available only for hosts powered by Ice Lake or Cascade Lake processors with at least eight vCPUs.

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}


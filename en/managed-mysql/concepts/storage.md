# Disk types in {{ mmy-name }}



{{ mmy-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type](../../_includes/mdb/mmy/storage-type.md) %}


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts you can create together with a {{ MY }} cluster depends on the selected disk type:

* With local SSDs (`local-ssd`) or non-replicated SSDs (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: you are charged for it even if it is not running. For more information, refer to the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the [current quota](./limits.md).

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



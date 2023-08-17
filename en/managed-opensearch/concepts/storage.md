# Disk types in {{ mos-name }}



{{ mos-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.



{% include [storage-type](../../_includes/mdb/mos/storage-type.md) %}



## Selecting storage type when creating a cluster {#storage-type-selection}

The number of hosts with the `DATA` role that can be created along with an {{ OS }} cluster depends on the selected type of storage:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant. To ensure fault tolerance, you can also set up index [sharding and replication](scalability-and-resilience.md).

   Local SSD storage impacts the cost of a cluster: it is charged even if not running. You can find more information in the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).



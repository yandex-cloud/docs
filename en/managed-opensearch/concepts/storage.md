---
title: Disk types in {{ mos-full-name }}
description: In this article, you will learn about disk types in {{ mos-name }} and discover how to select the right type of storage when creating a cluster.
---

# Disk types in {{ mos-name }}




{{ mos-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.



{% include [storage-type](../../_includes/mdb/mos/storage-type.md) %}



## Selecting storage type when creating a cluster {#storage-type-selection}

The number of hosts with the `DATA` role you can create together with an {{ OS }} cluster depends on the selected storage type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts. This cluster will be fault-tolerant.

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* With HDD (`network-hdd`) or SSD (`network-ssd`) network storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).

To improve fault tolerance, you can set up [index replication](scalability-and-resilience.md#replication) (for multi-host cluster configurations only).



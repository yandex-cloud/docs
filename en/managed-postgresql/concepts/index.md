---
title: Resource relationships in {{ mpg-full-name }}
description: 'The main entity used in {{ mpg-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes master if the current master host is down.'
---

# Resource relationships in {{ mpg-name }}

The main entity used in the {{ mpg-name }} service is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. You can learn more about {{ yandex-cloud }} availability zones [here](../../overview/concepts/geo-scope.md).

* A cluster with multiple hosts features automatic failover: one of the replica hosts becomes master if the current master host is down.

   A replica that has an explicitly specified replication thread source cannot take the master role. To learn more, see [Replication](replication.md).

* The cost of a single-host cluster is lower, but it does not guarantee fault tolerance.

* The minimum number of hosts in a cluster depends on the selected [disk type](storage.md).

A cluster's computing capacity depends on its _host class_, which is the virtual machine template used to deploy the cluster's hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

To manage connections and balance the cluster load, the service architecture features the _Odyssey connection pooler_. For more information, see [Managing connections](pooling.md).


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

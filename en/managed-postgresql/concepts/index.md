---
title: "Relationship between resources in {{ mpg-full-name }}"
description: "The main entity used in {{ mpg-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes the master if the current master host is down."
---

# Relationship between resources in {{ mpg-name }}

The main entity used in {{ mpg-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

* A cluster with multiple hosts features automatic failover: one of the replica hosts becomes the master if the current master host is down.

   A replica that explicitly specifies the source of the replication thread can't take the master role. For more information, see [{#T}](replication.md).

* A single-host cluster is cheaper, but it doesn't guarantee fault tolerance.

* The minimum number of hosts in a cluster depends on the selected [disk type](storage.md).

A cluster's computing capacity depends on its _host class_, which is the virtual machine template used to deploy the cluster's hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

An _Odyssey pooler_ is built into the service architecture to manage connections and to balance a cluster's load. For more information, see [{#T}](pooling.md).

A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

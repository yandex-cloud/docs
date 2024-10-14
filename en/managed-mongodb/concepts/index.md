---
title: Resource relationships in {{ mmg-full-name }}
description: The main entity used in {{ mmg-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A multi-host cluster is natively fault tolerant because one of its replica hosts will take on the master role should the current master host fail.
---

# Resource relationships in {{ mmg-name }}

The main entity used in {{ mmg-name }} is a _database cluster_.

Each cluster consists of one or more _DB hosts_, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

* A multi-host cluster is natively fault tolerant because its hosts can step in for one another in the [primary replica](replication.md) capacity.

* A single-host cluster is less costly but it does not guarantee fault tolerance.

When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.



A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}


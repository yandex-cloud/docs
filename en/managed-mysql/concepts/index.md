---
title: "Resource relationships in {{ mmy-full-name }}"
description: "The main entity used in {{ mmy-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes master if the current master host is down."
---

# Resource relationships in {{ mmy-name }}

The main entity used in the {{ mmy-name }} service is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones [here](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts supports automatic failover, as each host can take the cluster's primary replica role.

* The cost of a single-host cluster is lower, but it does not guarantee fault tolerance.


VMs for cluster hosts can be hosted on:

* _Regular {{ yandex-cloud }} hosts_.

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

* _Dedicated {{ yandex-cloud }} hosts_.


   These are physical servers that only host your VMs. VMs on dedicated hosts have all features of regular VMs; additionally, they are physically isolated from other users' VMs.

   Dedicated hosts are selected from _dedicated host groups_ specified when creating a cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

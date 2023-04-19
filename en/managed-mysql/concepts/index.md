---
title: "Relationships between {{ mmy-full-name }} resources"
description: "The main entity used in {{ mmy-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes the master if the current master host is down."
---

# Relationships between resources in {{ mmy-name }}

The main entity used in {{ mmy-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. Learn more about the geo scope of {{ yandex-cloud }} in the [Cloud overview](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* The cost of a single-host cluster is lower, but it does not guarantee fault tolerance.


VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} _standard hosts_.

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

* On {{ yandex-cloud }} _dedicated hosts_.

   These are physical servers that only host your VMs. VMs on dedicated hosts have all the features of regular VMs plus they're physically isolated from other users' VMs.

   Dedicated hosts are selected from _dedicated host groups_ specified when creating a cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mmy-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about network functionality, see our [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

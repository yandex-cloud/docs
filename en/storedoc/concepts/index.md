---
title: Resource relationships in {{ mmg-full-name }}
description: The main entity {{ mmg-name }} operates is a database cluster. Each cluster consists of one or multiple database hosts, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. A multi-host cluster is natively fault tolerant because one of its replica hosts will take on the master role should the current master host fail.
---

# Resource relationships in {{ mmg-name }}


The main entity {{ mmg-name }} operates is a _database cluster_.

Each cluster consists of one or multiple _database hosts_, which are virtual machines with deployed DBMS servers. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about the {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

In a cluster with two or more active hosts, one is automatically selected as the [primary replica](./replication.md) (master) to process write requests. If the master host fails, {{ SD }} selects a new master from among the available hosts.

A cluster with two or more hosts located in different availability zones is [tolerant of a single zone failure](./high-availability.md).

When creating a cluster, specify:
* _Host class_: VM template for deploying cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your applications.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.



You can access a cluster created in a folder from any VM in the same cloud network. For more information about networking, see [this {{ vpc-name }} guide](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}


{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

---
title: "Relationship of resources of the Yandex Managed Service for ClickHouse"
description: "The main entity operated by the Managed Service for ClickHouse is a database cluster. Each cluster consists of one or more database hosts - virtual machines with deployed DBMS servers. Cluster hosts can be located in different availability zones. A cluster of several hosts automatically fault tolerant - one of the replica hosts will take over the role of master if the current master host fails."
---

# Relationship between resources in {{ mch-name }}

The main entity used in {{ mch-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

    When creating such a cluster, choose one of the available mechanisms to ensure replication:

    * {{ CK}}.

        The cluster will consist only of {{ CH }} hosts.

    * {{ ZK }}.

        The cluster will consist of {{ CH }} hosts and individual {{ ZK }} hosts.

* A single-host cluster doesn't guarantee fault tolerance.

    Later you can [add {{ ZK }} hosts](../operations/zk-hosts.md) to this cluster to enable fault tolerance and replication. This will allow you to add multiple {{ CH }} hosts to the cluster.

{{ CK }} or {{ ZK }} hosts manage replication and distribution of queries across cluster hosts. For more information, see [{#T}](./replication.md).

When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

You should also specify the host class when creating a [shard](sharding.md).


A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}


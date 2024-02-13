---
title: "Resource relationships in {{ mch-full-name }}"
description: "The main entity used in {{ mch-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes master if the current master host is down."
---

# Resource relationships in {{ mch-name }}

The main entity used in the {{ mch-name }} service is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones [here](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts supports automatic failover, as each host can take the cluster's primary replica role.

   When creating such a cluster, choose one of the available options to ensure replication:

   * {{ CK}}:

      The cluster will consist only of {{ CH }} hosts.

   * {{ ZK }}:

      The cluster will consist of {{ CH }} hosts and individual {{ ZK }} hosts.

* A single-host cluster is not fault tolerant.

   You can [add {{ ZK }} hosts](../operations/zk-hosts.md) to this cluster later to enable fault tolerance and replication. This will allow you to add multiple {{ CH }} hosts to the cluster.

{{ CK }} or {{ ZK }} hosts manage replication and query distribution across cluster hosts. To learn more, see [Replication](./replication.md).

When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

You should also specify the host class when creating a [shard](sharding.md).


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

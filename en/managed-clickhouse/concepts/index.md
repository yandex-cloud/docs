---
title: Resource relationships in {{ mch-full-name }}
description: The main entity used in {{ mch-name }} is a database cluster. Each cluster consists of one or more DB hosts, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. A multi-host cluster is natively fault tolerant because one of its replica hosts will take on the master role should the current master host fail.
---

# Resource relationships in {{ mch-name }}

The main entity used in {{ mch-name }} is a _database cluster_.

Each cluster consists of one or more _DB hosts_, which are virtual machines with {{ CH }} DBMS servers deployed. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

A cluster with multiple {{ CH }} hosts is natively fault-tolerant because {{ CH }} hosts can step in for one another as the cluster’s primary [replica](replication.md). To manage replication and query distribution across {{ CH }} hosts, you can use either {{ ZK }} hosts or {{ CK }} Depending on the selected tool, the cluster will consist of:

* Only {{ CH }} hosts with {{ CK }} support

* {{ CH }} hosts and individual {{ ZK }} hosts

A cluster with a single {{ CH }} host is not fault-tolerant.

To implement fault-tolerance in an existing cluster with a single {{ CH }} host:

1. [Add at least three {{ ZK }} hosts to the cluster](../operations/zk-hosts.md#add-zk) to manage replication.
1. [Add {{ CH }} hosts to your cluster](../operations/hosts.md#add-host) to distribute replicas among them.

This will make your cluster fault-tolerant.

When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

You should also specify the host class when creating a [shard](sharding.md).


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

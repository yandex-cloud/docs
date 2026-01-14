---
title: Resource relationships in {{ mch-full-name }}
description: The main entity {{ mch-name }} operates is a database cluster. Each cluster consists of one or multiple database hosts, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. A multi-host cluster is natively highly available because one of its replica hosts will assume the master role if the current master host fail.
---

# Resource relationships in {{ mch-name }}

The main entity {{ mch-name }} operates is a database _cluster_.

Each cluster consists of one or multiple _database hosts_, which are virtual machines with {{ CH }} DBMS servers deployed. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about the {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

A cluster of several {{ CH }} hosts is natively [highly available](high-availability.md) because {{ CH }} hosts can step in for one another as the cluster’s primary [replica](replication.md). To manage replication and query distribution across {{ CH }} hosts, you can use a coordination service, {{ CK }} or {{ ZK }}. Depending on the selected tool, the cluster will consist of:

* Only {{ CH }} hosts with {{ CK }} support

* {{ CH }} hosts and individual {{ CK }} hosts

* {{ CH }} hosts and individual {{ ZK }} hosts


The minimum number of {{ CH }} hosts per cluster depends on the following:
    
  * [Storage type](storage.md):

    * At least three hosts for non-replicated SSDs (`network-ssd-nonreplicated`).

    * At least two hosts for local SSDs (`local-ssd`).

    * At least one host for the following disk types:

      * Network HDDs (`network-hdd`).
      * Network SSDs (`network-ssd`).      * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`).

  * Cluster sharding. When sharding is enabled, you need to multiply the minimum number of hosts for the selected disk type by the number of shards.

    For more information on the features and limitations of sharding in {{ CH }}, see [this article](sharding.md).


A single {{ CH }} host cluster does not provide [high availability](high-availability.md).

To make an existing cluster with a single {{ CH }} host highly available:

1. Add at least three [{{ CK }}](../operations/ck-hosts.md#add-ck) or [{{ ZK }}](../operations/zk-hosts.md#add-zk) hosts to the cluster to manage replication.
1. [Add {{ CH }} hosts to your cluster](../operations/hosts.md#add-host) to distribute replicas among them.

This will make your cluster highly available.

When creating a cluster, specify:
* _Host class_: VM template for deploying cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your applications.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.

You should also specify the host class when creating a [shard](sharding.md).


You can access a cluster created in a folder from any VM in the same cloud network. For more information about networking, see [this {{ vpc-name }} guide](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

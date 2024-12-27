---
title: Resource relationships in {{ mrd-full-name }}
description: '{{ RD }} is a high-performance in-memory DBMS for storing key-value data. {{ mrd-name }} allows you to easily create {{ RD }} host clusters with a high level of fault tolerance. The main entity used in {{ mrd-name }} is a database cluster.'
---

# Resource relationships in {{ mrd-name }}


{{ RD }} is a high-performance DBMS for storing key-value data that runs in RAM. {{ mrd-name }} allows you to easily create {{ RD }} host clusters with a high level of fault tolerance.

The main entity used in {{ mrd-name }} is a _database cluster_.

Each cluster consists of one or more _DB hosts_, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

* A cluster with three or more hosts is natively fault-tolerant because its hosts can step in for one another as the cluster’s primary replica.

* A cluster of one or two hosts is cheaper, but it does not guarantee fault tolerance.

When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

{% note info %}

The amount of memory allocated to a host also depends on the `maxmemory` configuration parameter for {{ RD }} hosts: the maximum amount of data equals 75% of available memory. For example, for a host class with 8 GB RAM, the `maxmemory` value will be 6 GB.

{% endnote %}


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

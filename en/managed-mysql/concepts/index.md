---
title: Resource relationships in {{ mmy-full-name }}
description: The main entity used in {{ mmy-name }} is a database cluster. Each cluster consists of one or more DB hosts, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. A multi-host cluster is natively highly available because one of its replica hosts will assume the master role upon the current master host's failure.
---

# Resource relationships in {{ mmy-name }}

The main entity used in {{ mmy-name }} is a _cluster_.

Each cluster consists of one or more _DB hosts_, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones and even different availability regions. You can learn more about {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

A cluster with two or more hosts is natively [highly available](high-availability.md) because hosts can step in for one another as the cluster’s primary replica. To learn more about how the number of hosts affects cluster availability, see [this section](high-availability.md#host-configuration).

The minimum number of hosts in a cluster depends on the selected [disk type](storage.md). The default cluster configuration offered in the management console includes two hosts.

{% note warning %}

We do not recommend creating a cluster having a single host. While being cheaper, such a cluster will not ensure high availability.

{% endnote %}


VMs for cluster hosts can be hosted on:

* _Regular {{ yandex-cloud }} hosts_.

    These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

* _Dedicated {{ yandex-cloud }} hosts_.


    These are physical servers reserved exclusively for your VMs. VMs on dedicated hosts have all features of regular VMs; additionally, they are physically isolated from other users' VMs.

    Dedicated hosts are selected from _dedicated host groups_ specified when creating a cluster.

    For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


When creating a cluster, specify:
* _Host class_: VM template for deploying the cluster hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
    * `PRODUCTION`: For stable versions of your applications.
    * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}
---
title: Resource relationships in {{ mkf-full-name }}
description: '{{ KF }} is a distributed publish-subscribe messaging system for streaming data between applications. {{ mkf-full-name }} helps you deploy and maintain {{ KF }} 2.8, 3.0, 3.1, and 3.2 server clusters in the {{ yandex-cloud }} infrastructure. Each {{ mkf-name }} cluster consists of one or more broker hosts, where topics and topic partitions are located.'
---

# Resource relationships in {{ mkf-name }}

{{ mkf-full-name }} helps you deploy and maintain clusters of {{ KF }} server versions 2.8, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, and 3.6 in the {{ yandex-cloud }} infrastructure.

{{ KF }} is a distributed cross-application communication system that uses the _publication-subscription_ principle.

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and topic partitions are located. Cluster hosts may reside in different availability zones. You can learn more about {{ yandex-cloud }} availability zones [here](../../overview/concepts/geo-scope.md).

If all broker hosts are created in the same availability zone, you cannot change their number.


Cluster hosts accept [connections](../operations/connect/clients.md) from clients, such as data [producer](producers-consumers.md) and [consumer](producers-consumers.md) applications. Producers send messages to certain cluster topics and consumers read messages from them. Thus you will not need to reconfigure consumers if the producer changes.

## Host configuration depending on {{ KF }} version {#version}

Different {{ KF }} versions use different tools to store cluster metadata, state, and configuration:

* Versions 3.5 or lower use [{{ ZK }}](#zookeeper).
* Versions 3.6 or higher use [{{ kraft-name }}](#kraft).

The number and type of hosts are different between the two cases.

### Host configuration in clusters with {{ ZK }} {#zookeeper}

{{ ZK }} is automatically configured and placed in a cluster based on the number of broker hosts:

* If the {{ KF }} cluster consists of one broker host, {{ ZK }} is hosted on the same host.
* If the {{ KF }} cluster consists of two or more hosts, {{ ZK }} is hosted separately from brokers on three additional hosts. These hosts are added to the cluster automatically.

You cannot delete {{ ZK }} hosts. The number of {{ ZK }} hosts is fixed.

[Learn how to create a {{ mkf-name }} cluster](../operations/cluster-create.md#create-cluster) with {{ ZK }}.

{% note info %}

{{ ZK }} hosts get the following specs by default:

* [Host class](instance-types.md): `b2.medium`
* Disk size: 10 GB
* [Disk type](storage.md): Fast network disks

{% endnote %}

### Host configuration in clusters with {{ kraft-name }} {#kraft}

The [{{ kraft-name }} protocol](kraft.md) (abbreviated as {{ kraft-short-name }}) is used to store metadata instead of {{ ZK }}; therefore, {{ ZK }} hosts are not used in {{ KF }} 3.6 or higher.

{% include [kraft-cluster-topology](../../_includes/mdb/mkf/kraft-cluster-topology.md) %}

## Hosting cluster hosts {#hosting}

VMs for cluster hosts can be hosted on:
* *Regular {{ yandex-cloud }} hosts*:

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.


* *Dedicated {{ yandex-cloud }} hosts*:


   These are physical servers that only host your VMs. Such VMs ensure the operation of both the cluster and your other services that support dedicated hosts. The hosts are selected from *dedicated host groups* specified when creating a cluster.

   A cluster with multiple broker hosts needs at least three groups of dedicated hosts for its operation. This is required for the deployment of {{ ZK }} hosts.

   This placement option ensures physical isolation of the VMs. A {{ mkf-name }} cluster using dedicated hosts includes all features of a regular cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


For more information, see the [{{ KF }} documentation](https://kafka.apache.org/intro).

## Cluster fault tolerance {#fault-tolerance}

To make sure the cluster data is stored in a reliable way and continuously available:

* Your cluster must have at least three broker hosts.
* Each of the three availability zones must host at least one broker host.
* Cluster topics must have the following parameters:

   * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: `3`
   * **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}**: `2`

For more info on the cluster fault tolerance, see the [Service Level Agreement (SLA)]({{ link-sla-kafka }}).

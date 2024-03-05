---
title: "Resource relationships in {{ mkf-full-name }}"
description: "{{ KF }} is a distributed publish-subscribe messaging system for streaming data between applications. {{ mkf-full-name }} helps you deploy and maintain {{ KF }} 2.8, 3.0, 3.1, and 3.2 server clusters in the {{ yandex-cloud }} infrastructure. Each {{ mkf-name }} cluster consists of one or more broker hosts, where topics and topic partitions are located."
---

# Resource relationships in {{ mkf-name }}

{{ mkf-full-name }} helps you deploy and maintain clusters of {{ versions.console.str }} {{ KF }} servers in the {{ yandex-cloud }} infrastructure.

{{ KF }} is a distributed cross-application communication system that uses the _publication-subscription_ principle.

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and topic partitions are located. Cluster hosts may reside in different availability zones. You can learn more about {{ yandex-cloud }} availability zones [here](../../overview/concepts/geo-scope.md).

If all broker hosts are created in the same availability zone, you cannot change their number.


Cluster hosts accept [connections](../operations/connect.md) from clients, such as data [producer](producers-consumers.md) and [consumer](producers-consumers.md) applications. Producers send messages to certain cluster topics and consumers read messages from them. This makes sure you will not need to re-configure consumers if the producer changes.

Depending on the number of broker hosts in the cluster, {{ ZK }} is automatically configured and hosted:

* If the {{ KF }} cluster consists of one broker host, {{ ZK }} is hosted on the same host.
* If the {{ KF }} cluster consists of two or more hosts, {{ ZK }} is hosted separately from brokers on three additional hosts. These hosts are added to the cluster automatically.

You cannot delete {{ ZK }} hosts. The number of {{ ZK }} hosts is permanent. {{ mkf-name }} uses {{ ZK }} to store cluster statuses and configurations.


You can change the {{ ZK }} host settings using the [CLI](../operations/cluster-update.md).

{% note info %}

{{ ZK }} hosts get the following specs by default:

* [Host class](instance-types.md): `b2.medium`
* Disk size: 10 GB
* [Disk type](storage.md): Fast network disks

{% endnote %}

VMs for cluster hosts can be hosted on:
* *Regular {{ yandex-cloud }} hosts*:

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.


* *Dedicated {{ yandex-cloud }} hosts*:

   These are physical servers that only host your VMs. Such VMs ensure the operation of both the cluster and your other services that support dedicated hosts. The hosts are selected from *dedicated host groups* specified when creating a cluster.

   A cluster with multiple broker hosts needs at least three groups of dedicated hosts for its operation. This is required for deploying {{ ZK }} hosts.

   Such a placement option makes sure the VMs are physically isolated. A {{ mkf-name }} cluster using dedicated hosts includes all features of a regular cluster.

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

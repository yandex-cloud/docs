---
title: "Relationship between {{ mkf-full-name }} resources"
description: "{{ KF }} is a distributed messaging system between applications on a publish-subscribe basis. The {{ mkf-full-name }} service helps you deploy and maintain {{ KF }} server clusters 2.1, 2.6 and 2.8 in the {{ yandex-cloud }} infrastructure. Each {{ mkf-name }} cluster consists of one or more broker hosts that host topics and their sections."
---
# Relationships between resources in {{ mkf-name }}

# Relationship between resources in {{ mkf-name }}

With {{ mkf-full-name }}, you can deploy and maintain {{ KF }} server cluster versions 2.1, 2.6 and 2.8 in the {{ yandex-cloud }} infrastructure.

{{ KF }} is a distributed publish-subscribe messaging system for streaming data between applications.
{% if audience != "internal" %}

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and their partitions are located. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

{% endif %}

Clients [connect](../operations/connect.md) to the cluster hosts. Clients are data [producers](producers-consumers.md) and [consumers](producers-consumers.md). Producers send messages to certain cluster topics and consumers read messages from them. This ensures that you won't need to re-configure consumers if the producer changes.

Depending on the number of broker hosts in the cluster, {{ ZK }} is automatically configured and hosted:

* If the {{ KF }} cluster consists of one broker host, {{ ZK }} is hosted on the same host.
* If the {{ KF }} cluster consists of two or more hosts, {{ ZK }} is hosted separately from brokers on three additional hosts. These hosts are added to the cluster automatically.

You can't delete {{ ZK }} hosts. The number of {{ZK}} hosts is fixed. {{ mkf-name }} uses {{ ZK }} for storing cluster statuses and configurations.

You can change the {{ ZK }} host parameters using the [CLI](../operations/cluster-update.md).

{% note info %}

The following characteristics are set for the {{ ZK }} hosts by default:

* [Host class](instance-types.md): `b2.medium`.
* 10 GB disk size.
* [Storage type](storage.md): Fast network storage.

{% endnote %}

VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} *standard hosts*.

  These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

* On {{ yandex-cloud }} *dedicated hosts*.

  These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from *dedicated host groups* specified when creating a cluster.

  A cluster with multiple broker hosts requires at least three groups of dedicated hosts for its operation. This is necessary for deploying {{ ZK }} hosts.

  This placement option ensures physical isolation of VMs. A {{ mkf-name }} cluster using dedicated hosts includes all the features of a regular cluster.

  For more information, see [{#T}](../../compute/concepts/dedicated-host.md).

For more information, see the [{{ KF }} documentation](https://kafka.apache.org/intro).


---
title: "Relationship between {{ mkf-full-name }} resources"
description: "{{ KF }} is a distributed messaging system between applications on a publish-subscribe basis. The {{ mkf-full-name }} service helps you deploy and maintain {{ KF }} server clusters 2.1, 2.6 and 2.8 in the {{ yandex-cloud }} infrastructure. Each {{ mkf-name }} cluster consists of one or more broker hosts that host topics and their sections."
---

# Relationships between resources in {{ mkf-name }}

{{ mkf-full-name }} helps you deploy and maintain clusters of {{ KF }} 2.8 and 3.0 servers in the {{ yandex-cloud }} infrastructure.

{{ KF }} is a distributed inter-application communication system that uses the "publication-subscription" principle.
{% if audience != "internal" %}

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and topic partitions are located. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

If all broker hosts are created in the same availability zone, you cannot change their number.

{% endif %}

Cluster hosts accept [connections](../operations/connect.md) from clients, such as data [producer](producers-consumers.md) and [consumer](producers-consumers.md) applications. Producers send messages to certain cluster topics and consumers read messages from them. This ensures that you won't need to re-configure consumers if the producer changes.

Depending on the number of broker hosts in the cluster, {{ ZK }} is automatically configured and hosted:

* If the {{ KF }} cluster consists of one broker host, {{ ZK }} is hosted on the same host.
* If the {{ KF }} cluster consists of two or more hosts, {{ ZK }} is hosted separately from brokers on three additional hosts. These hosts are added to the cluster automatically.

You can't delete {{ ZK }} hosts. The number of {{ ZK }} hosts is constant. {{ mkf-name }} uses {{ ZK }} to store cluster states and configurations.


You can change the {{ ZK }} host parameters using the [CLI](../operations/cluster-update.md).

{% note info %}

The following characteristics are set for the {{ ZK }} hosts by default:

* The `b2.medium` [host class](instance-types.md).
* Disk size: 10 GB.
* [Storage type](storage.md): Fast network storage.

{% endnote %}

VMs corresponding to cluster hosts can be hosted:
* On {{ yandex-cloud }} *standard hosts*.

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

{% if product == "yandex-cloud" and audience != "internal" %}

* On {{ yandex-cloud }} *dedicated hosts*.

   These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from *dedicated host groups* specified when creating a cluster.

   A cluster with multiple broker hosts requires at least three groups of dedicated hosts for its operation. This is necessary for deploying {{ ZK }} hosts.

   This placement option ensures physical isolation of VMs. A {{ mkf-name }} cluster using dedicated hosts includes all the features of a regular cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).

{% endif %}

For more information, see the [{{ KF }} documentation](https://kafka.apache.org/intro).

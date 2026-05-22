---
title: Network and database clusters in {{ mkf-full-name }}
description: In this tutorial, you will learn about the basic network interface settings for a {{ KF }} cluster.
---

# Networking in {{ mkf-name }}


When creating a cluster, you can:

* Set the network for cluster hosts.
* Specify the [availability zones](../../overview/concepts/geo-scope.md) where the cluster hosts will reside.
* Set subnets in all availability zones.
* Turn on public access to the cluster from outside {{ yandex-cloud }}.

If there are {{ ZK }} hosts in the cluster, each of the three {{ ZK }} hosts will use its dedicated availability zone and the subnet selected in it. For more information, see [{#T}](../concepts/index.md).


## Host name and FQDN {#hostname}

{{ mkf-short-name }} generates a name for each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). You cannot change the host name and, consequently, FQDN.

For more information on how to get a host FQDN, see [this guide](../operations/connect/index.md#get-fqdn).


You can use the FQDN to access the host within a single cloud network. For more information, see [this {{ vpc-full-name }} guide](../../vpc/).

## Public access to clusters {#public-access-to-a-cluster}

If you request public access when [creating a cluster](../operations/cluster-create.md), all [broker hosts](brokers.md) in the cluster will be accessible from outside {{ yandex-cloud }}. To connect to such a cluster, use the FQDN of one or more cluster's broker hosts.

You cannot request public access after creating a cluster.

When you delete a cluster with public access enabled, all public IP addresses assigned to this cluster are revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md).

{% note tip %}

When connecting to a cluster from its cloud network, configure security groups both for the cluster and the VM you are connecting from.

{% endnote %}

Features of using security groups:

* Security group settings only determine whether connecting to the cluster is possible. They do not affect cluster operation, such as replication of topic sections by broker hosts, connections between brokers and {{ ZK }} hosts, and other features.

* Even if the cluster and the connecting VM are in the same security group, there will be no connection unless you set up rules within this group that allow traffic between the VM and the cluster.

  However, by default, such rules are contained within the security group added automatically when creating a cloud network. They are the `Self` rules that allow unlimited traffic within a group.


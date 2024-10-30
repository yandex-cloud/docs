---
title: Network and DB clusters in {{ mkf-full-name }}
description: In this tutorial, you will learn about the basic network interface settings of an {{ KF }} cluster.
---

# Networking in {{ mkf-name }}


When creating a cluster, you can:

* Set the network for cluster hosts.
* Specify the [availability zones](../../overview/concepts/geo-scope.md) where the cluster hosts will reside.
* Set subnets in all availability zones.
* Turn on public access to the cluster from outside {{ yandex-cloud }}.

If there are {{ ZK }} hosts in the cluster, each of the three {{ ZK }} hosts will use its dedicated availability zone and the subnet selected in it. For more information, see [Resource relationships in the service](../concepts/index.md).


## Host name and FQDN {#hostname}

{{ mkf-short-name }} generates the name of each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

For more information on how to get a host FQDN, see [this guide](../operations/connect/index.md#get-fqdn).


You can use the FQDN to access the host within a single cloud network. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to clusters {#public-access-to-a-cluster}

If you request public access when [creating a cluster](../operations/cluster-create.md), all [broker hosts](brokers.md) in the cluster will be accessible from outside {{ yandex-cloud }}. To connect to such a cluster, use the FQDN of one or more cluster's broker hosts.

You cannot request public access after creating a cluster.

When you delete a cluster with public access enabled, all public IP addresses assigned to this cluster are revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, make sure to [configure](../operations/connect/index.md#configuring-security-groups) security groups for both the cluster and the connecting VM.

{% endnote %}

Specifics of working with security groups:

* Security group settings only affect whether it will be possible to connect to the cluster. They do not affect cluster operation, such as replication of topic sections by broker hosts, connections between brokers and {{ ZK }} hosts, and other features.

* Even if the cluster and the connecting VM are in the same security group, there will be no connection unless you set up rules within this group that allow traffic between the VM and the cluster.

  However, by default, such rules are contained within the security group added automatically when creating a cloud network. They are the `Self` rules that allow unlimited traffic within a group.


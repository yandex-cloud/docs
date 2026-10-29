---
title: Networking in {{ managed-k8s-full-name }}
description: When creating a {{ k8s }} cluster, you can create a network and subnet for the master, a range of IP addresses for your pods and services, and the node subnet mask.
---

# Networking in {{ managed-k8s-name }}

When [creating a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md), you can configure the following:
* [Network and subnet](../../vpc/concepts/network.md#network) for the [master](./index.md#master).
* Range of IP addresses for [pods](./index.md#pod).
* Range of IP addresses for [services](./index.md#service).
* Node subnet mask.

You can also:
* Request a [public IP address](../../vpc/concepts/ips.md) to access the [cluster](./index.md#kubernetes-cluster) from outside {{ yandex-cloud }}.
* Configure [network policy controllers](network-policy.md) to manage the address space within the cluster.

{% include [note-vpc-resources](../../_includes/managed-kubernetes/note-vpc-resources.md) %}

## Network resources {#network-resources}

{{ k8s }} clusters in the {{ yandex-cloud }} infrastructure use the following resources:
* Subnets.

  When creating a cluster without tunnel mode, {{ managed-k8s-name }} reserves two subnets: for pods and services. For a cluster with [tunnel mode](network-policy.md#cilium), subnets in the address space of the cloud network are not reserved.
* Public IP addresses.

  When you [create a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with public access, the master will get a public IP address.
  
  When you [create a node group](../operations/node-group/node-group-create.md) with public access, each of its nodes will get a public IP address.

## Managing the address space {#address-space}

For {{ k8s }} cluster not using tunnel mode, pod ranges must not overlap with the service ranges, master and node subnets, or other {{ vpc-name }} networks and connected networks.

In case the number of free blocks is not sufficient for new nodes, [add a non-overlapping range](cluster-multi-cidr.md) without stopping or recreating the cluster. Support for multiple ranges is available only in the `RAPID` release channel.

The following subnet ranges are available for the pods, nodes, and services of such clusters:
* `10.0.0.0/8`
* `172.16.0.0/12`
* `192.168.0.0/16`

The node subnet mask and the subnet size for the pods determine the maximum number of nodes in the cluster and the maximum number of pods per node.

In addition, {{ k8s }} has a [standard limit](https://kubernetes.io/docs/setup/best-practices/cluster-large/) of 110 pods per node.

For clusters in [tunnel mode](network-policy.md#cilium), the following subnet ranges are available:
* `10.0.0.0/8`
* `172.16.0.0/12`
* `192.168.0.0/16`

{% note info %}

For such clusters, the range overlap limitation does not apply.

{% endnote %}

For example, when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with the following parameters:
* Tunnel mode is not enabled.
* Range of IP addresses for pods: `10.1.0.0/16`.

  {% include [cluster-multi-cidr-note](../../_includes/managed-kubernetes/cluster-multi-cidr-note.md) %}
  
* Range of IP addresses for services: `10.2.0.0/16`.
* Node subnet mask: `24`.

The pod range contains `2^(24 − 16) = 256` `/24` blocks: from `10.1.0.0/24` to `10.1.255.0/24`. This calculation does not consider the possible reservation of blocks by {{ managed-k8s-name }}. During planning, keep [quotas and limits](limits.md) in mind.

Each node gets one unreserved block. For example, if the `10.1.1.0/24` block is allocated to a node, its pods will get addresses from this block, such as `10.1.1.2` and `10.1.1.3`.

## Node name and FQDN {#hostname}

{{ managed-k8s-name }} generates a name for each node when it is created. This name will be the host's [fully qualified domain name (FQDN)](../../compute/concepts/network.md#hostname). You cannot change the node name or FQDN.

Use the FQDN to access the node within a single cloud network. For more information, see [{#T}](../../vpc/concepts/address.md).

## Public access in a cluster {#public-access-to-a-host}

{% note tip %}

You can enable public access only for the master, only for nodes in a group, or for both the master and nodes.

{% endnote %}

If you enable public access for the master or nodes in a node group, they will be accessible from the internet via their [public IP addresses](../../vpc/concepts/address.md#public-addresses).

You can enable public access:
* For the master, only when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md).
* For nodes in a group, when [creating](../operations/node-group/node-group-create.md) or [updating](../operations/node-group/node-group-update.md#node-internet-access) the group.

If you disable public access for the master or nodes, they will be accessible only via their [private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the cloud network the cluster resides in.

## Internet access for cluster worker nodes {#nodes-internet}

{% include [nodes-internet-access](../../_includes/managed-kubernetes/nodes-internet-access.md) %}

If you [create a cluster with no internet access](../tutorials/k8s-cluster-with-no-internet.md), it will not be possible to connect to external resources from the cluster’s nodes.

However, this does not apply to the following {{ yandex-cloud }} services, which you can access via [private IP addresses](../../vpc/concepts/address.md#internal-addresses):

* {{ objstorage-name }}: To access buckets, [use a {{ vpc-short-name }} service connection](../../storage/operations/buckets/access-via-vpc.md) or [create the required infrastructure manually](../../storage/tutorials/storage-vpc-access.md).
* {{ container-registry-name }}: To access registries, [create the required infrastructure manually](../../container-registry/tutorials/vpc-cr-access.md).

### Impact of security groups {#nodes-internet-traffic-rules}

[Security groups](../../vpc/concepts/security-groups.md) assigned to node groups [contain a basic rule that allows connections to external resources](../operations/connect/security-groups.md#rules-internal-nodegroup).

If you use more granular rules that significantly restrict network traffic, they may block internet access for the nodes. Access may be blocked entirely or in part, i.e., only to certain external resources.

If you encounter any problems with nodes’ internet access, [edit your security group rules](../../vpc/operations/security-group-add-rule.md) to allow the traffic you need.

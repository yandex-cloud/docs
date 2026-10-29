---
title: '{{ managed-k8s-name }} clusters with multiple ranges of pod IP addresses'
description: How support for multiple ranges of pod IP addresses allows for expanding the pod address space in a {{ managed-k8s-name }} cluster without recreating it.
---

# Clusters with multiple ranges of pod IP addresses

*Support for multiple ranges of pod IP addresses* (Cluster Multi-CIDR) allows you to assign multiple ranges of non-overlapping IP address to a [cluster](index.md#kubernetes-cluster) and add new ones without stopping or recreating the cluster. This feature allows you to create large clusters and scale existing ones, as well as to flexibly manage the address space within the overall network architecture.

{% note info %}

Support for multiple ranges of pod IP addresses is available only for clusters in the `RAPID` [release channel](release-channels-and-updates.md). You can use no more than [eight ranges](limits.md#managed-k8s-limits) in a single cluster.

{% endnote %}

## Allocating IP addresses to pods {#address-allocation}

Ranges form a common pool of cluster IP addresses. You can set ranges when [creating the cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [add them later](../operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) without stopping or recreating the cluster.

Each range is divided into blocks for nodes. Each node gets one block of IP addresses for pods. Therefore, the number of nodes a range can accommodate is determined by the number of such blocks.

The block size is determined by the node subnet mask in the [cluster's network settings](network.md#address-space). When a node is added, the service allocates a free block to it, from which pods get their IP addresses on that node.

For example, a node gets the `10.1.128.0/24` block from the `10.1.0.0/16` range. This block is written to the `spec.podCIDR` field of the `Node`-type Kubernetes object representing the node. This node's pods get IP addresses from a dedicated block, e.g., `10.1.128.2` and `10.1.128.3`.

If the current range runs out of free address blocks for new nodes, you can add another range to the cluster. New nodes will be getting blocks from available ranges. The IP addresses of existing nodes and pods do not change.

A cluster can have no more than eight ranges of pod IP addresses. You can add ranges but you cannot modify or delete them. Adding ranges does not increase [quotas](limits.md) for nodes and other resources.

## Range requirements {#requirements}

When planning address space, consider the following requirements:

* Your cluster uses the `RAPID` release channel.
* The number of pod IP address ranges is `8` or less.
* Ranges do not overlap with each other.
* Ranges do not overlap with the service range, master and node subnets, networks connected via VPN, {{ interconnect-name }}, and {{ cr-name }}, and peer-to-peer networks.
* The range accommodates at least one block of IP addresses for the node's pods. The block size is determined by the node subnet mask in the [cluster's network settings](network.md#address-space).
* Before adding a range, check the [control mode](../operations/network/manage-ip-masq-agent.md#get-config) for the masquerading settings. It determines whether the new range will be added to the exclusions automatically or you will have to add it manually.

## How to add a new range of pod IP addresses {#add-cidr}

To expand the pod address space:

1. Select a range that meets the requirements and accommodates the necessary number of nodes.

   Each node gets one block of IP addresses for pods. The block size is determined by the node subnet mask in the [cluster's network settings](network.md#address-space).

   To calculate the number of blocks in a range, use the numbers following `/`:

   ```text
   Number of blocks = 2^(node subnet mask – range mask)
   ```

   For example, the `10.1.0.0/16` range with the `/24` subnet mask contains `2^(24 − 16) = 256` blocks, from `10.1.0.0/24` to `10.1.255.0/24`. This calculation does not consider the possible reservation of blocks by {{ managed-k8s-name }}.

   Adding a range increases the number of blocks for new nodes. The size of blocks already allocated to existing nodes does not change. The actual number of nodes is also limited by [quotas and limits](limits.md).

1. [Add a new range to the cluster settings](../operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) while preserving the existing ranges and wait for the operation to complete.

1. If automatic masquerading management is disabled, [manually add the new range to the masquerading exceptions](../operations/network/manage-ip-masq-agent.md#sync-cidr).

1. Check that the range has been added to the [cluster settings](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

   {% include [note-vpc-resources](../../_includes/managed-kubernetes/note-vpc-resources.md) %}

1. [Expand the node group](../operations/node-group/node-group-update.md) and [check the address blocks assigned to the new nodes](../operations/network/manage-ip-masq-agent.md#verify).

#### Useful links {#see-also}

* [{#T}](network.md)
* [{#T}](limits.md)
* [{#T}](../operations/network/manage-ip-masq-agent.md)

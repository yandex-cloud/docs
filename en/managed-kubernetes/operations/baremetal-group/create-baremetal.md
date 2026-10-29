---
title: Creating a node group on {{ baremetal-name }} servers
description: Create a node group on {{ baremetal-name }} servers in the {{ managed-k8s-name }} cluster. Prepare the network and select the server configuration.
---

# Creating a node group on {{ baremetal-name }} servers

{% note info %}

You can create, modify, and delete node groups on {{ baremetal-name }} servers only via the management console.

{% endnote %}

In the {{ managed-k8s-name }} cluster, you can create a [node group](../../concepts/index.md#node-group) on {{ baremetal-name }} dedicated servers. {{ baremetal-extend-managed-k8s-name }} will rent the servers, auto-configure them, and connect them to your cluster. By default, server rent period is one day.

{% include [node-group-create-baremetal](../../../_includes/managed-kubernetes/node-group-create-baremetal.md) %}

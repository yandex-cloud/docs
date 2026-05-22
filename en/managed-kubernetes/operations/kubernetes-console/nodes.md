---
title: Managing pod allocation to nodes in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage pod allocation to {{ k8s }} nodes in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing pod allocation to nodes

Nodes are {{ compute-full-name }} virtual machines hosting pods with user containers. In the management console, you can manage pod allocation to a node in {{ k8s }} without using kubectl.

## Prohibiting pod allocation to a node {#cordon}

You can prohibit new pod allocation to a node in the management console in the same way as when using the `kubectl cordon <node_name>` command. Pods already running on the node will continue to operate.

To prohibit pod allocation to a node:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Nodes](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** in the left-hand panel.
  1. Select the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab.
  1. Click the node name.
  1. In the top-right corner, click ![Cordon](../../../_assets/console-icons/lock.svg) **{{ ui-key.yacloud.k8s.nodes.button_action-cordon }}**.
  1. Confirm the action.

{% endlist %}

## Allowing pod allocation to a node {#cordon}

You can allow pod allocation to a node in the management console in the same way as when using the kubectl uncordon <node_name>` command.

To allow pod allocation to a node 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Nodes](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** in the left-hand panel.
  1. Select the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab.
  1. Click the node name.
  1. In the top-right corner, click ![Uncordon](../../../_assets/console-icons/lock-open.svg) **{{ ui-key.yacloud.k8s.nodes.button_action-uncordon }}**.
  1. Confirm the action.

{% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/index.md)

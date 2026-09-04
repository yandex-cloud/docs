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

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the node row and select ![ellipsis](../../../_assets/console-icons/lock.svg) **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Confirm the action.

{% endlist %}

## Allowing pod allocation to a node {#cordon}

You can allow pod allocation to a node in the management console in the same way as when using the kubectl uncordon <node_name>` command.

To allow pod allocation to a node 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** tab.
  1. Click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the node row and select ![Uncordon](../../../_assets/console-icons/lock-open.svg) **{{ ui-key.yacloud.k8s.nodes.button_action-uncordon }}**.
  1. Confirm the action.

{% endlist %}

#### Useful links {#see-also}

[{#T}](../../concepts/index.md)

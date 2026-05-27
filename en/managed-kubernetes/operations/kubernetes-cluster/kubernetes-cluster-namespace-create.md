---
title: Managing namespaces in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage {{ k8s }} namespaces in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing namespaces

{{ k8s }} namespaces allow you to share cluster resources between multiple teams or projects. With the management console, you can create and delete namespaces in {{ managed-k8s-name }} without using kubectl.

## Creating a namespace

You can create namespaces in the management console in the same way as when using the `kubectl create namespace <namespace_name>` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Namespaces](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}** in the left-hand panel.
  1. In the top-right corner, click **{{ ui-key.yacloud.k8s.namespaces.button_create }}**.
  1. In the window that opens, enter **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** for the namespace.

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Deleting a namespace

Deleting a namespace is equivalent to running the `kubectl delete namespace <namespace_name>` command. Deleting a namespace will also delete all its resources.

To delete a namespace:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Namespaces](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}** in the left-hand panel.
  1. In the namespace row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the action.

{% endlist %}

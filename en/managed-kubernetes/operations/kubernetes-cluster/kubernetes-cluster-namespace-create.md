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

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. Click **{{ ui-key.yacloud.k8s.namespaces.button_filter-create }}**.
  1. In the window that opens, enter **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** for the namespace.

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Deleting a namespace

Deleting a namespace is equivalent to running the `kubectl delete namespace <namespace_name>` command. Deleting a namespace will also delete all its resources.

To delete a namespace:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. In the namespace row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

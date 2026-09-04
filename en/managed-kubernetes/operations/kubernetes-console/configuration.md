---
title: Managing ConfigMap and Secret resources in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage {{ k8s }} ConfigMap and Secret resources in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing ConfigMap and Secret resources

The `ConfigMap` and `Secret` resources in {{ k8s }} enable you to store and send data to configure pods. In the management console, you can manage these resources in {{ managed-k8s-name }} without using kubectl.

## Creating a ConfigMap or Secret resource {#create-configmap-secret}

You can create `ConfigMap` and `Secret` resources in the management console in the same way as when using the `kubectl apply -f <manifest_file.yaml> -n <namespace_name>` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_configuration }}** tab.
  1. Navigate to the tab with the resource type you want to create: **{{ ui-key.yacloud.k8s.configuration.label_config-maps }}** or **{{ ui-key.yacloud.k8s.configuration.label_secrets }}**.
  1. Click the create button for the selected resource type.
  1. In the drop-down list, select the **{{ ui-key.yacloud.k8s.cluster.field_namespace }}** to create the resource in.
  1. Fill out the manifest file according to these {{ k8s }} guides: [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).
  1. Click **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Editing a ConfigMap or Secret resource {#edit-configmap-secret}

In the management console, you can edit `ConfigMap` and `Secret` resource manifests in a visual editor. This approach is equivalent to running the `kubectl apply -f <manifest_file.yaml>` command and allows you to update the resource configuration without re-creating it.

The list of editable fields depends on the object type and is available in [this {{ k8s }} guide](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_configuration }}** tab.
  1. Navigate to the tab with the resource type you want to edit: **{{ ui-key.yacloud.k8s.configuration.label_config-maps }}** or **{{ ui-key.yacloud.k8s.configuration.label_secrets }}**.
  1. In the row of the resource in question, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the manifest file on the right side of the screen. Your changes will be highlighted with color.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

If the manifest is correct, the changes will be applied. If the updated manifest contains an error or edits uneditable fields, an error message will appear. Click **{{ ui-key.yacloud.common.more }}** for details.

## Deleting a ConfigMap or Secret resource {#delete-configmap-secret}

Deleting a `ConfigMap` or `Secret` resource is equivalent to running the `kubectl delete -f <manifest_file.yaml>` command.

To delete a `ConfigMap` or `Secret` resource, do the following:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_configuration }}** tab.
  1. Navigate to the tab with the resource type you want to delete: **{{ ui-key.yacloud.k8s.configuration.label_config-maps }}** or **{{ ui-key.yacloud.k8s.configuration.label_secrets }}**.
  1. In the row with the resource in question, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

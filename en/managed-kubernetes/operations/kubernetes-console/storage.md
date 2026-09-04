---
title: Managing storages in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage {{ k8s }} storages in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing storages

{{ k8s }} storages provide a common file system to pod containers enabling them to store and exchange data. The management console allows you to manage your {{ k8s }} storage without using kubectl.

## Creating a storage resource {#create-storage}

You can create storage resources in the management console in the same way as when using the `kubectl apply -f <manifest_file.yaml> -n <namespace_name>` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_storage }}** tab.
  1. Go to the tab with the resource type you want to create:

      * **{{ ui-key.yacloud.k8s.storage.label_pvc }}**
      * **{{ ui-key.yacloud.k8s.storage.label_pv }}**
      * **{{ ui-key.yacloud.k8s.storage.label_storage-classes }}**
  1. Click the create button for the selected resource type.
  1. In the drop-down list, select the **{{ ui-key.yacloud.k8s.cluster.field_namespace }}** to create the resource in.
  1. Fill out the manifest file according to the Kubernetes guide: [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims), [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/), [storage class](https://kubernetes.io/docs/concepts/storage/storage-classes/).
  1. Click **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Editing a storage resource {#edit-storage}

In the management console, you can edit storage resource manifests in a visual editor. This approach is equivalent to running the `kubectl apply -f <manifest_file.yaml>` command and allows you to update the resource configuration without re-creating it.

The list of editable fields depends on the object type and is available in [this Kubernetes guide](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_storage }}** tab.
  1. Go to the tab with the resource type you want to edit:

      * **{{ ui-key.yacloud.k8s.storage.label_pvc }}**
      * **{{ ui-key.yacloud.k8s.storage.label_pv }}**
      * **{{ ui-key.yacloud.k8s.storage.label_storage-classes }}**
  1. In the row with the resource in question, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the manifest file on the right side of the screen. Your changes will be highlighted with color.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

If the manifest is correct, the changes will be applied. If the updated manifest contains an error or edits uneditable fields, an error message will appear. Click **{{ ui-key.yacloud.common.more }}** for details.

## Setting or removing the default storage class {#default-storage-class}

The default storage class is used when creating a Persistent Volume Claim, if `spec.storageClassName` is not specified in its manifest. You can designate multiple storage classes as default classes at the same time. In which case the last created storage class is used when creating a Persistent Volume Claim.

This approach is equivalent to running the `kubectl patch storageclass <storage_class_name> -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"<true-or-false>"}}}'` command.

To set or remove the default storage class:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_storage }}** tab.
  1. Navigate to the **{{ ui-key.yacloud.k8s.storage.label_storage-classes }}** tab.
  1. In the storage class row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.k8s.storage.button_action-add-default }}** or **{{ ui-key.yacloud.k8s.storage.button_action-remove-default }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

## Deleting a storage resource {#delete-storage}

Deleting a storage resource is equivalent to running the `kubectl delete -f <manifest_file.yaml>` command.

To delete a storage resource:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_storage }}** tab.
  1. Go to the tab with the resource type you want to delete:

      * **{{ ui-key.yacloud.k8s.storage.label_pvc }}**
      * **{{ ui-key.yacloud.k8s.storage.label_pv }}**
      * **{{ ui-key.yacloud.k8s.storage.label_storage-classes }}**
  1. In the row with the resource in question, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the action.

{% endlist %}

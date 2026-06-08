---
title: Managing Service and Ingress resources in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage {{ k8s }} Service and Ingress resources in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing Service and Ingress resources

The `Service` and `Ingress` resources in {{ k8s }} provide communication between pods and access to applications from outside the cluster. In the management console, you can manage these resources in {{ k8s }} without using kubectl.

{% note info %}

To view cluster resources in the {{ ui-key.yacloud.k8s.network.label_ingress }} section, you need the `alb.auditor` [role](../../../application-load-balancer/security/index.md#alb-auditor) or higher.

{% endnote %}

## Creating a Service or Ingress resource {#create-service-ingress}

You can create `Service` and `Ingress` resources in the management console in the same way as when using the `kubectl apply -f <manifest_file.yaml> -n <namespace_name>` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** in the left-hand panel.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.create }}** and select the resource type.
  1. In the drop-down list, select the **{{ ui-key.yacloud.k8s.cluster.field_namespace }}** to create the resource in.
  1. Fill out the manifest file according to the {{ k8s }} guides: [Service](https://kubernetes.io/docs/concepts/services-networking/service/), [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
  1. Click **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Editing a Service or Ingress resource {#edit-service-ingress}

In the management console, you can edit `Service` and `Ingress` resource manifests in a visual editor. This approach is equivalent to running the `kubectl apply -f <manifest_file.yaml>` command and allows you to update the resource configuration without re-creating it.

The list of editable fields depends on the object type and is available in [this {{ k8s }} guide](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** in the left-hand panel.
  1. Select the tab containing the resource type to edit.
  1. In the row of the resource, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the manifest file on the right side of the screen. Your changes will be highlighted with color.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

If the manifest is correct, the changes will be applied. If the updated manifest contains an error or edits uneditable fields, an error message will appear. Click **{{ ui-key.yacloud.common.more }}** for details.

## Deleting a Service or Ingress resource {#delete-service-ingress}

Deleting a `Service` or `Ingress` resource is equivalent to running the `kubectl delete -f <manifest_file.yaml>` command.

To delete a `Service` or `Ingress` resource, do the following:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** in the left-hand panel.
  1. Select the tab containing the resource type you want to delete.
  1. In the row of the resource, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the action.

{% endlist %}

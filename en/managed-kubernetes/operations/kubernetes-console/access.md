---
title: Managing {{ k8s }} service accounts in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to create or delete a {{ k8s }} service account in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing {{ k8s }} service accounts

{{ k8s }} service accounts are accounts for applications and processes running in pods. In the management console, you can create and delete {{ k8s }} service accounts in {{ managed-k8s-name }} without using kubectl.

## Creating a service account {#create-sa}

You can create service accounts in the management console in the same way as when using the `kubectl create serviceaccount <service_account_name> -n <namespace_name>` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Access](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.k8s.cluster.switch_access }}** in the left-hand panel.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.create }}** and select **{{ ui-key.yacloud.k8s.access.button_create-sa }}**.
  1. In the window that opens, enter the service account **{{ ui-key.yacloud.k8s.access.popup-add-sa_field_name }}**.
  1. In the drop-down list, select the **{{ ui-key.yacloud.k8s.access.popup-add-sa_field_namespace }}** to create the service account in.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Deleting a service account {#delete-sa}

Deleting a service account is equivalent to running the `kubectl delete serviceaccount <service_account_name> -n <namespace_name>` command.

To delete a service account:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![Access](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.k8s.cluster.switch_access }}** in the left-hand panel.
  1. In the service account line, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the action.

{% endlist %}

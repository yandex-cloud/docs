---
title: Managing workloads in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to manage {{ k8s }} workloads in {{ yandex-cloud }} using the management console without kubectl.
---

# Managing workloads

A workload is an application that operates in a {{ k8s }} environment. In the management console, you can manage workloads in {{ k8s }} without using kubectl.

## Creating a workload {#create-workload}

You can create workloads in the management console in the same way as when using the `kubectl apply -f <manifest_file.yaml> -n <namespace_name>` command.

To create a workload:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.create }}** and select the workload type.
  1. In the drop-down list, select the **{{ ui-key.yacloud.k8s.cluster.field_namespace }}** to create the workload in.
  1. Fill out the manifest file according to the Kubernetes guides: [pod](https://kubernetes.io/docs/concepts/workloads/pods/), [Deployment controller](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [DaemonSet controller](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/), [StatefulSet controller](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/), [job](https://kubernetes.io/docs/concepts/workloads/controllers/job/), and [cron job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).
  1. Click **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Editing a workload {#edit-workload}

In the management console, you can edit workload manifests in a visual editor. This approach is equivalent to running the `kubectl apply -f <manifest_file.yaml>` command and allows you to update the resource configuration without re-creating it.

The list of editable fields depends on the workload type and is available in [this Kubernetes guide](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/).

To edit a workload:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
  1. Select the tab containing the type of the workload you want to edit.
  1. In the workload row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the manifest file on the right side of the screen. Your changes will be highlighted with color.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

If the manifest is correct, the changes will be applied. If the updated manifest contains an error or edits uneditable fields, an error message will appear.

## Running or stopping a cron job {#cron-job}

You can run and stop cron jobs in the management console in the same way when as using the `kubectl patch cronjob > <cron_job_name> -p '{"spec":{"suspend":<true_or_false>}}'` command.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
  1. Select the **{{ ui-key.yacloud.k8s.workloads.label_cron-jobs }}** tab.
  1. In the cron job row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.start }}** or **{{ ui-key.yacloud.common.stop }}**.
  1. Confirm the action.

{% endlist %}

## Deleting a workload {#delete-workload}

Deleting a workload is equivalent to running the `kubectl delete -f <manifest_file.yaml>` command. When you delete a controller, all the pods it has created will also be deleted.

To delete a workload:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and select ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
  1. Select the tab containing the type of the workload you want to delete.
  1. In the workload row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the action.

{% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/index.md)

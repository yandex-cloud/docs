---
title: How to update a {{ managed-k8s-name }} cluster
description: Follow this guide to update a {{ managed-k8s-name }} cluster.
---

# Updating a {{ managed-k8s-name }} cluster

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Changing {{ managed-k8s-name }} clusters {#update-cluster}

You can change the following parameters of a [{{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) cluster:
* Name.
* Description.
* [Service accounts](../../../iam/operations/sa/create.md).
* [Resource configuration](../../concepts/index.md#master-resources) for the master.
* [{{ k8s }}](../../concepts/release-channels-and-updates.md) version.
* [Updates](../../concepts/release-channels-and-updates.md#updates) policy.
* List of [security groups](../connect/security-groups.md).
* Settings for sending logs to [{{ cloud-logging-full-name }}](../../../logging/).

  {% note alert %}

  Do not delete the security groups bound to a running {{ managed-k8s-name }} cluster as this might result in disruptions in its operation and data loss.

  {% endnote %}

* Mask of the [{{ managed-k8s-name }} node](../../concepts/index.md#node-group) [subnet](../../../vpc/concepts/network.md#subnet).

  {% note warning %}

  If you change the subnet mask of an active {{ managed-k8s-name }} cluster, it may run out of CIDR blocks. In this case, you will not be able to deploy [pods](../../concepts/index.md#pod) on new node groups.

  {% endnote %}

To learn how to change a cluster's [availability zone](../../../overview/concepts/geo-scope.md), see [{#T}](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a {{ managed-k8s-name }} cluster:
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Change the required parameters in the window that opens.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To update a {{ managed-k8s-name }} cluster:
  1. View a description of the update {{ managed-k8s-name }} cluster CLI command:

     ```bash
     {{ yc-k8s }} cluster update --help
     ```

  1. Run the following command and provide a list of settings you want to change (not all settings are listed in the example below):

     ```bash
     {{ yc-k8s }} cluster update <Managed_Service_for_Kubernetes_cluster_name> \
       --new-name <new_name_for_Managed_Service_for_Kubernetes_cluster> \
       --description <Managed_Service_for_Kubernetes_cluster_description> \
       --service-account-id <ID_of_service_account_for_resources> \
       --service-account-name <name_of_service_account_for_resources> \
       --node-service-account-id <ID_of_service_account_for_{{ k8s }}_nodes> \
       --security-group-ids <list_of_security_group_IDs> \
       --master-logging enabled=<send_logs>,`
           `log-group-id=<log_group_ID>,`
           `folder-id=<folder_ID>,`
           `kube-apiserver-enabled=<send_kube-apiserver_logs>,`
           `cluster-autoscaler-enabled=<send_cluster-autoscaler_logs>,`
           `events-enabled=<send_{{ k8s }}_events>`
           `audit-enabled=<send_audit_events>
     ```

     Where:
     * `--new-name`: {{ managed-k8s-name }} cluster name.
     * `--description`: {{ managed-k8s-name }} cluster description.
     * `--service-account-id`, `--service-account-name`: Service account for {{ managed-k8s-name }} cluster management.
     * `--node-service-account-id`, `--node-service-account-name`: Service account for managing the {{ managed-k8s-name }} nodes.
     * `--security-group-ids`: {{ managed-k8s-name }} cluster security groups.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--master-logging`: Sending logs to {{ cloud-logging-name }}:

       {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

     * `--version`: {{ k8s }} version.
     * `--latest-revision`: Get all available updates for the current [{{ managed-k8s-name }} master](../../concepts/index.md#master) version.
     * `--auto-upgrade`: Manage automatic {{ managed-k8s-name }} cluster updates.
     * Managing the maintenance window:
       * `--anytime-maintenance-window`: Update at any time.
       * `--daily-maintenance-window`: Update daily at the selected time.
       * `--weekly-maintenance-window`: Update on selected days.

- {{ TF }} {#tf}

  To update a {{ managed-k8s-name }} cluster:
  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.

     For more information about creating this file, see [{#T}](kubernetes-cluster-create.md).
  1. Edit the required parameters in the {{ managed-k8s-name }} cluster description.

     To edit the settings for sending logs to {{ cloud-logging-name }}, configure the `master_logging` section parameters. If there is no such section, create one.

     {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

     Where:

     {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }}]({{ tf-provider-k8s-cluster }}) provider documentation.

- API {#api}

  To update {{ managed-k8s-name }} cluster parameters, use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/) resource.

  To edit the settings for sending logs to {{ cloud-logging-name }}, configure their `masterSpec.masterLogging` parameter values.

{% endlist %}

## Managing {{ managed-k8s-name }} cluster cloud labels {#manage-label}

You can perform the following actions with [{{ managed-k8s-name }} cluster cloud labels](../../concepts/index.md#cluster-labels):

* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a cloud label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the {{ managed-k8s-name }} cluster.
    1. Click the name of the {{ managed-k8s-name }} cluster.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ui-key.yacloud.component.label-set.button_add-label }}**.
    1. Enter the key and the value, and press **Enter**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Result:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test {{ k8s }} cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Updating a cloud label {#update-label}

{% list tabs group=instructions %}

- Management console {#console}

  To update a cloud label, you will need to delete and re-create it:

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the {{ managed-k8s-name }} cluster.
    1. Click the name of the {{ managed-k8s-name }} cluster.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click the cross next to the label to delete it.
    1. Click **{{ui-key.yacloud.component.label-set.button_add-label }}** and enter a key and/or value for the new label.
    1. Press **Enter** and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
  ```

  {% include [labels-rewrite-warning](../../../_includes/labels-rewrite-warning.md) %}

  Result:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test {{ k8s }} cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Deleting a cloud label {#remove-label}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the {{ managed-k8s-name }} cluster.
    1. Click the name of the {{ managed-k8s-name }} cluster.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click the cross next to the label.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

  Result:

  ```text
  done (1s)
  id: cati493bu7ia********
  folder_id: b1g88tflru0e********
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  ...
  ```

{% endlist %}

## Updating the master resource configuration {#manage-resources}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**, expand the **Compute resources** section and select a [resource configuration](../../concepts/index.md#master-resources) for the master.

      {% include [master-default-config](../../../_includes/managed-kubernetes/master-default-config.md) %}

      {% include [master-config-preview-note](../../../_includes/managed-kubernetes/master-config-preview-note.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
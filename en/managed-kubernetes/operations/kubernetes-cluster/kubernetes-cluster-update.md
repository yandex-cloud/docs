---
title: "How to update a {{ managed-k8s-name }} cluster"
description: "Follow this guide to update a {{ managed-k8s-name }} cluster."
---

# Editing {{ managed-k8s-name }} clusters

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Changing {{ managed-k8s-name }} clusters {#update-cluster}

You can change the following parameters of a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster):
* Name.
* Description.
* [Service accounts](../../../iam/operations/sa/create.md).
* [{{ k8s }} version](../../concepts/release-channels-and-updates.md).
* [Update](../../concepts/release-channels-and-updates.md#updates) policy.
* List of [security groups](../connect/security-groups.md).
* Settings for sending logs to [{{ cloud-logging-full-name }}](../../../logging/).

  [Security groups](../../../vpc/concepts/security-groups.md) are at the [Preview stage](../../../overview/concepts/launch-stages.md). If they are not available on your [network](../../../vpc/concepts/network.md#network), all incoming and outgoing traffic for the resources will be allowed. No additional setup is required.

  To enable security groups, request access to this feature from the [support team]({{ link-console-support }}/create-ticket).

  {% note alert %}

  Do not delete the security groups bound to a running {{ managed-k8s-name }} cluster as this might result in disruptions in its operation and data loss.

  {% endnote %}

* Mask of the [{{ managed-k8s-name }} node](../../concepts/index.md#node-group) [subnet](../../../vpc/concepts/network.md#subnet).

  {% note warning %}

  If you change the subnet mask of an active {{ managed-k8s-name }} cluster, it may run out of CIDR blocks. In this case, you will not be able to deploy [pods](../../concepts/index.md#pod) on new node groups.

  {% endnote %}

{% list tabs %}

- Management console

  To update a {{ managed-k8s-name }} cluster:
  1. Open **{{ managed-k8s-name }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **Edit** in the top-right corner.
  1. Change the required parameters in the window that opens.
  1. Click **Save changes**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update a {{ managed-k8s-name }} cluster:
   1. View a description of the update {{ managed-k8s-name }} cluster CLI command:

      ```bash
      {{ yc-k8s }} cluster update --help
      ```

   1. Run the following command and provide a list of settings you want to change (not all settings are listed in the example below):

      ```bash
      {{ yc-k8s }} cluster update <{{ managed-k8s-name }}_cluster_name> \
        --new-name <new_{{ managed-k8s-name }}_cluster_name> \
        --description <{{ managed-k8s-name }}_cluster_description> \
        --service-account-id <resource_service_account_ID> \
        --service-account-name <resource_service_account_name> \
        --node-service-account-id <{{ managed-k8s-name }}_node_service_account_ID> \
        --security-group-ids <list_of_security_group_IDs> \
        --master-logging enabled=<log_sending:_true_or_false>,`
            `log-group-id=<log_group_ID>,`
            `folder-id=<folder_ID>,`
            `kube-apiserver-enabled=<kube-apiserver_log_sending:_true_or_false>,`
            `cluster-autoscaler-enabled=<cluster-autoscaler_log_sending:_true_or_false>,`
            `events-enabled=<{{ k8s }}_event_sending:_true_or_false>
      ```

      Where:
      * `--new-name`: {{ managed-k8s-name }} cluster name.
      * `--description`: {{ managed-k8s-name }} cluster description.
      * `--service-account-id`, `--service-account-name`: Service account for managing the {{ managed-k8s-name }} cluster.
      * `--node-service-account-id`, `--node-service-account-name`: Service account for managing the {{ managed-k8s-name }} nodes.
      * `--security-group-ids`: {{ managed-k8s-name }} cluster security groups.

         {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

      * `--master-logging`: Sending logs to {{ cloud-logging-name }}:

         {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

     * `--version`: {{ k8s }} version.
     * `--latest-revision`: Get all available updates for current [master {{ managed-k8s-name }}](../../concepts/index.md#master) version.
     * `--auto-upgrade`: Manage automatic {{ managed-k8s-name }} cluster updates.
     * Managing the maintenance window:
       * `--anytime-maintenance-window`: Perform maintenance at any time.
       * `--daily-maintenance-window`: Update daily at the selected time.
       * `--weekly-maintenance-window`: Update on selected days.

- {{ TF }}

  To update a {{ managed-k8s-name }} cluster:
  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.

      For more information about creating this file, see [{#T}](kubernetes-cluster-create.md).
   1. Edit the required parameters in the {{ managed-k8s-name }} cluster description.

      To edit the settings for submitting logs to {{ cloud-logging-name }}, configure the `master_logging` section parameters. If there is no such section, create one.

      {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

      Where:

      {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

   1. Make sure the configuration files are valid.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

- API

   To edit {{ managed-k8s-name }} cluster parameters, use the [update](../../api-ref/Cluster/update.md) method for the [Cluster](../../api-ref/Cluster/) resource.

   To edit the settings for sending logs to {{ cloud-logging-name }}, configure their `masterSpec.masterLogging` parameter values.

{% endlist %}

## Managing {{ managed-k8s-name }} cluster labels {#manage-label}

You can perform the following actions with [{{ managed-k8s-name }} cluster labels](../../concepts/index.md#node-labels):
* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

  Add a {{ managed-k8s-name }} cluster label:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Result:

  ```bash
  done (1s)
  id: abcd123ef4ghi567j8k9
  folder_id: l1m01nopqr1st2uvwxy1
  ...
  description: My test {{ k8s }} cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Editing a label {#update-label}

{% list tabs %}

- CLI

  Edit a {{ managed-k8s-name }} cluster label:

  {% note warning %}

  The existing set of `labels` is completely replaced by the set transmitted.

  {% endnote %}

  ```bash
  yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
  ```

  Result:

  ```bash
  done (1s)
  id: abcd123ef4ghi567j8k9
  folder_id: l1m01nopqr1st2uvwxy1
  ...
  description: My test {{ k8s }} cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  Delete a {{ managed-k8s-name }} cluster label:

  ```bash
  yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

  Result:

  ```bash
  done (1s)
  id: cati493bu7ian006a4a8
  folder_id: b1g88tflru0ek1omtsu0
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  ...
  ```

{% endlist %}
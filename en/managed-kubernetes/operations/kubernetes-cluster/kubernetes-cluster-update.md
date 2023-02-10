# Editing {{ k8s }} clusters

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Changing {{ k8s }} clusters {#update-cluster}

You can change the following parameters of a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster):
* Name.
* Description.
* [Service accounts](../../../iam/operations/sa/create.md).
* {{ k8s }} version.
* [Update](../../concepts/release-channels-and-updates.md#updates) policy.
* List of [security groups](../connect/security-groups.md).

  {% note alert %}

  Do not delete the security groups bound to a running cluster as this might result in disruptions in its operation and data loss.

  {% endnote %}

{% list tabs %}

- Management console

  To change a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).
  1. Open **{{ managed-k8s-name }}** in the folder where you want to change the {{ k8s }} cluster.
  1. Click on the name of the {{ k8s }} cluster.
  1. Click **Edit** in the upper-right corner.
  1. Change the necessary parameters in the window that opens.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To change a cluster:
  1. View a description of the CLI's update cluster command:

     ```bash
     {{ yc-k8s }} cluster update --help
     ```

  1. Execute the command by passing a list of the settings to be changed (only some of the settings are given in the example):

     ```bash
     {{ yc-k8s }} cluster update <cluster name> \
       --new-name <new cluster name> \
       --description <cluster description> \
       --service-account-id <ID of service account for resources> \
       --service-account-name <name of service account for resources> \
       --node-service-account-id <ID of service account for nodes> \
       --security-group-ids <security group ID list>
     ```

     Where:
     * `--new-name`: Cluster name.
     * `--description`: Cluster description.
     * `--service-account-id`, `--service-account-name`: Service account for managing the cluster.
     * `--node-service-account-id`, `--node-service-account-name`: Service account for managing nodes.
     * `--security-group-ids`: Cluster security groups.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--version`: {{ k8s }} version.
     * `--latest-revision`: Get all available updates for current version of master.
     * `--auto-upgrade`: Manage automatic cluster updates.
     * Managing the maintenance window:
       * `--anytime-maintenance-window`: Perform maintenance at any time.
       * `--daily-maintenance-window`: Update daily at the selected time.
       * `--weekly-maintenance-window`: Update on specified days.

- {{ TF }}

  To change a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).
  1. Open the current configuration file with the cluster description.

     For more information about creating this file, see [{#T}](kubernetes-cluster-create.md).
  1. Edit the required parameters in the {{ k8s }} cluster description.
  1. Make sure that the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

- API

  To edit {{ k8s }} cluster parameters, use the [update](../../api-ref/Cluster/update.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}

## Managing cluster labels for {{ k8s }} {#manage-label}

You can perform the following actions with [{{ k8s }} cluster labels](../../concepts/index.md#node-labels):
* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

  Add a label to the {{ k8s }} cluster:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Result:

  ```bash
  done (1s)
  id: abcd123ef4ghi567j8k9
  folder_id: l1m01nopqr1st2uvwxy1
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  description: My test {{ k8s }} cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

  Change the {{ k8s }} cluster label:

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
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  description: My test {{ k8s }} cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  Remove a label from a {{ k8s }} cluster:

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
  description: My test {{ k8s }} cluster
  ...
  ```

{% endlist %}
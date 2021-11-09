# Changing a node group

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

## Changing the name of a node group {#update-name}

You can change the following node group parameters:
* Name.
* Description.
* Number of nodes.
* {{ k8s }} version.
* Computing resources and node disk size.
* Update policy.

{% list tabs %}

- Management console

  To change a [node group](../../concepts/index.md#node-group):
  1. Open **{{ managed-k8s-name }}** in the folder where you want to change the {{ k8s }} cluster.
  1. Click on the name of the {{ k8s }} cluster you.
  1. Go to the **Node group** tab.
  1. Click **Edit** in the upper-right corner.
  1. Change the necessary parameters in the window that opens.
  1. Click **Save changes**.

- CLI

  Get detailed information about the command to edit the node group:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Use the following parameters to edit the node group:
  * `--new-name`: Change the name.
  * `--description`: Edit the description.
  * `--service-account-id`, `--service-account-name`: Edit the resource service account.
  * `--node-service-account-id`, `--node-service-account-name`: Edit the node service account.
  * `--version`: Change the {{ k8s }} version.
  * `--latest-revision`: Get all available updates for the current version of the master.
  * `--auto-upgrade`: Manage automatic upgrades.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Run the maintenance at any time.
    * `--daily-maintenance-window`: Update daily at a specified time.
    * `--weekly-maintenance-window`: Update on specified days.

- API

  To change the parameters of a node group, use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}

## Managing node group labels {#manage-label}

You can perform the following actions with node group labels:
* [Add a label](#add-label)
* [Update a label](#update-label)
* [Delete a label](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a label to a node group:

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Command execution result:

  ```bash
  done (28s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

  Change a node group label:

  {% note warning %}

  The existing set of `labels` is completely replaced by the set transmitted.

  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Command execution result:

  ```bash
  done (3s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  Delete a label from a node group:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Command execution result:

  ```bash
  done (2s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

{% note warning %}

* The `user-data` metadata key is not supported for post-configuring the VM and user data transmission.
* To manage SSH keys, [use the `ssh-keys` key](../../../compute/concepts/vm-metadata).
* For post-configuring nodes, use privileged DaemonSets. For example, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

{% endnote %}
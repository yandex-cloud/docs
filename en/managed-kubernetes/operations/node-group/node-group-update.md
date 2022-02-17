# Changing a node group

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

## Changing node group parameters {#update-settings}

You can change the following parameters of a [node group](../../concepts/index.md#node-group):
* Name.
* Description.
* Number of nodes.
* {{ k8s }} version.
* List of security groups.
* Computing resources and node disk size.
* Update policy.

{% list tabs %}

- Management console

  To change a [node group](../../concepts/index.md#node-group):
  1. Open **{{ managed-k8s-name }}** in the folder where you want to change the {{ k8s }} cluster.
  1. Click on the name of the desired cluster.
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
  * `--network-interface`: Network settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type`: Selection of the type of network acceleration:
    * `standard`: Without acceleration.
    * `software-accelerated`: [Software-accelerated network](../../../vpc/concepts/software-accelerated-network.md).

    {% note warning %}

    Before turning on the software-accelerated network, make sure that you have enough [resources available in the cloud](../../concepts/limits.md) to create an additional node.

    {% endnote %}

  * `--latest-revision`: Get all available updates for the current version of the master.
  * `--auto-upgrade`: Manage automatic updates.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Run the maintenance at any time.
    * `--daily-maintenance-window`: Update daily at a specified time.
    * `--weekly-maintenance-window`: Update on specified days.

- API

  To change the parameters of a node group, use the method [update](../../api-ref/NodeGroup/update.md) for the [NodeGroup](../../api-ref/NodeGroup) resource.

{% endlist %}

## Enabling access to nodes from the internet {#node-internet-access}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ compute-full-name}}**.
  1. Click on the VM name.
  1. Under **Network**, click ![options](../../../_assets/horizontal-ellipsis.svg) and select **Add public IP address**.
  1. Specify the appropriate settings and click **Add**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To enable access to nodes from the internet:

  1. Get detailed information about the command to edit the node group:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Run the command to change a node group by passing the `--network-interface` parameter:

     ```bash
     {{ yc-k8s }} node-group update <node group ID or name> \
     ...
       --network-interface subnets=<name of node group subnet>, ipv4-address=nat
     ```

     You can find out the names and IDs of node groups in the [list of node groups in the folder](node-group-list.md#list).

- API

  Use the method [update](../../api-ref/NodeGroup/update.md) for the [NodeGroup](../../api-ref/NodeGroup) resource.

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

  Command output:

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

  Command output:

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

  Command output:

  ```bash
  done (2s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

{% note warning %}

* The `user-data` metadata key is not supported for post-configuring the VM and user data transmission.
* To manage SSH keys, [use the key](../../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) `ssh-keys`.
* For post-configuring nodes, use privileged DaemonSets. For example, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

{% endnote %}
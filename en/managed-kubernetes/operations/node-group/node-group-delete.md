# Deleting a node group

To delete a [node group](../../concepts/index.md#node-group), use its name or ID.

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

{% list tabs %}

- Management console

  To delete a [node group](../../concepts/index.md#node-group):
  1. Go to the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) you want to delete a node group from:
     1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** section in the folder.
     1. Open the {{ k8s }} cluster.
     1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. On the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row containing the node group to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.k8s.cluster.node-groups.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the node group:

     ```bash
     yc k8s node-group delete <node_group_name>
     ```

     Result:

     ```bash
     done
     ```

  1. Make sure that the node group was deleted:

     ```bash
     yc managed-kubernetes node-group list
     ```

     Result:

     ```bash
     +----+------------+------+-------------------+------------+--------+------+
     | ID | CLUSTER ID | NAME | INSTANCE GROUP ID | CREATED AT | STATUS | SIZE |
     +----+------------+------+-------------------+------------+--------+------+
     +----+------------+------+-------------------+------------+--------+------+
     ```

- {{ TF }}

  To delete a [node group](../../concepts/index.md#node-group):
  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Delete the section describing a group you no longer need.
  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  To delete a node group, use the [delete](../../api-ref/NodeGroup/delete.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}
# Deleting a node group

To delete a [node group](../../concepts/index.md#node-group), use its name or ID.

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a [node group](../../concepts/index.md#node-group):
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab to also view the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. In the node group row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the node group:

     ```bash
     yc k8s node-group delete <node_group_name>
     ```

     Result:

     ```text
     done
     ```

  1. Make sure the node group was deleted:

     ```bash
     yc managed-kubernetes node-group list
     ```

     Result:

     ```text
     +----+------------+------+-------------------+------------+--------+------+
     | ID | CLUSTER ID | NAME | INSTANCE GROUP ID | CREATED AT | STATUS | SIZE |
     +----+------------+------+-------------------+------------+--------+------+
     +----+------------+------+-------------------+------------+--------+------+
     ```

- {{ TF }} {#tf}

  To delete a [node group](../../concepts/index.md#node-group):
  1. Open the current {{ TF }} configuration file describing the node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).
  1. Delete the section describing the group you no longer need.
  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  To delete a node group, use the [delete](../../managed-kubernetes/api-ref/NodeGroup/delete.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) resource or the [NodeGroupService/Delete](../../managed-kubernetes/api-ref/grpc/NodeGroup/delete.md) gRPC API call.

{% endlist %}

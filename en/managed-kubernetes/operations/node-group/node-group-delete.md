---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Deleting a node group

To delete a [node group](../../concepts/index.md#node-group), use its name or ID.

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

{% list tabs %}

- Management console

    To delete a [node group](../../concepts/index.md#node-group):
    1. Go to the {{ k8s }} cluster you want to delete a node group from:
        1. Open the **{{ managed-k8s-name }}** section in the folder.
        1. Open the {{ k8s }} cluster.
    1. In the **Node group** tab, click the ![image](../../../_assets/vertical-ellipsis.svg) icon in the row of the node group to be deleted.
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Delete the node group:

        ```
        $ yc k8s node-group delete test-nodegroup
        ....................done
        ```

    1. Make sure that the node group was deleted:

        ```
        $ yc managed-kubernetes node-group list
        +----+------------+------+-------------------+------------+--------+------+
        | ID | CLUSTER ID | NAME | INSTANCE GROUP ID | CREATED AT | STATUS | SIZE |
        +----+------------+------+-------------------+------------+--------+------+
        +----+------------+------+-------------------+------------+--------+------+
        ```

- API

    To delete a node group, use the [delete](../../api-ref/NodeGroup/delete.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}


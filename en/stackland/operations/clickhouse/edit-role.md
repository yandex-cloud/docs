# Editing a role

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [role](create-role.md), you can edit role inheritance and permission blocks.

Once a role is created, you cannot edit role name (`spec.name`) and cluster name (`spec.cluster`).

## Using the CLI {#cli}

1. Get the list of roles in the project: `kubectl get clickhouserole -n <project_name>`.
1. Open the resource for editing: `kubectl edit clickhouserole <resource_name> -n <project_name>`.
1. Edit the `spec.membership` and `spec.grants` fields and save the file.

Each time a resource is edited, grants are recreated in {{ CH }}: the current set of privileges is revoked and a new one from `spec.grants` is applied. Role inheritance is synchronized based on `spec.membership`.

For a full list of allowed privileges for each block type, see [Allowed privileges](create-role.md#privileges).

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Navigate to the **Roles** tab.
1. Click the role name to open the card. The **General** tab shows inheritance, permission blocks, and status. To view the resource manifest, go to the **YAML** tab.
1. Click **Edit**.
1. Edit the roles in the **Inherit roles from** field and the permission blocks in the **Access permissions** section:

    * To add a permission block, click **Add**.
    * To delete a permission block, click **Delete** next to the block.
    * To change the block type, select a different value in the **Permissions for** switch. Fields not belonging to the new type get cleared.

1. Click **Save**.

# Deleting a role

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [role](create-role.md), you can delete it.

Removing a `ClickhouseRole` resource also deletes the role in {{ CH }}. For users the role was assigned to the link will become invalid. Update `ClickhouseUser` resources and remove the role resource name from `spec.roles`.

## Using the CLI {#cli}

1. Find the name of the role in the list of project roles: `kubectl get clickhouserole -n <project_name>`.
1. Delete the role resource: `kubectl delete clickhouserole <resource_name> -n <project_name>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Navigate to the **Roles** tab.
1. Choose the role.
1. Click **Delete**.
1. Confirm the deletion.

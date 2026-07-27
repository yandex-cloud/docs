# Updating a user

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [user](create-user.md), you can update the set of roles assigned to them.

Once created, you cannot edit the user name (`spec.name`) and cluster name (`spec.cluster`). To change the password, update the `stringData.password` value in the Kubernetes Secret referenced by the `ClickhouseUser` resource.

## Using the CLI {#cli}

1. Get the list of users in the project: `kubectl get clickhouseuser -n <project_name>`.
1. Open the resource for editing: `kubectl edit clickhouseuser <resource_name> -n <project_name>`.
1. Change the composition of roles in the `spec.roles` field and save the file.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} clusters**.
1. Select a cluster.
1. Go to the **Users** tab.
1. Click the user name to open the card. The **General** tab displays assigned roles and status. To view the resource manifest, go to the **YAML** tab.
1. Click **Edit**.
1. Change the composition of roles in the **Roles** field.
1. Click **Save**.

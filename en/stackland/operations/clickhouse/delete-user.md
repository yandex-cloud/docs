# Deleting a user

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [user](create-user.md), you can delete it.

Deleting the `ClickhouseUser` resource also deletes the user in {{ CH }}. The associated Kubernetes Secret with the password is not deleted automatically, so delete it separately if you need to.

## Using the CLI {#cli}

1. Find the name of the user in the list of project users: `kubectl get clickhouseuser -n <project_name>`.
1. Delete the user's resource: `kubectl delete clickhouseuser <resource_name> -n <project_name>`.
1. Optionally, delete the Secret with the password: `kubectl delete secret <secret_name> -n <project_name>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Go to the **Users** tab.
1. Select the user.
1. Click **Delete**.
1. Confirm the deletion.

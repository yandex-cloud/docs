# Deleting a {{ PG }} user

If you have a {{ PG }} user in your [cluster](../../concepts/components/postgresql.md), you can delete it.

## Using the CLI {#cli}

1. Find the name of the resource in the list of project users: `kubectl get PostgresqlRole -n <project_name>`.
1. Delete the resource: `kubectl delete PostgresqlRole <resource_name> -n <project_name>`.

Once deleted, the role can no longer connect to {{ PG }} or use any granted permissions. If the Kubernetes Secret containing the user password is associated with the `PostgresqlRole` resource through `ownerReferences`, it is automatically deleted together with the resource. If the Secret was created separately, delete it using the `kubectl delete Secret <sectet_name> -n <project_name>` command.

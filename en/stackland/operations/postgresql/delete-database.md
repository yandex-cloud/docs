# Deleting a {{ PG }} database

If you have a {{ PG }} database in your [cluster](../../concepts/components/postgresql.md), you can delete it.

{% note warning %}

Once deleted, the database and all its data are removed from the cluster. This operation cannot be reversed.

{% endnote %}

## Using the CLI {#cli}

1. Find the name of the resource in the list of databases: `kubectl get PostgresqlDatabase -n <project_name>`.
1. Delete the resource: `kubectl delete PostgresqlDatabase <resource_name> -n <project_name>`.

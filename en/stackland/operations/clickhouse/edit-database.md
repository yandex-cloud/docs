# Update database

Once a [{{ CH }}](../../concepts/components/clickhouse.md) [database](create-database.md) is created, you **cannot change** any of the `spec` fields.


## Using the CLI {#cli}

1. Get the list of databases in the project: `kubectl get clickhousedatabase -n <project_name>`.
1. View the current configuration: `kubectl get clickhousedatabase <resource_name> -n <project_name> -o yaml`.

To change a comment or database name, [delete](delete-database.md) the resource and create a new one.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Navigate to the **Databases** tab.
1. Click the database name to open its card. To view the resource manifest, go to the **YAML** tab.

After you create a comment, it cannot be edited. To specify a different comment, delete the database and create a new one with a new value in the **Comment** field.

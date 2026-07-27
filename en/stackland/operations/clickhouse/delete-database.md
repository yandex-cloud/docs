# Deleting a database

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [database](create-database.md), you can delete it.

If you delete the `ClickhouseDatabase` resource, the relevant database will be deleted in {{ CH }} as well together with all its tables and data.

## Using the CLI {#cli}

1. Find the name of the database in the list of project databases: `kubectl get clickhousedatabase -n <project_name>`.
1. Delete the database resource: `kubectl delete clickhousedatabase <resource_name> -n <project_name>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Navigate to the **Databases** tab.
1. Select the database.
1. Click **Delete**.
1. Confirm the deletion.

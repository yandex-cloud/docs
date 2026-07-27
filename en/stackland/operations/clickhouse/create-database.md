# Create database

You can create a database in your existing [{{ CH }}](../../concepts/components/clickhouse.md) [cluster](create-cluster.md) using a custom `ClickhouseDatabase` resource.

The `ClickhouseDatabase` resource must reside in the same namespace as the `ClickhouseCluster` cluster. The resource name must follow this pattern: `<cluster_name>-<database_name>`.

## Using the CLI {#cli}

1. Create the `ClickhouseDatabase` resource file, e.g., using the `touch clickhousedatabase.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/clickhousedatabase.md) %}

    Where:

    * `spec.cluster`: Name of the `ClickhouseCluster` cluster you are creating the database in.
    * `spec.name`: Database name in {{ CH }}.
    * `spec.comment`: Optional comment to the database. Once the database is created, you cannot edit this comment.

1. Apply the manifest: `kubectl apply -f clickhousedatabase.yaml -n <project_name>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Navigate to the **Databases** tab.
1. Click **Create**.
1. Fill out the fields as follows:

    * **Name**: Database name in {{ CH }}.
    * **Comment**: Optional database description.

1. Click **Create**.

Done. The database will now appear in the list on the **Databases** tab.

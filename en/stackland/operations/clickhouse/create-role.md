# Creating a role

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [cluster](create-cluster.md), you can create a role in it using a custom `ClickhouseRole` resource.

You can configure the following for your role:

* Role inheritance (`spec.membership`).
* Permission blocks (`spec.grants`) for four types of {{ CH }} objects: databases, tables, named collections, and user and role administration.

The `ClickhouseRole` resource must reside in the same namespace as the `ClickhouseCluster` cluster. The resource name must follow this pattern: `<cluster_name>-<user_name>`.

## Using the CLI {#cli}

1. Create the `ClickhouseRole` resource file, e.g., using the `touch clickhouserole.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Role with read permissions

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/clickhouserole-reader.md) %}

    - Role with inheritance and table permissions

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/clickhouserole-writer.md) %}

    {% endlist %}

    Where:

    * `spec.cluster`: `ClickhouseCluster` cluster name.
    * `spec.name`: {{ CH }} role name.
    * `spec.membership`: Optional list of roles from which this role inherits permissions. The list contains `spec.name` values of other `ClickhouseRole` resources.
    * `spec.grants`: List of permission blocks. Each block must specify exactly one of the following fields: `database`, `table`, `namedCollection`, or `access`.

1. Apply the manifest: `kubectl apply -f clickhouserole.yaml -n <project_name>`.

### Allowed privileges {#privileges}

The allowed privileges vary depending on the permission block type. Values must match the CRD exactly, including spaces in multi-word privileges.

#|
|| **Block type** | **Manifest field** | **Allowed privileges** ||
|| Database | `spec.grants[].database` | `SELECT`, `INSERT`, `ALTER TABLE`, `ALTER VIEW`, `CREATE TABLE`, `CREATE VIEW`, `CREATE DICTIONARY`, `DROP TABLE`, `DROP VIEW`, `DROP DICTIONARY`, `TRUNCATE`, `OPTIMIZE`, `SHOW TABLES`, `SHOW DICTIONARIES`, `ALTER DELETE`, `ALTER UPDATE` ||
|| Table | `spec.grants[].table` | `SELECT`, `INSERT`, `ALTER TABLE`, `ALTER VIEW`, `DROP TABLE`, `DROP VIEW`, `TRUNCATE`, `OPTIMIZE`, `ALTER DELETE`, `ALTER UPDATE` ||
|| Named collection | `spec.grants[].namedCollection` | `CREATE`, `DROP`, `ALTER` ||
|| User and role administration | `spec.grants[].access` | `CREATE USER`, `ALTER USER`, `DROP USER`, `CREATE ROLE`, `ALTER ROLE`, `DROP ROLE` ||
|#

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select the cluster.
1. Navigate to the **Roles** tab.
1. Click **Create**.
1. Fill out the fields as follows:

    * **Role name**: Role name in {{ CH }}.
    * **Inherit roles from**: Optional list of roles of the same cluster from which the new role inherits permissions. You can specify multiple roles.

1. Under **Access permissions**, configure the permissions. By default, one permission block is available:

    * In the **Permissions for** selector, select the object type: **Database**, **Table**, **Named collection**, or **User and role administration**.
    * For the **Database** type, select a database and privileges.
    * For the **Table** type, select a database, specify a table name, and select privileges.
    * For the **Named collection** and **User and role administration** types, only select privileges.

    To add another permission block, click **Add**. To delete a permission block, click **Delete** next to the block.

    For a list of allowed privileges for each block type, see [Allowed privileges](#privileges).

1. Click **Create**.

Done. The role will now appear in the list of roles on the **Role** tab.

# Managing databases

You can add and remove databases, as well as view information about them.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```bash
   {{ yc-mdb-pg }} database list --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   Use the [list](../api-ref/Database/list.md) API method and pass the cluster ID in the `clusterId` request parameter.

   The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mpg-name }}**.
   1. Click on the name of the desired cluster.
   1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).
   1. Select the **Databases** tab.
   1. Click ![image](../../_assets/plus-sign.svg) **Add**.
   1. Specify the database settings.

      * Name.

         {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * Owner.

      * (Optional) Template: The name of one of the existing databases from which the data schema needs to be copied. All connections to the template database will be closed while the new database is being created.

         For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Collation and character set locales.

         {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a database in a cluster:

   1. View a description of the CLI create database command:

      ```bash
      {{ yc-mdb-pg }} database create --help
      ```

   1. Request a list of cluster users to select the owner of the new database:

      ```bash
      {{ yc-mdb-pg }} user list --cluster-name=<cluster name>
      ```

      If the required user is not in the list, [create it](cluster-users.md#adduser).

   1. Run the create database command. If necessary, specify the required collation locale and character set (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`):

      ```bash
      {{ yc-mdb-pg }} database create <database name> \
        --cluster-name=<cluster name> \
        --owner=<DB owner username> \
        --lc-collate=<collation locale> \
        --lc-type=<character set locale>
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

      {{ mpg-short-name }} runs the create database operation.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_postgresql_database).

   1. Add the `yandex_mdb_postgresql_database` resource. If necessary, specify the required collation locale and character set (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`):

      ```hcl
      resource "yandex_mdb_postgresql_database" "<database name>" {
        cluster_id = "<cluster ID>"
        name       = "<database name>"
        owner      = "<owner username: must be specified in yandex_mdb_postgresql_user resource>"
        lc_collate = "<collation locale>"
        lc_type    = "<character set locale>"
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../api-ref/Database/create.md) API method and pass the following information in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new database settings in the `databaseSpec` parameter.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired DB and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a database, run the command:

   ```bash
   {{ yc-mdb-pg }} database delete <database name> \
     --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_postgresql_database).

   1. Delete the `yandex_mdb_postgresql_database` resource with the name of the database to delete.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [delete](../api-ref/Database/delete.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the deleted database in the `databaseName` parameter.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

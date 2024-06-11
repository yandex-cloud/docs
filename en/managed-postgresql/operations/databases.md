# Managing databases in {{ mpg-name }}

You can add, rename, and remove databases, as well as view information about them.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.


- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```bash
   {{ yc-mdb-pg }} database list --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API {#api}

   To get a list of databases in a cluster, use the [list](../api-ref/Database/list.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/List](../api-ref/grpc/database_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name.
   1. If the new database does not have an owner among its current users, [add such a user](cluster-users.md#adduser).
   1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
   1. Specify the database settings:

      * Name

         {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * Owner

      * Deletion protection

         The possible values include:
         - **Same as cluster**
         - **Enabled**
         - **Disabled**

      * (Optional) Template: The name of one of the existing databases from which the data schema needs to be copied. All connections to the template database will be closed while the new database is being created.

         For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Collation and character set locales.

         {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a database in a cluster:

   1. View a description of the CLI create database command:

      ```bash
      {{ yc-mdb-pg }} database create --help
      ```

   1. Request a list of cluster users to select the owner of the new database:

      ```bash
      {{ yc-mdb-pg }} user list --cluster-name=<cluster_name>
      ```

      If the required user is not in the list, [create it](cluster-users.md#adduser).

   1. Run the create database command. If necessary, specify the required collation and character set locales (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`) and the template:

      ```bash
      {{ yc-mdb-pg }} database create <DB_name> \
         --cluster-name=<cluster_name> \
         --owner=<owner_username> \
         --lc-collate=<collation_locale> \
         --lc-type=<character_set_locale> \
         --template-db=<template_DB_name>
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

      {{ mpg-short-name }} runs the create database operation.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

   1. Add the `yandex_mdb_postgresql_database` resource. If necessary, specify the required collation and character set locales (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`) and the template:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<DB_name>" {
        cluster_id  = "<cluster_ID>"
        name        = "<DB_name>"
        owner       = "<owner_username>"
        lc_collate  = "<collation_locale>"
        lc_type     = "<character_set_locale>"
        template_db = "<template_DB_name>"
        deletion_protection = <deletion_protection>
      }
      ```

      Where:
      * `owner`: Owner username that must be specified in the `yandex_mdb_postgresql_user` resource.
      * `deletion_protection`: DB deletion protection. It may take the `true`, `false`, or `unspecified` value (inherited from the cluster). The default value is `unspecified`.

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% note warning %}

   After you create a DB, do not change its owner in the `owner` parameter, as this will recreate the DB and its data will be lost.

   {% endnote %}

- API {#api}

   To create a database in a cluster, use the [create](../api-ref/Database/create.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Create](../api-ref/grpc/database_service.md#Create) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New database settings in the `databaseSpec` parameter.
   * Deletion protection type in the `deletionProtection` parameter. The possible values are `true` and `false`. The default value is `unspecified` (inherited from the cluster).

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

{% endlist %}

## Renaming a database {#rename-db}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

   1. Find the `yandex_mdb_postgresql_database` resource of the database.
   1. Change the value of the `name` field:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<database_name>" {
        ...
        name     = "<new_database_name>"
        ...
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To rename a database in a cluster, use the [update](../api-ref/Database/update.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Update](../api-ref/grpc/database_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster where the database is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Database name in the `databaseName` parameter. To find out the database name, [retrieve a list of databases in the cluster](#list-db).
   * New database name in the `newDatabaseName` parameter.

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

   * A list of database configuration fields to be modified (`newDatabaseName` in this case) as `updateMask`.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Configuring deletion protection {#update-db-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required DB row and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Select the appropriate value in the **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** field.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

   1. Find the `yandex_mdb_postgresql_database` resource of the DB.

   1. Add the `deletion_protection` parameter. The possible values are `true`, `false`, or `unspecified` (inherited from the cluster). The default value is `unspecified`.

      ```hcl
      resource "yandex_mdb_postgresql_database" "<database_name>" {
        ...
        deletion_protection = <deletion_protection>
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To configure DB deletion protection, use the [update](../api-ref/Database/update.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Update](../api-ref/grpc/database_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Database name, in the `databaseName` parameter. To find out the database name, [request a list of databases in the cluster](#list-db).
   * `updateMask` parameter with the `deletionProtection` value.
   * New value of the `deletionProtection` parameter. The possible values are `true` and `false`. The default value is `unspecified` (inherited from the cluster).

{% endlist %}

## Deleting a database {#remove-db}

A DB can be protected against deletion. To delete such a DB, [disable the protection](#update-db-deletion-protection) first.

{% list tabs group=instructions %}

- Management console {#console}

   To delete a database:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required DB row, select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**, and confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a database, run the command:

   ```bash
   {{ yc-mdb-pg }} database delete <DB_name> \
      --cluster-name <cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   To delete a database:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

   1. Delete the `yandex_mdb_postgresql_database` resource with the name of the database to delete.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To delete a database, use the [delete](../api-ref/Database/delete.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the deleted database in the `databaseName` parameter. To find out the database name, [retrieve a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

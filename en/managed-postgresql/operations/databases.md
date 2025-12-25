# Managing databases in {{ mpg-name }}

You can add, rename, and drop databases, as well as view their details.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster databases, run this command:

  ```bash
  {{ yc-mdb-pg }} database list --cluster-name=<cluster_name>
  ```

  You can get the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.List](../api-ref/Database/list.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.List](../api-ref/grpc/Database/list.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.List
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse) to make sure your request was successful.

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the relevant cluster’s name.
  1. If necessary, [create](cluster-users.md#adduser) a new user account for database owner.
  1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Specify database settings:

      * Name

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * Owner

      * Deletion protection

        Possible values:
          - **Same as cluster**
          - **Enabled**
          - **Disabled**

      * Template: The name of an existing database to use as a template for the new database’s schema. This is an optional setting. Creating the new database will close all active connections to the template database.

          For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Locales for collation and character set.

          {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. See the description of the CLI command for creating a database:

     ```bash
     {{ yc-mdb-pg }} database create --help
     ```

  1. Request a list of cluster users to select the owner for the new database:

     ```bash
     {{ yc-mdb-pg }} user list --cluster-name=<cluster_name>
     ```

     If necessary, [create a new user](cluster-users.md#adduser).

  1. Run the database creation command. Optionally, specify the template and your preferred collation and character set locales. The default locale settings are `LC_COLLATE=C` and `LC_CTYPE=C`:

     ```bash
     {{ yc-mdb-pg }} database create <DB_name> \
        --cluster-name=<cluster_name> \
        --owner=<DB_owner_name> \
        --lc-collate=<collation_locale> \
        --lc-type=<character_set_locale> \
        --template-db=<DB_template_name>
     ```

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can get the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

     {{ mpg-short-name }} will launch the database creation process.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

        For a complete list of configurable {{ mpg-name }} cluster database settings, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_database).

    1. Add the `yandex_mdb_postgresql_database` resource: Optionally, specify the template and your preferred collation and character set locales. The default locale settings are `LC_COLLATE=C` and `LC_CTYPE=C`:

        ```hcl
        resource "yandex_mdb_postgresql_database" "<DB_name>" {
          cluster_id  = "<cluster_ID>"
          name        = "<DB_name>"
          owner       = "<DB_owner_name>"
          lc_collate  = "<collation_locale>"
          lc_type     = "<character_set_locale>"
          template_db = "<DB_template_name>"
          deletion_protection = <deletion_protection>
        }
        ```

        Where:
          * `owner`: Name of the user who will own the database, defined in the `yandex_mdb_postgresql_user` resource.
          * `deletion_protection`: Database deletion protection. The possible values are `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% note warning %}

  Changing the owner of the existing database by editing the `owner` setting will trigger the database recreation, resulting in data loss.

  {% endnote %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Create](../api-ref/Database/create.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<DB_name>",
                   "owner": "<DB_owner_name>",
                   "lcCollate": "<collation_locale>",
                   "lcCtype": "<character_set_locale>",
                   "extensions": [
                     {
                       "name": "<extension_name>"
                     }
                   ],
                   "deletionProtection": <deletion_protection>
                 }
               }'
     ```

     Where `databaseSpec` is the object containing the settings for the new database and having the the following structure:

     * `name`: Database name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner`: Database owner.
     * `lcCollate`: Collation locale. The default value is `C`.
     * `lcCtype`: Character set locale. The default value is `C`.
     * `extensions`: Array of database extensions. Each array element contains the configuration for a single extension and has the following structure:

       * `extensions.name`: Extension name.

       Use a name from  the [list of supported {{ PG }} extensions and utilities](extensions/cluster-extensions.md#postgresql).

     * `deletionProtection`: Database deletion protection. The possible values are `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Create](../api-ref/grpc/Database/create.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_spec": {
               "name": "<DB_name>",
               "owner": "<DB_owner_name>",
               "lc_collate": "<collation_locale>",
               "lc_ctype": "<character_set_locale>",
               "extensions": [
                 {
                   "name": "<extension_name>"
                 }
               ],
               "deletion_protection": <deletion_protection>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Create
     ```

     Where `databaseSpec` is the object containing the settings for the new database and having the the following structure:

     * `name`: Database name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner`: Database owner.
     * `lc_collate`: Collation locale. The default value is `C`.
     * `lc_ctype`: Character set locale. The default value is `C`.
     * `extensions`: Array of database extensions. Each array element contains the configuration for a single extension and has the following structure:

       * `extensions.name`: Extension name.

       Use a name from  the [list of supported {{ PG }} extensions and utilities](extensions/cluster-extensions.md#postgresql).

     * `deletion_protection`: Database deletion protection. The possible values are `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Renaming a database {#rename-db}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of configurable {{ mpg-name }} cluster database settings, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Find the `yandex_mdb_postgresql_database` resource describing your target database.
  1. Update the `name` field:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<database_name>" {
        ...
        name     = "<new_database_name>"
        ...
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Update](../api-ref/Database/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<previous_DB_name>' \
       --data '{
                 "updateMask": "newDatabaseName",
                 "newDatabaseName": "<new_DB_name>"
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `newDatabaseName`: New database name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [cluster’s database list](#list-db).

  1. Check the [server response](../api-ref/Database/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Update](../api-ref/grpc/Database/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<previous_DB_name>",
             "update_mask": {
               "paths": [
                 "new_database_name"
               ]
             },
             "new_database_name": "<new_DB_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `new_database_name`: New database name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [list of cluster databases](#list-db).

  1. Check the [server response](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring deletion protection {#update-db-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
  1. Find the database you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Select your preferred option in the **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** field.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

  1. Find the `yandex_mdb_postgresql_database` resource describing your target database.

  1. Add the `deletion_protection` attribute. The possible values are `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_database" "<DB_name>" {
          ...
          deletion_protection = <deletion_protection>
          ...
        }
        ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Update](../api-ref/Database/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <deletion_protection>
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `deletionProtection`: Database deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [list of cluster databases](#list-db).

  1. Check the [server response](../api-ref/Database/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Update](../api-ref/grpc/Database/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": <deletion_protection>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `deletion_protection`: Database deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [list of cluster databases](#list-db).

  1. Check the [server response](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

Deletion protection only applies to individual databases. Deleting a cluster will permanently remove all its databases, including those with deletion protection.

{% endnote %}

## Deleting a database {#remove-db}

A database can have deletion protection enabled. To delete it, first [disable deletion protection](#update-db-deletion-protection).

{% list tabs group=instructions %}

- Management console {#console}

  To delete a database:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
  1. Find the database you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**, then confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run this command:

  ```bash
  {{ yc-mdb-pg }} database delete <DB_name> \
     --cluster-name <cluster_name>
  ```

  You can get the cluster name from the [folder’s cluster list](cluster-list.md).

- {{ TF }} {#tf}

  To delete a database:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster database settings, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Delete the `yandex_mdb_postgresql_database` resource that has the name of your target database.

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Delete](../api-ref/Database/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [list of cluster databases](#list-db).

  1. Check the [server response](../api-ref/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Delete
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the database name from the [list of cluster databases](#list-db).

  1. Check the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

Wait for the deletion operation to fully complete before creating a new database with the same name. Otherwise, the original database will be restored. You can check the operation status in the [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

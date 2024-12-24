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

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.List](../api-ref/Database/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.List](../api-ref/grpc/Database/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse) to make sure the request was successful.

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

        The possible values are:
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

  1. Run the create database command. If necessary, specify the required collation and character set locales (the default ones are `LC_COLLATE=C` and `LC_CTYPE=C`) and the template:

     ```bash
     {{ yc-mdb-pg }} database create <DB_name> \
        --cluster-name=<cluster_name> \
        --owner=<database_owner_name> \
        --lc-collate=<collation_locale> \
        --lc-type=<character_set_locale> \
        --template-db=<DB_template_name>
     ```

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

     {{ mpg-short-name }} runs the create database operation.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of editable fields in the {{ mpg-name }} cluster database configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

    1. Add the `yandex_mdb_postgresql_database` resource: If necessary, specify the required collation and character set locales (the default ones are `LC_COLLATE=C` and `LC_CTYPE=C`) and the template:

        ```hcl
        resource "yandex_mdb_postgresql_database" "<DB_name>" {
          cluster_id  = "<cluster_ID>"
          name        = "<DB_name>"
          owner       = "<database_owner_name>"
          lc_collate  = "<collation_locale>"
          lc_type     = "<character_set_locale>"
          template_db = "<DB_template_name>"
          deletion_protection = <deletion_protection>
        }
        ```

        Where:
          * `owner`: Username of the owner that must be specified in the `yandex_mdb_postgresql_user` resource.
          * `deletion_protection`: DB deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% note warning %}

  After you create a DB, do not change its owner in the `owner` parameter, as this will recreate the DB and its data will be lost.

  {% endnote %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Create](../api-ref/Database/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<DB_name>",
                   "owner": "<database_owner_name>",
                   "lcCollate": "<collation_locale>",
                   "lcCtype": "<character_set_locale>",
                   "extensions": [
                     {
                       "name": "<extension_name>",
                       "version": "<extension_version>"
                     }
                   ],
                   "deletionProtection": <deletion_protection:_true_or_false>
                 }
               }'
     ```

     Where `databaseSpec` is the object containing the new DB settings: Its structure is as follows:

     * `name`: DB name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner`: DB owner username.
     * `lcCollate`: Collation locale. The default value is `C`.
     * `lcCtype`: Character set locale. The default value is `C`.
     * `extensions`: Array of DB extensions. One array element contains settings for a single extension and has the following structure:

       * `extensions.name`: Extension name.
       * `extensions.version`: Extension version.

       Specify the name and version from the [list of supported {{ PG }} extensions and utilities](extensions/cluster-extensions.md#postgresql).

     * `deletionProtection`: DB deletion protection.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Create](../api-ref/grpc/Database/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
               "owner": "<database_owner_name>",
               "lc_collate": "<collation_locale>",
               "lc_ctype": "<character_set_locale>",
               "extensions": [
                 {
                   "name": "<extension_name>",
                   "version": "<extension_version>"
                 }
               ],
               "deletion_protection": <deletion_protection:_true_or_false>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Create
     ```

     Where `databaseSpec` is the object containing the new DB settings: Its structure is as follows:

     * `name`: DB name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner`: DB owner username.
     * `lc_collate`: Collation locale. The default value is `C`.
     * `lc_ctype`: Character set locale. The default value is `C`.
     * `extensions`: Array of DB extensions. One array element contains settings for a single extension and has the following structure:

       * `extensions.name`: Extension name.
       * `extensions.version`: Extension version.

       Specify the name and version from the [list of supported {{ PG }} extensions and utilities](extensions/cluster-extensions.md#postgresql).

     * `deletion_protection`: DB deletion protection.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Renaming a database {#rename-db}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of editable fields in the {{ mpg-name }} cluster database configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Find the `yandex_mdb_postgresql_database` resource of the database you need.
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

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Update](../api-ref/Database/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `newDatabaseName`: New DB name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/Database/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Update](../api-ref/grpc/Database/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `new_database_name`: New DB name.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

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

  1. Find the `yandex_mdb_postgresql_database` resource of the DB you need.

  1. Add the `deletion_protection` parameter. The possible values are `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_database" "<DB_name>" {
          ...
          deletion_protection = <deletion_protection>
          ...
        }
        ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Update](../api-ref/Database/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <deletion_protection:_true_or_false>
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       Only one parameter is provided in this case.

     * `deletionProtection`: DB deletion protection.

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/Database/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Update](../api-ref/grpc/Database/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
             "deletion_protection": <deletion_protection:_true_or_false>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `deletion_protection`: DB deletion protection.

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note warning %}

Deletion protection only applies at specific DB level. Deleting a cluster will delete all DBs, including those protected from deletion.

{% endnote %}

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

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of editable fields in the {{ mpg-name }} cluster database configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Delete the `yandex_mdb_postgresql_database` resource with the name of the database you want to delete.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Delete](../api-ref/Database/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/Database/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

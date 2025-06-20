---
title: How to manage {{ CH }} cluster databases in {{ mch-full-name }}
description: Follow this guide to manage {{ CH }} cluster databases.
---

# Database management in {{ mch-name }}

{{ mch-name }} provides two ways for you to manage cluster databases:

* Using native {{ yandex-cloud }} interfaces, such as the CLI, API, or management console. Select this method if you wish to create and delete cluster databases using {{ mch-full-name }} features.
* SQL queries to the cluster. Select this method if you want to use an existing solution for creating and managing databases, or if you need {{ MY }} database support in {{ mch-name }}.

## Database management via SQL {#sql-database-management}

To enable management, activate the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** options when [creating](cluster-create.md) or [reconfiguring](./update.md#SQL-management) a cluster.

In a cluster with DB management via SQL enabled:

* Database and [user](./cluster-users.md#sql-user-management) management using the standard {{ yandex-cloud }} interfaces (CLI, API, management console) is unavailable.
* You cannot enable user or database management using the standard {{ yandex-cloud }} interfaces.
* The existing users as well as user and database settings made with the standard {{ yandex-cloud }} interfaces will be saved.
* User management is performed using the `admin` account. You set its password when selecting the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** options.

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} database list \
     --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.List](../api-ref/Database/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse) to make sure the request was successful.

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
        -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.clickhouse.v1.DatabaseService.List
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse) to make sure the request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to a cluster using the [`admin` account](#sql-database-management).
  1. Get a list of databases:

      ```sql
      SHOW DATABASES;
      ```

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

To learn more about limits, see [Quotas and limits](../concepts/limits.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name.
  1. Select the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Enter the database name and click **{{ ui-key.yacloud.clickhouse.cluster.databases.popup-add_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the create database command and set the name of the new database:

  ```bash
  {{ yc-mdb-ch }} database create <DB_name> \
     --cluster-name=<cluster_name>
  ```

  {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  {{ mch-short-name }} runs the create database operation.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Add the `yandex_mdb_clickhouse_database` resource:

        ```hcl
        resource "yandex_mdb_clickhouse_database" "<DB_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<DB_name>"
        }
        ```

        {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

        If you create a cluster with the help of {{ TF }} at the same time as creating a DB, specify a link to the new cluster's name instead of cluster ID in the `yandex_mdb_clickhouse_database` resource:

        ```hcl

        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          name = "<cluster_name>"
          ...
        }

        resource "yandex_mdb_clickhouse_database" "<DB_name>" {
          cluster_id = yandex_mdb_clickhouse_cluster.<cluster_name>.id
          name       = "<DB_name>"
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Create](../api-ref/Database/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases' \
          --data '{
                    "databaseSpec": {
                      "name": "<DB_name>"
                    }
                  }'
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "database_spec": {
                  "name": "<DB_name>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.DatabaseService.Create
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to a cluster using the [`admin` account](#sql-database-management).
  1. Create a database:

      ```sql
      CREATE DATABASE <DB_name>;
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  To learn more about creating databases, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/create/database/).

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required DB row and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```bash
  {{ yc-mdb-ch }} database delete <DB_name> \
     --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Delete the `yandex_mdb_clickhouse_database` resource with the name of the database you want to delete.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Delete](../api-ref/Database/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases/<DB_name>'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the DB name, with the [list of DBs in the cluster](#list-db).

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "database_name": "<DB_name>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.DatabaseService.Delete
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the DB name, with the [list of DBs in the cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to a cluster using the [`admin` account](#sql-database-management).
  1. Delete the database:

      ```sql
      DROP DATABASE <DB_name>;
      ```

  To learn more about deleting objects, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/drop/).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

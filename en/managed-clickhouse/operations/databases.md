---
title: How to manage {{ CH }} cluster databases in {{ mch-full-name }}
description: Follow this guide to manage {{ CH }} cluster databases.
---

# Database management in {{ mch-name }}

{{ mch-name }} provides two methods for managing cluster databases:

* Using the native {{ yandex-cloud }} interfaces, such as the CLI, API, and management console. Select this method to create and delete cluster databases using the {{ mch-full-name }} features.
* Using SQL queries to the cluster. Select this method to use your own solution to create and manage databases, or if you need {{ MY }} database support in {{ mch-name }}.

## Database management via SQL {#sql-database-management}

To enable this management method, select **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** when [creating](cluster-create.md) or [reconfiguring](./update.md#SQL-management) your cluster.

In a cluster with enabled database management via SQL:

* You cannot manage databases and [users](./cluster-users.md#sql-user-management) via the native {{ yandex-cloud }} interfaces, such as the CLI, API, and management console.
* You cannot enable user or database management via the native {{ yandex-cloud }} interfaces.
* The existing users, user settings, and databases created with the native {{ yandex-cloud }} interfaces will remain unchanged.
* Use the `admin` account for management. You set the `admin` password when selecting the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** options.

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster databases, run this command:

  ```bash
  {{ yc-mdb-ch }} database list \
     --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.List](../api-ref/Database/list.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.List](../api-ref/grpc/Database/list.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse) to make sure your request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to your cluster as [`admin`](#sql-database-management).
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

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name.
  1. Select the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Enter a name for the database.

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  1. Select the database engine: 
      
      * By default, `Atomic` supports the non-blocking `DROP TABLE` and `RENAME TABLE` operations and atomic `EXCHANGE TABLES` operations.
      * `Replicated` supports table metadata replication across all database replicas. The set of tables and their schemas will be the same for all replicas.

        It is only available in [replicated](../concepts/replication.md) clusters.

      You can only set the engine when creating a database and cannot change it later.

  1. Click **{{ ui-key.yacloud.clickhouse.cluster.databases.popup-add_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the database create command, providing a name for the new database:

  ```bash
  {{ yc-mdb-ch }} database create <DB_name> \
     --cluster-name=<cluster_name>
  ```

  {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  {{ mch-short-name }} will start creating the database.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For information on how to create such a file, see [Creating a cluster](cluster-create.md).

    1. Add the `yandex_mdb_clickhouse_database` resource:

        ```hcl
        resource "yandex_mdb_clickhouse_database" "<DB_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<DB_name>"
        }
        ```

        {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

        When creating both a cluster and a database with {{ TF }} at the same time, specify a name for the new cluster rather than cluster ID in the `yandex_mdb_clickhouse_database` resource:

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

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Create](../api-ref/Database/create.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases' \
          --data '{
                    "databaseSpec": {
                      "name": "<DB_name>",
                      "engine": "<database_engine>"
                    }
                  }'
      ```

      Where: 

      * `databaseSpec.name`: Database name.

        {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}
        
      * `databaseSpec.engine`: Database engine. The possible values are:
        
        {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Create](../api-ref/grpc/Database/create.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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
                  "name": "<DB_name>",
                  "engine": "<database_engine>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.DatabaseService.Create
      ```

      Where: 

      * `database_spec.name`: Database name.

        {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}
        
      * `database_spec.engine`: Database engine. The possible values are:

        {% include [database-engine-api](../../_includes/mdb/mch/database-engine-api.md) %}

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to your cluster as [`admin`](#sql-database-management).
  1. Create a database:

      ```sql
      CREATE DATABASE <DB_name>;
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  To learn more about creating databases, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/statements/create/database/).

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the relevant database row and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run this command:

  ```bash
  {{ yc-mdb-ch }} database delete <DB_name> \
     --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For information on how to create such a file, see [Creating a cluster](cluster-create.md).

    1. Delete the `yandex_mdb_clickhouse_database` resource with the name of the database you are deleting.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Delete](../api-ref/Database/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/databases/<DB_name>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the database name, with the [list of databases in the cluster](#list-db).

  1. View the [server response](../api-ref/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the database name, with the [list of databases in the cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- SQL {#sql}

  1. [Connect](connect/clients.md) to your cluster as [`admin`](#sql-database-management).
  1. Delete the database:

      ```sql
      DROP DATABASE <DB_name>;
      ```

  Learn more about deleting objects in [this {{ CH }} guide]({{ ch.docs }}/sql-reference/statements/drop/).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete. Otherwise, the original database will be restored. You can get the operation status with the [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

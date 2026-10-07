---
title: Managing databases in {{ SPQR }}
description: In this tutorial, you will learn how to add, rename, and delete databases in {{ SPQR }}, and view their info.
---

# Managing databases in {{ SPQR }}

You can add and delete databases, and view their info.

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster databases, run this command:

  ```bash
  yc managed-sharded-postgresql database list \
     --cluster-id <cluster_ID>
  ```

  {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.List](../api-ref/Database/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/databases'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. View the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.List](../api-ref/grpc/Database/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.DatabaseService.List
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse) to make sure your request was successful.

{% endlist %}

## Getting database info {#get-db}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get database info, run this command:

  ```bash
  yc managed-sharded-postgresql database get <database_name> \
     --cluster-id <cluster_ID>
  ```

  You can get the database name with the [list of databases](#list-db) in the cluster, and the cluster ID, with the [list of clusters](cluster-list.md#list-clusters) in the folder.
  
- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Get](../api-ref/Database/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/Database/get.md#yandex.cloud.mdb.spqr.v1.Database) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Get](../api-ref/grpc/Database/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Get
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/Database/get.md#yandex.cloud.mdb.spqr.v1.Database) to make sure your request was successful.

{% endlist %}

## Creating a database {#add-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_databases }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Specify database settings:

      * Name

        {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}

      * Deletion protection

        The possible values are:
          - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
          - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
          - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. See the description of the CLI command for creating a database:

      ```bash
      yc managed-sharded-postgresql database create --help
      ```
  
  1. Create a database by running this command:

      ```bash
      yc managed-sharded-postgresql database create <DB_name> \
         --cluster-id <cluster_ID>
      ```

      Where: 

      * `<DB_name>`: Name of your new database.

        {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}
      
      * `--cluster-id`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      To learn how to create this file, refer to [{#T}](cluster-create.md).

  1. Add the `yandex_mdb_sharded_postgresql_database` resource:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_database" "<local_DB_name>" {
        cluster_id = <cluster_ID>
        name       = "<DB_name>"
      }
      ```

      Where:
      
      * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}

      * `name`: Database name.
        
        {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}
      
      For more information about the `yandex_mdb_sharded_postgresql_database` resource, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_database).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Create](../api-ref/Database/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<DB_name>",
                   "deletionProtection": "<protect_database_from_deletion>"
                 }
               }'
     ```

     Where: 

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
     * `databaseSpec`: New database settings:

       * `name`: Database name.

         {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}

       * `deletionProtection`: Database deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Create](../api-ref/grpc/Database/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_spec": {
               "name": "<DB_name>",
               "deletion_protection": "<protect_database_from_deletion>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Create
     ```

     Where:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * `database_spec`: New database settings:

       * `name`: Database name.

         {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}

       * `deletion_protection`: Database deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a database:
  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_databases }}** tab.
  1. Find the database you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**, then confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run this command:

  ```bash
  yc managed-sharded-postgresql database delete <DB_name> \
     --cluster-id <cluster_ID>
  ```

  You can get the database name with the [list of databases](#list-db) in the cluster, and the cluster ID, with the [list of clusters](cluster-list.md#list-clusters) in the folder.


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      To learn how to create this file, refer to [{#T}](cluster-create.md).

  1. Delete the `yandex_mdb_sharded_postgresql_database` resource describing the database you want to delete.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.Delete](../api-ref/Database/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Delete
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

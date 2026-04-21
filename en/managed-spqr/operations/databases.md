---
title: Managing databases in {{ SPQR }}
description: In this tutorial, you will learn how to add, rename, and delete databases in {{ SPQR }}, and view their info.
---

# Managing databases in {{ SPQR }}

You can add and delete databases, and view their info.

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_databases }}** tab.

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

  1. Check the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse) to make sure your request was successful.

{% endlist %}

## Getting database info {#get-db}

{% list tabs group=instructions %}

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

  1. Check the [server response](../api-ref/grpc/Database/get.md#yandex.cloud.mdb.spqr.v1.Database) to make sure your request was successful.

{% endlist %}

## Creating a database {#add-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
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

     Where `databaseSpec` are the new database settings:

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

     Where `database_spec` are the new database settings:

     * `name`: Database name.

       {% include [db-name-limits](../../_includes/mdb/mspqr/console/db-name-limits.md) %}

     * `deletion_protection`: Database deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a database:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_databases }}** tab.
  1. Find the database you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**, then confirm the deletion.

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

  1. Check the [server response](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

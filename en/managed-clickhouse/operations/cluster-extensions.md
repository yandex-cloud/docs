# Managing extensions in {{ mch-name }}

In {{ mch-name }} clusters, the following extensions are available:

| **Extension** | **Description** |
| --- | --- |
| CatBoost | Analyzing data with the help of [CatBoost ML models](./ml-models.md) |
| GeoDB | Managing [geobases](./geobase.md): uploading, adding, and creating custom geobases |

## Getting the list of available extensions {#extension-list}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of all extensions available for installation and their versions, run this command:

  ```bash
  {{ yc-mdb-ch }} extension list
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Extension.List](../api-ref/Extension/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions'
     ```

  1. View the [server response](../api-ref/Extension/list.md#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse) to make sure your request was successful.

     You can find the list of extensions available for installation and their versions in the `extensions` field of the command output.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ExtensionService.List](../api-ref/grpc/Extension/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ExtensionService.List
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Extension/list.md#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse) to make sure your request was successful.

     You can find the list of extensions available for installation and their versions in the `extensions` field of the command output.

{% endlist %}

## Retrieving a list of installed extensions {#cluster-list-extensions}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of all extensions installed in your cluster and their versions, run this command:

  ```bash
  {{ yc-mdb-ch }} cluster list-extensions <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.List](../api-ref/ClusterExtension/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Extension/get.md#yandex.cloud.mdb.clickhouse.v1.Extension) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.List](../api-ref/grpc/ClusterExtension/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.List
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/ClusterExtension/list.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse) to make sure your request was successful.

{% endlist %}

## Getting extension info {#extension-get}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed extension info, run this command:

  ```bash
  {{ yc-mdb-ch }} extension get <extension_name>
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Extension.Get](../api-ref/Extension/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/extensions/<extension_name>'
     ```

  1. View the [server response](../api-ref/Extension/get.md#yandex.cloud.mdb.clickhouse.v1.Extension) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ExtensionService.Get](../api-ref/grpc/Extension/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "extension_name": "<extension_name>",
             "folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ExtensionService.Get
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Extension/get.md#yandex.cloud.mdb.clickhouse.v1.Extension) to make sure your request was successful.

{% endlist %}

## Getting information about an extension installed in a cluster {#cluster-get-extension}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about an extension installed in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} cluster get-extension <cluster_name_or_ID> \
     --extension-name <extension_name>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.Get](../api-ref/ClusterExtension/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions/<extension_name>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/ClusterExtension/get.md#yandex.cloud.mdb.clickhouse.v1.ClusterExtension) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.Get](../api-ref/grpc/ClusterExtension/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "extension_name": "<extension_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.Get
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/ClusterExtension/get.md#yandex.cloud.mdb.clickhouse.v1.ClusterExtension) to make sure your request was successful.

{% endlist %}

## Installing an extension in a cluster {#cluster-add-extension}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To install an extension in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} cluster add-extension <cluster_name_or_ID> \
     --extension-name <extension_name>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.Create](../api-ref/ClusterExtension/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions'
       --data '{
                 "extensionSpec": {
                   "name": "<extension_name>"
                 }
               }'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/ClusterExtension/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.Create](../api-ref/grpc/ClusterExtension/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "extension_spec": {
                 "name": "<extension_name>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.Create
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/ClusterExtension/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating an extension {#cluster-update-extension}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update an extension installed in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} cluster update-extension <cluster_name_or_ID> \
     --extension-name <extension_name>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.Update](../api-ref/ClusterExtension/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions'
       --data '{
                 "extensionSpec": {
                   "name": "<extension_name>"
                 }
               }'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/ClusterExtension/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.Update](../api-ref/grpc/ClusterExtension/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "extension_spec": {
                 "name": "<extension_name>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.Update
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/ClusterExtension/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting an extension from a cluster {#cluster-remove-extension}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete an extension from a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} cluster remove-extension <cluster_name_or_ID> \
     --extension-name <extension_name>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.Delete](../api-ref/ClusterExtension/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions/<extension_name>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/ClusterExtension/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.Delete](../api-ref/grpc/ClusterExtension/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "extension_name": "<extension_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.Delete
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/ClusterExtension/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Batch installation, updating, and deleting extensions {#cluster-get-extension}

You can install, update, and delete multiple extensions using a single request. Do it by including the names of all the extensions in the request. The extensions you specify will be:

  * Installed if not present in the cluster.
  * Updated to the latest version if already installed in the cluster.

Extensions not specified in the request will be deleted from the cluster.

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [ClusterExtension.SetExtensions](../api-ref/ClusterExtension/setExtensions.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/extensions:batchSet'
       --data '{
                 "extensionSpec": [
                   {
                     "name": "<extension_name>"
                   },
                   {
                     "name": "<extension_2_name>"
                   },
                   { ... },
                   {
                     "name": "<extension_N_name>"
                   }
                 ]
               }'       
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/ClusterExtension/setExtensions.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterExtensionService.SetExtensions](../api-ref/grpc/ClusterExtension/setExtensions.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "extension_specs": [
               {
                   "name": "<extension_name>"
               },
               {
                   "name": "<extension_2_name>"
               },
               { ... },
               {
                   "name": "<extension_N_name>"
               }          
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterExtensionService.SetExtensions
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/ClusterExtension/setExtensions.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

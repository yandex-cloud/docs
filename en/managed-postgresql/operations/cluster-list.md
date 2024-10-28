---
title: Information about clusters in {{ mpg-short-name }}
description: You can request detailed information about each {{ mpg-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mpg-name }}.
---

# Getting information on existing {{ PG }} clusters

You can request detailed information about each {{ mpg-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ PG }} clusters in the default folder, run the command:

  ```bash
  {{ yc-mdb-pg }} cluster list
  ```

  ```text
  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | mypg          | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.list](../api-ref/Cluster/list.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters?folderId=<folder_ID>'
     ```


     You can request the folder ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/Cluster/list.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/List](../api-ref/grpc/Cluster/list.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.List
     ```


     You can request the folder ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.postgresql.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about the {{ PG }} cluster, run the following command:

  ```bash
  {{ yc-mdb-pg }} cluster get <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.get](../api-ref/Cluster/get.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>'
     ```

     You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/get.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Get
     ```

     You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name.
  1. Go to the **{{ ui-key.yacloud.postgresql.cluster.switch_operations }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations, run the following command:

  ```bash
  {{ yc-mdb-pg }} cluster list-operations <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.listOperations](../api-ref/Cluster/listOperations.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/operations'
     ```

     You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/listOperations.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListOperations
     ```

     You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.postgresql.v1.ListClusterOperationsResponse) to make sure the request was successful.

{% endlist %}

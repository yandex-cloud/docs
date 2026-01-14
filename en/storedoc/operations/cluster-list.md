---
title: Information about clusters in {{ mmg-short-name }}
description: You can get detailed information about each {{ mmg-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder dashboard and select {{ mmg-name }}.
---

# Information about existing {{ SD }} clusters

You can get detailed information about each {{ mmg-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ SD }} clusters in the default folder, run this command:

  ```bash
  yc managed-mongodb cluster list
  ```

  Result:

  ```text
  +----------------------+------------+-----------------------------+--------+---------+
  |          ID          |    NAME    |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | mymg       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                |
  +----------------------+------------+-----------------------------+--------+---------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.List](../api-ref/Cluster/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters' \
          --url-query folderId=<folder_ID>
      ```

      
      You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.mongodb.v1.ListClustersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Call the [ClusterService.List](../api-ref/grpc/Cluster/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.List
      ```

      
      You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.mongodb.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ SD }} cluster, run the following command:

  ```bash
  {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.mongodb.v1.Cluster) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Get
        ```

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.mongodb.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mmg-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ mmg-name }} clusters, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}** in the left-hand panel. In the list that opens, you will also see operations for the deleted resources.

  You can get a list of operations for a cluster as follows:

  1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mongodb.switch_list }}**.
  1. Select the cluster you need.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}** panel for the cluster you selected.

     You will see the list of operations with this cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mmg-name }} cluster, run this command:

  ```bash
  yc managed-mongodb cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |      DESCRIPTION       |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  | c9ql1rfrqk4u******** | 2024-09-07 16:37:10 | aje9k8luj4qf******** | 2024-09-07 16:44:28 | DONE   | Create MongoDB cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

  By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using `--format`:

  ```bash
  yc managed-mongodb cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: c9ql1rfrqk4u********
    description: Create MongoDB cluster
    created_at: "2024-09-07T16:37:10.533508Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:28.147771Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
      cluster_id: c9q8tmbam8co********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/operations'
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.mongodb.v1.ListClusterOperationsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ListOperations
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.mongodb.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get the list of operations](#get-operations) for your cluster.
1. Copy the ID of the operation you need.
1. Get the operation details:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Run this command:

     ```bash
     yc operation get <operation_ID>
     ```

     Result:

     ```text
     id: c9ql1rfrqk4u********
     description: Create MongoDB cluster
     created_at: "2024-09-07T16:37:10.533508Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-09-07T16:44:28.147771Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
       cluster_id: c9q8tmbam8co********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.Cluster
     ...
     ```

    - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Call the [Operation.Get](../api-ref/Operation/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-operation }}/operations/<operation_ID>'
          ```

      1. View the [server response](../api-ref/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    - gRPC API {#grpc-api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

      1. Call the [OperationService.Get](../api-ref/grpc/Operation/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/operation/operation_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "operation_id": "<operation_ID>"
                  }' \
              {{ api-host-operation }}:{{ port-https }} \
              yandex.cloud.operation.OperationService.Get
          ```

      1. View the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

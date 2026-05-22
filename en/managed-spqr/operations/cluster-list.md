---
title: Information about clusters in {{ mspqr-name }}
description: You can request detailed information for each {{ mspqr-name }} cluster you have created. To get a list of clusters in a folder, navigate to the folder dashboard and go to {{ mspqr-name }}.
---

# Getting information about existing {{ SPQR }} clusters

You can get detailed information about each {{ mspqr-short-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ SPQR }} clusters in the default folder, run this command:

  ```bash
  yc managed-sharded-postgresql cluster list
  ```

  ```text
  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | myspqr        | 2025-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.List](../api-ref/Cluster/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters' \
       --url-query folderId=<folder_ID>
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.spqr.v1.ListClustersResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.List
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.spqr.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting cluster details {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get {{ SPQR }} cluster details, run the following command:

  ```bash
  yc managed-sharded-postgresql cluster get <cluster_name_or_ID>
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
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.spqr.v1.Cluster) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Get
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.spqr.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mspqr-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ mspqr-name }} clusters, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.postgresql.switch_operations_9JzwJ }}** in the left-hand panel. In the list that opens, you will also see operations for the deleted resources.

  To get a list of operations for an existing cluster:

  1. In the [management console]({{ link-console-main }}), open the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.postgresql.switch_list_9AfbP }}**.
  1. Select the cluster and open the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.postgresql.switch_operations_9JzwJ }}** tab.

     You will see the list of operations with the cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mspqr-name }} cluster, run this command:

  ```bash
  yc managed-sharded-postgresql cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c5m7ll6pq3j8******** | 2025-11-28 19:05:42 | ajeef73j5iq9******** | 2025-11-28 19:08:05 | DONE   | Add shard to SPQR cluster      |
  | c5mb0no66172******** | 2025-11-19 12:48:40 | ajeef73j5iq9******** | 2025-11-19 12:50:14 | DONE   | Add shard to SPQR cluster      |
  | c5m6of9he7op******** | 2025-11-13 19:25:21 | ajeef73j5iq9******** | 2025-11-13 19:32:00 | DONE   | Create SPQR cluster            |
  +----------------------+---------------------+----------------------+---------------------+---- ---+--------------------------------+
  ```

  You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  By default, information about transactions is displayed in text format. To get more details, specify `yaml` or `json` for the output data using the `--format` argument:

  ```bash
  yc managed-sharded-postgresql cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: c9q2m9jrootm********
    description: Add shard to SPQR cluster
    created_at: "2025-12-11T09:14:15.564589Z"
    created_by: ajej2i98kcjd********
    modified_at: "2025-12-11T09:15:20.619684Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.spqr.v1.AddClusterShardMetadata
      cluster_id: c9qk2926qqu9********
      shard_name: shard2
    response:
      '@type': type.googleapis.com/yandex.cloud.mdb.spqr.v1.Shard
      name: shard2
      cluster_id: c9qk2926qqu9********
  ...
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/operations'
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.spqr.v1.ListClusterOperationsResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.ListOperations
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.spqr.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

### Getting operation details {#get-operations-info}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get detailed information about an operation, run this command:

    ```bash
    yc operation get <operation_ID>
    ```

    You can get the operation ID with the [list of operations](#get-operations) for the cluster.

    Here is an example of an output for the completed cluster creation operation:

    ```text
    id: e4umughncjh0msa6cbfi
    description: Create SPQR cluster
    created_at: "2026-03-10T16:43:46.013971Z"
    created_by: ajefhe0o8uas********
    modified_at: "2026-03-10T16:51:08.736844Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.spqr.v1.CreateClusterMetadata
      cluster_id: c9qheabu83os********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
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

        You can get the operation ID with the [list of operations](#get-operations) for the cluster.

    1. Check the [server response](../api-ref/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

        You can get the operation ID with the [list of operations](#get-operations) for the cluster.

    1. Check the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

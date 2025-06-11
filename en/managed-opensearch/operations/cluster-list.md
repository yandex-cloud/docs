---
title: Information about existing {{ OS }} clusters
description: You can request detailed information about each {{ OS }} cluster you created.
keywords:
  - Information about OpenSearch hosts
  - OpenSearch hosts
  - OpenSearch
---

# Information about existing {{ OS }} clusters

You can request detailed information about each {{ mos-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ OS }} clusters in the default folder, run this command:

  ```bash
  {{ yc-mdb-os }} cluster list
  ```

  ```text
  +----------------------+------+-----------------------------+--------+---------+
  |          ID          | NAME |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | myos | 2023-12-19T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                          |
  +----------------------+------+-----------------------------+--------+---------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.list](../api-ref/Cluster/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters' \
          --url-query folderId=<folder_ID>
      ```

      
      You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.List](../api-ref/grpc/Cluster/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.List
      ```

      
      You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about the {{ OS }} cluster, run the following command:

  ```bash
  {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
  ```

  You can request the cluster name and ID with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Get](../api-ref/Cluster/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>'
      ```

      You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.Get
      ```

      You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mos-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of operations for a cluster:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Select the cluster.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

      You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mos-name }} cluster, run this command:

  ```bash
  yc managed-opensearch cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |        DESCRIPTION        |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  | dqh0ntf6batm******** | 2024-09-07 16:36:46 | aje9k8luj4qf******** | 2024-09-07 16:44:12 | DONE   | Create OpenSearch cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+---------------------------+
  ```

  You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

  By default, operation information is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter:

  ```bash
  yc managed-opensearch cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: dqh0ntf6batm********
    description: Create OpenSearch cluster
    created_at: "2024-09-07T16:36:46.816682Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:12.944302Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata
      cluster_id: c9q13q0acgv7********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/operations'
      ```

      You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.ListOperations
      ```

      You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse) to make sure the request was successful.

{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get a list of operations](#get-operations) for a cluster.
1. Copy the operation ID.
1. Get operation details:

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
      id: dqh0ntf6batm********
      description: Create OpenSearch cluster
      created_at: "2024-09-07T16:36:46.816682Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-09-07T16:44:12.944302Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata
        cluster_id: c9q13q0acgv7********
      response:
        '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.Cluster
      ...
      ```

    - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Use the [Operation.Get](../api-ref/Operation/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-operation }}/operations/<operation_ID>'
          ```

      1. View the [server response](../api-ref/Operation/get.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    - gRPC API {#grpc-api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

         {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
      1. Use the [OperationService.Get](../api-ref/grpc/Operation/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      1. View the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

---
title: Information about existing {{ OS }} clusters
description: You can get detailed information about each {{ OS }} cluster you created.
keywords:
  - Information about OpenSearch hosts
  - OpenSearch hosts
  - OpenSearch
---

# Information about existing {{ OS }} clusters

You can get detailed information about each {{ mos-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ OS }} clusters in the default folder, run this command:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.List](../api-ref/Cluster/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters' \
          --url-query folderId=<folder_ID>
      ```

      
      You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.List](../api-ref/grpc/Cluster/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      
      You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about an {{ OS }} cluster, run this command:

  ```bash
  {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
  ```

  You can get the cluster name and ID with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mos-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of operations for a cluster:

  1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Select the cluster you need.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the cluster you selected.

      You will see the list of operations with this cluster.

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

  You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using `--format`:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/operations'
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.opensearch.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

### Getting operation details {#get-operations-info}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate to the list of operations for your cluster](#get-operations).
    1. Click the ID of the operation you need.

    {% include [operation-details](../../_includes/mdb/console/operation-details.md) %}

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
    id: mos05eskhu9c********
    description: Create OpenSearch cluster
    created_at: "2025-12-29T02:29:51.793062Z"
    created_by: ajefhe0o8uas********
    modified_at: "2025-12-29T02:43:23.309182Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.CreateClusterMetadata
      cluster_id: c9q4g9irv5mc********
      operation_log:
        entities:
          - cluster_id: c9q4g9irv5mc********
            action: Preparing metadata
            started_at: "2025-12-29T02:29:53.865371Z"
          - cluster_id: c9q4g9irv5mc********
            action: Preparing backup storage
            started_at: "2025-12-29T02:29:56.453900Z"
          - cluster_id: c9q4g9irv5mc********
            action: Creating cluster
            started_at: "2025-12-29T02:30:15.668070Z"
            hosts:
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:18.033652Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:21.229073Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:25.193509Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T02:30:32.402818Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:38.915704Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:40.253821Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:41.492932Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T02:30:42.740551Z"
          - cluster_id: c9q4g9irv5mc********
            action: Installing software
            started_at: "2025-12-29T02:33:15.769930Z"
            hosts:
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:15.962886Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:16.190931Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:16.397641Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T02:33:26.602596Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:26.955555Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.164688Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.372229Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:33:27.584061Z"
          - cluster_id: c9q4g9irv5mc********
            action: Initializing database
            started_at: "2025-12-29T02:35:52.445284Z"
          - cluster_id: c9q4g9irv5mc********
            action: Infrastructure integration
            started_at: "2025-12-29T02:41:14.794423Z"
            hosts:
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.073269Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.328852Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.578930Z"
              - fqdn: rc1a-fohc5nvj********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T02:41:15.837808Z"
              - fqdn: rc1a-r74k9d6q********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.297788Z"
              - fqdn: rc1b-dpb2qtc7********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.514965Z"
              - fqdn: rc1d-h86ujdc3********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T02:41:24.724648Z"
    response:
      '@type': type.googleapis.com/yandex.cloud.mdb.opensearch.v1.Cluster
      id: c9q4g9irv5mc********
      ...
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

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

    1. View the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

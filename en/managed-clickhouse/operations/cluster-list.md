---
title: Information about clusters in {{ mch-short-name }}
description: You can request detailed information about each {{ mch-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mch-name }}.
---

# Information about existing {{ CH }} clusters

You can request detailed information about each {{ mch-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ CH }} clusters in the default folder, run the command:

  ```
  {{ yc-mdb-ch }} cluster list

  +----------------------+------+-------------+---------+---------------------+--------+---------+
  |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
  | ...                                                                                          |
  +----------------------+------+-------------+---------+---------------------+--------+---------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.list](../api-ref/Cluster/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
        --url-query folderId=<folder_ID>
      ```


      You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.clickhouse.v1.ListClustersResponse) to make sure the request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.List
      ```


      You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.clickhouse.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about the {{ CH }} cluster, run the following command:

  ```
  {{ yc-mdb-ch }} cluster get <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Get](../api-ref/Cluster/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>'
      ```

      You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster) to make sure the request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Get
      ```

      You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mch-name }} clusters are logged as a list of operations. Each operation is assigned a unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ mch-name }} clusters, in the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.clickhouse.switch_operations }}**. In the list that opens, you will also see operations with the resources that were deleted.

  You can get a list of operations for a cluster:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.clickhouse.switch_list }}**.
  1. Select the cluster you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.clickhouse.switch_operations }}** panel for the selected cluster.

     You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mch-name }} cluster, run this command:

  ```bash
  yc managed-clickhouse cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c5m7ll6pq3j8******** | 2024-08-08 19:05:42 | mdb-maintainer       | 2024-08-15 19:20:05 | DONE   | Modify ClickHouse cluster      |
  | c5mb0no66172******** | 2024-06-19 12:48:40 | mdb-maintainer       | 2024-06-26 12:50:14 | DONE   | Modify ClickHouse cluster      |
  | c5m9hvmb3lg9******** | 2024-01-17 08:05:16 | ajeef73j5iq9******** | 2024-01-17 08:14:59 | DONE   | Add ZooKeeper to ClickHouse    |
  |                      |                     |                      |                     |        | cluster                        |
  | c5mniao7leml******** | 2023-11-13 19:34:54 | ajeef73j5iq9******** | 2023-11-13 19:35:10 | DONE   | Update user in ClickHouse      |
  |                      |                     |                      |                     |        | cluster                        |
  | c5m6of9he7op******** | 2023-11-13 19:25:21 | ajeef73j5iq9******** | 2023-11-13 19:32:00 | DONE   | Create ClickHouse cluster      |
  +----------------------+---------------------+----------------------+---------------------+---- ---+--------------------------------+
  ```

  You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters) in the folder.

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc managed-clickhouse cluster list-operations epdplu8jn7sr******** --format yaml
  ```

  Result:

  ```text
  - id: c5m7ll6pq3j8********
    description: Modify ClickHouse cluster
    created_at: "2024-08-08T19:05:42.362668Z"
    created_by: mdb-maintainer
    modified_at: "2024-08-15T19:20:05.917268Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata
      cluster_id: c9q7vuuoiqml********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ...
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/operations'
      ```

      You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.clickhouse.v1.ListClusterOperationsResponse) to make sure the request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.ListOperations
      ```

      You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.clickhouse.v1.ListClusterOperationsResponse) to make sure the request was successful.

{% endlist %}

### Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for a cluster.
1. Copy the operation ID.
1. Get detailed information about the operation:

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
      id: c5m6of9he7op********
      description: Create ClickHouse cluster
      created_at: "2023-11-13T19:25:21.762164Z"
      created_by: ajeef73j5iq9********
      modified_at: "2023-11-13T19:32:00.464591Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata
        cluster_id: c9q7vuuoiqml********
      response:
        '@type': type.googleapis.com/yandex.cloud.mdb.clickhouse.v1.Cluster
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

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

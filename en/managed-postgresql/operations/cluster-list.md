---
title: Information about clusters in {{ mpg-short-name }}
description: You can request detailed information for each {{ mpg-short-name }} cluster you have created. To get a list of database clusters in a folder, navigate to the folder dashboard and go to {{ mpg-name }}.
---

# Getting information about existing {{ PG }} clusters

You can request detailed information for each {{ mpg-short-name }} cluster you have created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ PG }} clusters in the default folder, run this command:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.List](../api-ref/Cluster/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
       --url-query folderId=<folder_ID>
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.postgresql.v1.ListClustersResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.List
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.postgresql.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get {{ PG }} cluster details, run the following command:

  ```bash
  {{ yc-mdb-pg }} cluster get <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Get
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mpg-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ mpg-name }} clusters, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.postgresql.switch_operations }}** in the left-hand panel. In the list that opens, you will also see operations for the deleted resources.

  You can get a list of cluster operations as follows:

  1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.postgresql.switch_list }}**.
  1. Select your cluster.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.postgresql.switch_operations }}** panel for the cluster you selected.

     You will see a list of operations with the cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mpg-name }} cluster, run this command:

  ```bash
  yc managed-postgresql cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c5m7ll6pq3j8******** | 2024-08-08 19:05:42 | mdb-maintainer       | 2024-08-15 19:20:05 | DONE   | Modify PostgreSQL cluster      |
  | c5mb0no66172******** | 2024-06-19 12:48:40 | mdb-maintainer       | 2024-06-26 12:50:14 | DONE   | Modify PostgreSQL cluster      |
  | c5m6of9he7op******** | 2023-11-13 19:25:21 | ajeef73j5iq9******** | 2023-11-13 19:32:00 | DONE   | Create PostgreSQL cluster      |
  +----------------------+---------------------+----------------------+---------------------+---- ---+--------------------------------+
  ```

  You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using `--format`:

  ```bash
  yc managed-postgresql cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: c9q2m9jrootm********
    description: Create PostgreSQL cluster
    created_at: "2024-08-06T06:38:13.724389Z"
    created_by: ajej2i98kcjd********
    modified_at: "2024-08-06T06:46:33.101402Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata
      cluster_id: c9qk2926qqu9********
  ...
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/operations'
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.postgresql.v1.ListClusterOperationsResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListOperations
     ```

     You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.postgresql.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

### Getting operation details {#get-operations-info}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate to the list of all cluster operations or operations for your specific cluster](#get-operations).
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
    id: c9qvtaeael629vooobjn
    description: Create PostgreSQL cluster
    created_at: "2025-12-29T01:00:10.342661Z"
    created_by: ajefhe0o8uas********
    modified_at: "2025-12-29T01:10:42.927393Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata
      cluster_id: c9qheabu83os********
      operation_log:
        entities:
          - cluster_id: c9qheabu83os********
            action: Preparing metadata
            started_at: "2025-12-29T01:00:12.962815Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Preparing host
                started_at: "2025-12-29T01:00:14.133616Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Preparing host
                started_at: "2025-12-29T01:00:14.355756Z"
          - cluster_id: c9qheabu83os********
            action: Preparing backup storage
            started_at: "2025-12-29T01:00:16.219396Z"
          - cluster_id: c9qheabu83os********
            action: Creating cluster
            started_at: "2025-12-29T01:00:29.106594Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T01:00:31.926872Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Reserving resources
                started_at: "2025-12-29T01:00:40.139058Z"
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T01:00:46.710067Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Creating host
                started_at: "2025-12-29T01:00:48.757701Z"
          - cluster_id: c9qheabu83os********
            action: Installing software
            started_at: "2025-12-29T01:01:48.454943Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T01:02:08.738499Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Launching host
                started_at: "2025-12-29T01:02:18.973229Z"
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T01:02:19.329133Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Updating database software
                started_at: "2025-12-29T01:02:19.557436Z"
          - cluster_id: c9qheabu83os********
            action: Initializing database
            started_at: "2025-12-29T01:05:20.261791Z"
          - cluster_id: c9qheabu83os********
            action: Infrastructure integration
            started_at: "2025-12-29T01:10:33.044048Z"
            hosts:
              - fqdn: rc1b-3mrj18nj********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T01:10:33.306624Z"
              - fqdn: rc1d-qsor0ftm********.mdb.yandexcloud.net
                action: Creating DNS records
                started_at: "2025-12-29T01:10:33.595051Z"
    response:
      '@type': type.googleapis.com/yandex.cloud.mdb.postgresql.v1.Cluster
      id: c9qheabu83os********
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

    1. Check the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

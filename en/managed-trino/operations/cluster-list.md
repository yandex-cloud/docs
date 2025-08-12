---
title: Getting information about {{ mtr-name }} clusters
description: You can request detailed information about each {{ mtr-name }} cluster you created. To get a list of clusters in a folder, go to the folder dashboard and select {{ mtr-name }}.
---

# Getting information on existing {{ mtr-name }} clusters

You can request detailed information about each {{ mtr-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To request a list of {{ mtr-name }} clusters in the default folder, run the command:

    ```bash
    {{ yc-mdb-tr }} cluster list
    ```

    Result:

    ```bash
    +----------------------+----------+---------------------+--------+---------+
    |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
    +----------------------+----------+---------------------+--------+---------+
    | c9qsfvqeio90******** | my-trino | 2025-06-02 05:25:20 | ALIVE  | RUNNING |
    +----------------------+----------+---------------------+--------+---------+
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.list](../api-ref/Cluster/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters' \
            --url-query folderId=<folder_ID>
        ```

        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.trino.v1.ListClustersResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/List](../api-ref/grpc/Cluster/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "folder_id": "<folder_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.List
        ```

        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.trino.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about the {{ mtr-name }} cluster, run the following command:

    ```bash
    {{ yc-mdb-tr }} cluster get <cluster_name_or_ID>
    ```

    You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.get](../api-ref/Cluster/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.trino.v1.Cluster) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Get
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.trino.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mtr-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ mtr-name }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the appropriate cluster.
    1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the cluster you selected.

        You will see a list of operations with the cluster you selected.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of operations for a {{ mtr-name }} cluster, run this command:

    ```bash
    {{ yc-mdb-tr }} cluster list-operations <cluster_name_or_ID>
    ```

    Result:

    ```bash
    +----------------------+---------------------+----------------------+---------------------+--------+------------------------------+
    |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |         DESCRIPTION          |
    +----------------------+---------------------+----------------------+---------------------+--------+------------------------------+
    | trc854fqfa8t******** | 2025-06-02 05:25:20 | ajejut7dk2dp******** | 2025-06-02 05:28:57 | DONE   | Create Managed Trino cluster |
    +----------------------+---------------------+----------------------+---------------------+--------+------------------------------+
    ```

    You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

    By default, information about operations is displayed as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter. Here is an example:

    ```bash
    {{ yc-mdb-tr }} cluster list-operations <cluster_name_or_ID> --format yaml
    ```

    Result:

    ```yaml
    - id: trc854fqfa8t********
      description: Create Managed Trino cluster
      created_at: "2025-06-02T05:25:20.147498Z"
      created_by: ajejut7dk2dp********
      modified_at: "2025-06-02T05:28:57.284775Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.trino.v1.CreateClusterMetadata
        cluster_id: trc854fqfa8t********
    ...
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.listOperations](../api-ref/Cluster/listOperations.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/operations'
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.trino.v1.ListClusterOperationsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.ListOperations
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.trino.v1.ListClusterOperationsResponse) to make sure the request was successful.

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
        id: trcippp3rvn7********
        description: Update Managed Trino cluster
        created_at: "2025-06-11T10:36:37.278776Z"
        created_by: ajejut7dk2dp********
        modified_at: "2025-06-11T10:36:37.278776Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.trino.v1.UpdateClusterMetadata
          cluster_id: c9q3jaob16gp********
        response:
          '@type': type.googleapis.com/yandex.cloud.trino.v1.Cluster
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

## See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

---
title: Information about clusters in {{ myt-name }}
description: You can get detailed information about each {{ ytsaurus-name }} cluster you created. To get a list of clusters in a folder, go to the folder dashboard and select {{ myt-name }}.
---

# Information about existing clusters

You can get detailed information about each {{ ytsaurus-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ ytsaurus-name }} clusters in the default folder, run this command:

    ```bash
    {{ yc-ytsaurus }} cluster list
    ```

    Result:

    ```bash
    +----------------------+---------------------+---------------+----------------------+---------------------+---------+
    |          ID          |        NAME         |    ZONE ID    |      SUBNET ID       |     CREATED AT      | STATUS  |
    +----------------------+---------------------+---------------+----------------------+---------------------+---------+
    | cnkvtb40gk87******** | my-ytsaurus-cluster | ru-central1-a | e9bp8qmchqh28******* | 2025-10-06 11:07:44 | RUNNING |
    +----------------------+---------------------+---------------+----------------------+---------------------+---------+
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.List](../api-ref/Cluster/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters' \
            --url-query folderId=<folder_ID>
        ```

        You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.ytsaurus.v1.ListClustersResponse) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "folder_id": "<folder_ID>"
                }' \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.List
        ```

        You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. Check the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.ytsaurus.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Click the cluster name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about an {{ ytsaurus-name }} cluster, run the following command:

    ```bash
    {{ yc-ytsaurus }} cluster get <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters/<cluster_ID>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.ytsaurus.v1.Cluster) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Get
        ```

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.ytsaurus.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing cluster operations {#list-operations}

All actions with {{ ytsaurus-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ ytsaurus-name }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the cluster you need.
    1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the cluster you selected.

       You will see the list of operations with this cluster.


{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get the cluster operation list](#get-operations).
1. Copy the ID of the required operation.
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

        ```bash
        id: b9k4900r7k**********
        description: Create cluster
        created_at: "2025-07-11T14:17:29.915505Z"
        created_by: ajeuoi52dg**********
        modified_at: "2025-07-11T15:12:44.572840Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.CreateClusterMetadata
          cluster_id: cnkgf75gu***********
        response:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.Cluster
          ...
        ```

    - REST API {#api}

        1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

            {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

        1. Use the [Operation.Get](../api-ref/Operation/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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



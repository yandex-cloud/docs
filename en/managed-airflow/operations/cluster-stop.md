---
title: Stopping and starting an {{ AF }} cluster
description: You can stop and restart a {{ AF }} DB cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.
---

# Stopping and starting an {{ AF }} cluster

You can stop and restart an {{ AF }} cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Find the cluster in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
    1. In the dialog box that opens, confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To stop a cluster, run the command:

    ```bash
    {{ yc-mdb-af }} cluster stop <cluster_name_or_ID>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.stop](../api-ref/Cluster/stop.md) method to make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<cluster_ID>:stop'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/stop.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Stop](../api-ref/grpc/Cluster/stop.md) call to make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-airflow }}:{{ port-https }} \
            yandex.cloud.airflow.v1.ClusterService.Stop
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart clusters with the `Stopped` status.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Find the stopped cluster in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To start a cluster, run the command:

    ```bash
    {{ yc-mdb-af }} cluster start <cluster_name_or_ID>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.start](../api-ref/Cluster/start.md) method to make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<cluster_ID>:start'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/start.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Start](../api-ref/grpc/Cluster/start.md) call to make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-airflow }}:{{ port-https }} \
            yandex.cloud.airflow.v1.ClusterService.Start
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

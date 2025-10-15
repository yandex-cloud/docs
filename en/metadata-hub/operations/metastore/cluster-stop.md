---
title: How to stop and start a {{ metastore-full-name }} cluster
description: Follow this guide to learn how to stop and start a {{ metastore-full-name }} cluster.
---

# Stopping and starting an {{ metastore-full-name }} cluster

You can stop and restart an {{ metastore-name }} cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to stop a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. Confirm stopping the cluster.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To stop a {{ metastore-name }} cluster, run the command:

  ```bash
  {{ yc-metastore }} cluster stop <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Stop](../../api-ref/Cluster/stop.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>:stop'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/Cluster/stop.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Stop](../../api-ref/grpc/Cluster/stop.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Stop
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/Cluster/stop.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting a {#stop-cluster} cluster

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to start a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. Confirm starting the cluster.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To start a {{ metastore-name }} cluster, run this command:

  ```bash
  {{ yc-metastore }} cluster start <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Start](../../api-ref/Cluster/start.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>:start'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/Cluster/start.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Start](../../api-ref/grpc/Cluster/start.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Start
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/Cluster/start.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}

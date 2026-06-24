---
title: Stopping and starting a {{ MY }} cluster in {{ mmy-name }}
description: You can stop and restart an {{ MY }} cluster as needed. While your cluster is idle, you only pay for the size of your storage and backups.
---

# Stopping and starting a {{ MY }} cluster

If necessary, you can stop and restart your {{ MY }} cluster. While your cluster is idle, you only pay for the size of your storage and backups as per the [pricing policy](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% note info %}

Stopping a cluster is not allowed if it has no backups. In order to stop it, you must [create its backup](cluster-backups.md#create-backup) first.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Locate the cluster you need in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. Confirm that you want to stop the cluster by clicking **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for stopping a cluster:

        ```bash
        {{ yc-mdb-my }} cluster stop --help
        ```

    1. To get the cluster ID and name, request the list of clusters in the folder:

        ```bash
        {{ yc-mdb-my }} cluster list
        ```

    1. To stop the cluster, run this command:

        ```bash
        {{ yc-mdb-my }} cluster stop <cluster_name_or_ID>
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.stop](../api-ref/Cluster/stop.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:stop'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/stop.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService/Stop](../api-ref/grpc/Cluster/stop.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.Stop
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart a cluster if its status is **STOPPED**.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. In the list, locate the stopped cluster you want to restart, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. In the dialog box that opens, click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}** to confirm the cluster launch.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for starting a cluster:

        ```bash
        {{ yc-mdb-my }} cluster start --help
        ```

    1. To get the cluster ID and name, request the list of clusters in the folder:

        ```bash
        {{ yc-mdb-my }} cluster list
        ```

    1. To start the cluster, run this command:

        ```bash
        {{ yc-mdb-my }} cluster start <cluster_name_or_ID>
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.start](../api-ref/Cluster/start.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:start'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/start.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService/Start](../api-ref/grpc/Cluster/start.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.Start
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

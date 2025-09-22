---
title: Information about clusters in {{ msp-full-name }}
description: You can request detailed information about each {{ SPRK }} cluster you created. To get a list of clusters in a folder, go to the folder page and select {{ msp-full-name }}.
---

# Information about existing clusters

You can request detailed information about each {{ SPRK }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.

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
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                  "folder_id": "<folder_ID>"
              }' \
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.List
           ```
       
       You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       
    1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.spark.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name.

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
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                   "cluster_id": "<cluster_ID>"
               }' \
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.Get
       ```

       You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.spark.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ SPRK }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ SPRK }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the cluster.
    1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

        You will see a list of operations with the selected cluster.

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
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                   "cluster_id": "<cluster_ID>"
               }' \
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.ListOperations
       ```

       You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.spark.v1.ListClusterOperationsResponse) to make sure the request was successful.

{% endlist %}

## See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

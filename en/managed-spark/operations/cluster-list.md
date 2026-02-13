---
title: Information about clusters in {{ msp-full-name }}
description: You can request detailed information for each {{ SPRK }} cluster you have created. To get a list of clusters in a folder, go to the folder dashboard and select {{ msp-full-name }}.
---

# Information about existing clusters

You can get detailed information about each {{ SPRK }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ SPRK }} clusters in the default folder, run this command:

    ```bash
    {{ yc-mdb-sp }} cluster list
    ```

    Result:

    ```bash
    +----------------------+----------+---------------------+--------+---------+
    |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
    +----------------------+----------+---------------------+--------+---------+
    | c9qmm2mrse2g******** | my-spark | 2026-01-22 13:23:32 | ALIVE  | RUNNING |
    +----------------------+----------+---------------------+--------+---------+
    ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/List](../api-ref/grpc/Cluster/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
       
       You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       
    1. Check the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.spark.v1.ListClustersResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get {{ SPRK }} cluster details, run the following command:

    ```bash
    {{ yc-mdb-sp }} cluster get <cluster_name_or_ID>
    ```

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

       You can get the cluster ID from the [list of clusters in your folder](#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.spark.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ SPRK }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ SPRK }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the cluster.
    1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the cluster you selected.

        You will see the list of operations with this cluster.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of operations for an {{ SPRK }} cluster, run this command:

    ```bash
    {{ yc-mdb-sp }} cluster list-operations <cluster_name_or_ID>
    ```

    Result:

    ```bash
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |         DESCRIPTION         |
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    | msc53bmphhmc******** | 2026-01-22 13:23:32 | ajegrmkclceh******** | 2026-01-22 13:27:22 | DONE   | Create Apache Spark cluster |
    +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
    ```

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` parameter. For example:

    ```bash
    {{ yc-mdb-sp }} cluster list-operations <cluster_name_or_ID> --format yaml
    ```

    Result:

    ```yaml
    - id: msc53bmphhmc********
      description: Create Apache Spark cluster
      created_at: "2026-01-22T13:23:32.748783Z"
      created_by: ajegrmkclceh********
      modified_at: "2026-01-22T13:27:22.336712Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.spark.v1.CreateClusterMetadata
        cluster_id: c9qmm2mrse2g********
        ...
    ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

       You can get the cluster ID from the [list of clusters in your folder](#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.spark.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

## See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

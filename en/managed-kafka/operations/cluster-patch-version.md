---
title: How to get the {{ KF }} patch version in {{ mkf-full-name }}
description: Follow this guide to find out the {{ KF }} patch version installed in a {{ mkf-full-name }} cluster.
---

# Getting the {{ KF }} patch version

To find out the {{ KF }} patch version installed in a {{ mkf-name }} cluster, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}** service.
  1. Find the **{{ ui-key.yacloud.mdb.cluster.overview.label_version }}** field containing the {{ KF }} version and patch version info.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get {{ KF }} cluster details, run the following command:
  
    ```
    {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
    ```

    Result:

    ```text
    id: c9q8d856r3nt********
    folder_id: b1gurba83v2i********
    created_at: "2025-06-16T10:57:42.582559Z"
    name: kafka947
    environment: PRODUCTION
    ...
    config:
      version: "3.6"
      kafka:
        resources:
          resource_preset_id: s3-c2-m8
          disk_size: "34359738368"
          disk_type_id: network-ssd
    ...
      rest_api_config:
        enabled: true
      kafka_ui_config:
        enabled: true
      patch_version: 3.6.1
    ...
    ```

    Where `patch_version` is the {{ KF }} patch version.

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

  1. Find the `patchVersion` field the server response.

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
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.Get
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

  1. Find the `patch_version` field the server response.

{% endlist %}


---
title: How to get the {{ CH }} patch version in {{ mch-full-name }}
description: Follow this guide to find out the {{ CH }} patch version installed in a {{ mch-full-name }} cluster.
---

# Getting the {{ CH }} patch version

To find out the {{ CH }} patch version installed in a {{ mch-name }} cluster, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}** service.
  1. Find the **{{ ui-key.yacloud.mdb.cluster.overview.label_version }}** field containing the {{ CH }} version and patch version info.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get {{ CH }} cluster details, run the following command:
  
    ```
    {{ yc-mdb-ch }} cluster get <cluster_name_or_ID>
    ```

    Result:

    ```text
    id: c9qvtmpmm3tc********
    folder_id: b1gurba83v2i********
    created_at: "2026-01-28T10:34:21.456105Z"
    name: clickhouse677
    environment: PRODUCTION
    ...
    config:
      version: "25.11"
      clickhouse:
        config:
          user_config:
            merge_tree: {}
        resources:
          resource_preset_id: s3-c2-m8
          disk_size: "10737418240"
          disk_type_id: network-ssd
        disk_size_autoscaling: {}
      zookeeper:
        resources: {}
        disk_size_autoscaling: {}
      ...
      backup_retain_period_days: "7"
      full_version: 25.11.6.11
      ...
    ```

    Where `full_version` is the full {{ CH }} version with its patch version specified.

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster) to make sure your request was successful.

  1. Find the `fullVersion` field the server response.

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
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Get
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.clickhouse.v1.Cluster) to make sure your request was successful.

  1. Find the `full_version` field the server response.

{% endlist %}

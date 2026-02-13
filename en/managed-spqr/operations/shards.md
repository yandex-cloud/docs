---
title: Managing {{ SPQR }} shards
description: Follow this guide to create shards in a {{ mspqr-name }} cluster.
keywords:
  - keyword: managing shards in {{ SPQR }}
  - keyword: creating a shard in {{ SPQR }}
  - '{{ SPQR }}'
---

# Managing {{ SPQR }} shards

{% include [preview](../../_includes/note-service-preview.md) %}

## Creating a shard {#create-shard}

{{ mpg-full-name }} shards are based on existing {{ mpg-name }} clusters residing in the same folder and cloud network as the {{ SPQR }} cluster.


{% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
    1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
    1. Specify a shard name and select the {{ PG }} cluster whose hosts will serve as data hosts in the {{ SPQR }} cluster.
    1. Click **Create**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.AddShard](../api-ref/Cluster/addShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/shards' \
       --data '{
                 "shardSpec": {
                   "shardName": "<shard_name>",
                   "mdbPostgresql": {
                     "clusterId": "<{{ PG }}_cluster_ID>"
                   }
                 }
               }'
     ```

     Where `mdbPostgresql.clusterId` is the {{ mpg-name }} cluster ID within the shard.

  1. Check the [server response](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <cluster_ID>
             "shard_spec": {
               "shard_name": "<shard_name>",
               "mdb_postgresql": {
                 "cluster_id": "<{{ PG }}_cluster_ID>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.AddShard
     ```

     Where `mdb_postgresql.cluster_id` is the {{ mpg-name }} cluster ID within the shard.

{% endlist %}

## Deleting a shard {#delete-shard}

Deleting a {{ SPQR }} shard does not affect the {{ mpg-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
    1. Find the shard you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/shards/<shard_name>'
     ```

  1. Check the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <cluster_ID>,
             "shard_name": "<shard_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.DeleteShard
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

---
title: Deleting a {{ SPQR }} cluster
description: You can delete an {{ SPQR }} cluster if you no longer need it.
keywords:
  - keyword: deleting {{ SPQR }} cluster
  - keyword: '{{ SPQR }} cluster'
  - keyword: '{{ SPQR }}'
---

# Deleting an {{ SPQR }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

You can delete an {{ SPQR }} cluster if you no longer need it.

## Deleting a cluster {#delete}

Before deleting a cluster, disable its deletion protection if it is enabled.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster in question and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Delete](../api-ref/Cluster/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>'
     ```

  1. View the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <cluster_ID>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Delete
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

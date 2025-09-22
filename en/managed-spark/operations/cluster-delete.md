---
title: Deleting a {{ SPRK }} cluster
description: You can delete an {{ SPRK }} cluster if you no longer need it.
keywords:
  - deleting an {{ SPRK }} cluster
---

# Deleting a {{ SPRK }} cluster

You can delete an {{ SPRK }} cluster if you no longer need it.

## Deleting a cluster {#delete}

Before deleting a cluster, disable its deletion protection if it is enabled.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:
  
     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Use the [ClusterService/Delete](../api-ref/grpc/Cluster/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:
  
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
         yandex.cloud.spark.v1.ClusterService.Delete
     ```
  
     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. View the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

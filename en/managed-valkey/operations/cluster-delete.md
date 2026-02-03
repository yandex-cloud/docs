---
title: Deleting a {{ VLK }} cluster
description: After you delete a {{ VLK }} database cluster, its backups are retained and available for recovery for 7 days. To restore a deleted cluster from a backup, you will need its ID. Therefore, make sure to save the cluster ID safely before deletion.
---

# Deleting a {{ VLK }} cluster

## Before deleting a cluster {#before-you-delete}

* If deletion protection is on for the cluster, [disable it](update.md#change-additional-settings).
* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), go to the folder with the cluster you want to delete.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, check **Delete cluster** and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a cluster, run this command:
  
  ```bash
  {{ yc-mdb-rd }} cluster delete <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

    {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Delete](../api-ref/Cluster/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Delete
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

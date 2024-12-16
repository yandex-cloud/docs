---
title: Deleting a {{ RD }} cluster
description: After you delete a {{ RD }} database cluster, its backups are kept for seven days for recovery purposes. To restore a deleted cluster from a backup you will need its ID; therefore, make sure the cluster ID is secure before deleting the cluster.
---

# Deleting a {{ RD }} cluster

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), go to the folder to delete the cluster from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. In the line of the appropriate cluster, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, check **Delete cluster** and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a cluster, run the command:
  
  ```bash
  {{ yc-mdb-rd }} cluster delete <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

    {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Delete](../api-ref/Cluster/delete.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

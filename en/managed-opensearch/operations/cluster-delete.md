---
title: Deleting an {{ OS }} cluster
description: You can delete an {{ OS }} cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the folder you want to delete a cluster from.
keywords:
  - Creating an OpenSearch cluster
  - OpenSearch cluster
  - OpenSearch
---

# Deleting an {{ OS }} cluster

You can delete an {{ OS }} cluster if you no longer need it. All data in the cluster will be deleted.

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster you need and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. Confirm cluster deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run the command:

  ```bash
  {{ yc-mdb-os }} cluster delete <cluster_name_or_ID>
  ```

  You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Delete](../api-ref/Cluster/delete.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>'
      ```

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
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.Delete
      ```

  1. View the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

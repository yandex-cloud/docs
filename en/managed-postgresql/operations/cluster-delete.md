---
title: Deleting a PostgreSQL cluster
description: After you delete a PostgreSQL database cluster, its backups are retained and can be used for recovery for seven days. To restore a deleted cluster from a backup, you will need its ID. Therefore, be sure to securely save the cluster ID prior to deletion.
---

# Deleting a {{ PG }} cluster

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

{% note warning %}

Deleting a cluster will permanently remove all its users and databases, including those with deletion protection.

{% endnote %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster you want to remove, select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**, and confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run this command:

  ```bash
  {{ yc-mdb-pg }} cluster delete <cluster_name_or_ID>
  ```

  You can get the cluster name and ID from the [folder’s cluster list](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Delete](../api-ref/Cluster/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Delete
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

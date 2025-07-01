---
title: Deleting an Elasticsearch cluster
description: You can delete an Elasticsearch cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the folder you want to delete a cluster from.
keywords:
  - creating an Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch
---

# Deleting an {{ ES }} cluster

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can delete an {{ ES }} cluster if you no longer need it. All data in the cluster will be deleted.

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](cluster-update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
  1. Select **Managed Service for&nbsp;Elasticsearch**.
  1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon for the required cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a cluster, run the command:

  ```bash
  {{ yc-mdb-es }} cluster delete <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  To delete a cluster, use the [delete](../api-ref/Cluster/delete.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Delete](../api-ref/grpc/Cluster/delete.md) gRPC API call and provide the ID of the cluster to delete in the `clusterId` request parameter.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}
---
title: "Deleting a Redis cluster"
description: "After you delete a Redis database cluster, its backups are kept for seven days for recovery purposes. To restore a deleted cluster from its backup, you will need its ID; therefore, securely save the cluster ID before deleting the cluster."
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

   ```
   {{ yc-mdb-rd }} cluster delete <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

   To delete a cluster, use the [delete](../api-ref/Cluster/delete.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) gRPC API call and provide the ID of the cluster to be deleted in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

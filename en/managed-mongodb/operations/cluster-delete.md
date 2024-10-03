---
title: Deleting a MongoDB cluster
description: After you delete a MongoDB database cluster, its backups are kept for seven days for recovery purposes. To restore a deleted cluster from a backup you will need its ID; therefore, make sure the cluster ID is secure before deleting the cluster.
---

# Deleting a {{ MG }} cluster

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md#change-additional-settings) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Open the [folder page]({{ link-console-main }}) in the management console.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the relevant cluster and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a cluster, run the command:
  
  ```bash
  {{ yc-mdb-mg }} cluster delete <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API {#api}

  To delete a cluster, use the [delete](../api-ref/Cluster/delete.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Delete](../api-ref/grpc/cluster_service.md#Delete) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

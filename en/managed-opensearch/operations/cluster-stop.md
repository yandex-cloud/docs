---
title: "Stopping and starting {{ OS }} clusters"
description: "If necessary, you can stop and restart an {{ OS }} cluster. When a cluster is stopped, all data in it is retained. It will be available again when you restart the cluster."
keywords:
  - Stopping OpenSearch
  - Starting OpenSearch
  - OpenSearch
---

# Stopping and starting {{ OS }} clusters

You can stop and restart {{ OS }} clusters, if required. When a cluster is stopped, all data in it is retained and will be available again when you restart the cluster.


You are not charged for the time when your cluster is stopped; however, you still have to pay for the storage size based on the [pricing policy](../pricing.md).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Stopping a cluster {#stop}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Find the cluster you need in the list, click the ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
   1. In the dialog box that opens, confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- API {#api}

   To stop a cluster, use the [stop](../api-ref/Cluster/stop.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Starting a cluster {#start}

You can restart **STOPPED** clusters.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Find the stopped cluster you need in the list, click the ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
   1. In the dialog box that opens, confirm that you want to start the cluster and click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- API {#api}

   To start a cluster, use the [start](../api-ref/Cluster/start.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

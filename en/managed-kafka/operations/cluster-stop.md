# Stopping and starting {{ KF }} clusters

You can stop and restart {{ KF }} clusters, if required. When a cluster is stopped, all data in it is retained and will be available again when you restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Find the cluster you need in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
   1. In the dialog box that opens, confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster stop <cluster_name_or_ID>
   ```


- API {#api}

   To stop a cluster, use the [stop](../api-ref/Cluster/stop.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}

## Starting a cluster {#start-cluster}

You can restart `STOPPED` clusters.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Find the stopped cluster you need in the list, click the ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster start <cluster_name_or_ID>
   ```


- API {#api}

   To start a cluster, use the [start](../api-ref/Cluster/start.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}

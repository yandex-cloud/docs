# Stopping and starting a {{ RD }} cluster

You can stop and restart a DB cluster, if required. You are not charged while your cluster is stopped: you continue to pay only for the storage size and backups based on the [pricing policy](../pricing.md#prices-storage).

## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to stop.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. In the line of the appropriate cluster, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-stop }}**.
   1. Confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a cluster, run the command:

   ```bash
   {{ yc-mdb-rd }} cluster stop <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To stop a cluster, use the [stop](../api-ref/Cluster/stop.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Stop](../api-ref/grpc/cluster_service.md#Stop) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **STOPPED** clusters.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to start.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. In the line of the appropriate cluster, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-start }}**.
   1. Confirm that you want to start the cluster: click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}** in the dialog box that opens.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a cluster, run the command:

   ```bash
   {{ yc-mdb-rd }} cluster start <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To start a cluster, use the [start](../api-ref/Cluster/start.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Start](../api-ref/grpc/cluster_service.md#Start) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

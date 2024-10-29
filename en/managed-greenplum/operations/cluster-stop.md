# Stopping and starting {{ GP }} clusters

You can stop and restart clusters, if required.

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Find the cluster you need in the list, click the ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
   1. Confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a {{ GP }} cluster, run the command:

   ```bash
   {{ yc-mdb-gp }} cluster stop <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To stop a cluster, use the [stop](../api-ref/Cluster/stop.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Stop](../api-ref/grpc/Cluster/stop.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Find the stopped cluster you need in the list, click the ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
   1. Confirm that you want to start the cluster and click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a {{ GP }} cluster, run the command below:

   ```bash
   {{ yc-mdb-gp }} cluster start <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To start a cluster, use the [start](../api-ref/Cluster/start.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Start](../api-ref/grpc/Cluster/start.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

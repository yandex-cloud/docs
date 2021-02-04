# Stopping and starting clusters

If necessary, you can stop and restart {{ KF }} clusters. When a cluster is stopped, all data in it is retained: it will be available again when you restart the cluster.

## Stop a cluster {#stop-cluster}

{% list tabs %}

- Management console

  To stop all hosts in the cluster:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Find the cluster in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop cluster**.
  1. In the dialog box that opens, confirm that you want to stop the cluster and click **Stop**.


- API

  Use the [stop](../api-ref/Cluster/stop.md) API method to stop all cluster hosts: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Start a cluster {#start-cluster}

You can restart `STOPPED` clusters.

{% list tabs %}

- Management console

  To start a cluster:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Find the stopped cluster you need in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start cluster**.
  1. In the window that opens, click **Start**.


- API

  To start a cluster, use the [start](../api-ref/Cluster/start.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

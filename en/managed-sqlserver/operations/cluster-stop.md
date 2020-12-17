# Stopping and starting clusters

If necessary, you can stop and restart the cluster.

## Stop a cluster {#stop-cluster}

{% list tabs %}

- Management console

  To stop all hosts in the cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Find the cluster in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop**.
  1. Confirm that you want to stop the cluster and click **Stop**.

- API

  Use the `stop` API method to stop all the cluster hosts: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Start a cluster {#start-cluster}

{% list tabs %}

- Management console

  To start a cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Find the stopped cluster you need in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start**.
  1. Confirm that you want to start the cluster and click **Start**.

- API

  To start the cluster, use the `start` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


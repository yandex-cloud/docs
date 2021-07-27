---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Stopping and starting clusters

If necessary, you can stop and restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs %}

- Management console

  To stop all hosts in the cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Find the cluster in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop**.
  1. Confirm that you want to stop the cluster and click **Stop**.

- API

  Use the [stop](../api-ref/Cluster/stop.md) API method to stop all cluster hosts: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start-cluster}

{% list tabs %}

- Management console

  To start a cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Find the stopped cluster you need in the list and click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start**.
  1. Confirm that you want to start the cluster and click **Start**.

- API

  To start a cluster, use the [start](../api-ref/Cluster/start.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


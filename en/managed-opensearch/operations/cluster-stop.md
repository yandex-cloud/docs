---
title: "Stopping and starting {{ OS }} clusters"
description: "If necessary, you can stop and restart an {{ OS }} cluster. When a cluster is stopped, all data in it is retained. It will be available again when you restart the cluster."
keywords:
  - Stopping OpenSearch
  - Starting OpenSearch
  - OpenSearch
---

# Stopping and starting {{ OS }} clusters

If necessary, you can stop and restart {{ OS }} clusters. When a cluster is stopped, all data in it is retained: it will be available again when you restart the cluster.


You are not charged for the time when your cluster is stopped, but you still pay for the storage size based on the [pricing policy](../pricing.md).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Stopping a cluster {#stop}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Find the cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop cluster**.
   1. In the dialog box that opens, confirm that you want to stop the cluster and click **Stop**.

- API

   Use the [stop](../api-ref/Cluster/stop.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start}

You can restart **STOPPED** clusters.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Find the stopped cluster you need in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start cluster**.
   1. In the dialog box that opens, confirm that you want to start the cluster and click **Start**.

- API

   Use the [start](../api-ref/Cluster/start.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

---
title: "Stopping and starting {{ PG }} clusters in {{ mpg-name }}"
description: "If necessary, you can stop and restart a {{ PG }} database cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups."
---

# Stopping and starting {{ PG }} clusters

If necessary, you can stop and restart a {{ PG }} DB cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups based on the [pricing policy](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the desired cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop**.
   1. Confirm that you want to stop the cluster and click **Stop**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a cluster, run the command:

   ```bash
   {{ yc-mdb-pg }} cluster stop <cluster name or ID>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [stop](../api-ref/Cluster/stop.md) API method and pass the ID of the required cluster in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **STOPPED** clusters.

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the stopped cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start**.
   1. Confirm that you want to start the cluster: click **Start** in the dialog box that opens.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a stopped cluster, run the command:

   ```bash
   {{ yc-mdb-pg }} cluster start <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [start](../api-ref/Cluster/start.md) API method and pass the ID of the required cluster in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

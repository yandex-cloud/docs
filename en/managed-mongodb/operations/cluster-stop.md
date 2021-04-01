# Stopping and starting clusters

If necessary, you can stop and restart a DB cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups based on the [pricing policy](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}

## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Management console

  To stop all hosts in the cluster:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster from the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop**.
  1. Confirm that you want to stop the cluster and click **Stop**.

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart `STOPPED` clusters.

{% list tabs %}

- Management console

  To start a cluster:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select a stopped cluster from the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start**.
  1. Confirm that you want to start the cluster: click **Start** in the dialog box that opens.

{% endlist %}


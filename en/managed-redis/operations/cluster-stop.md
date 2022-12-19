# Stopping and starting {{ RD }} clusters

If necessary, you can stop and restart a DB cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups based on the [pricing policy](../pricing.md#prices-storage).

## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to stop.
   1. Select **{{ mrd-name }}**.
   1. In the line of the appropriate cluster, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Stop**.
   1. Confirm that you want to stop the cluster and click **Stop**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a cluster, run the command:

   ```bash
   {{ yc-mdb-rd }} cluster stop <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [stop](../api-ref/Cluster/stop.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **STOPPED** clusters.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to start.
   1. Select **{{ mrd-name }}**.
   1. In the line of the appropriate cluster, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Start**.
   1. Confirm that you want to start the cluster: click **Start** in the dialog box that opens.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a cluster, run the command:

   ```bash
   {{ yc-mdb-rd }} cluster start <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [start](../api-ref/Cluster/start.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

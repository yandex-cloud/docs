# Stopping and starting clusters

If necessary, you can stop and restart {{ KF }} clusters. When a cluster is stopped, all data in it is retained: it will be available again when you restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Find the cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop cluster**.
   1. In the dialog box that opens, confirm that you want to stop the cluster and click **Stop**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster stop <cluster name or ID>
   ```

{% if api != "noshow" %}

- API

   Use the [stop](../api-ref/Cluster/stop.md) API method to stop all the cluster hosts: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **STOPPED** clusters.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Find the stopped cluster you need in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start cluster**.
   1. In the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster start <cluster name or ID>
   ```

{% if api != "noshow" %}

- API

   Use the [start](../api-ref/Cluster/start.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

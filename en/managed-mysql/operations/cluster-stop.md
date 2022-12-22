---
title: "Stopping and starting {{ MY }} clusters"
description: "If necessary, you can stop and restart {{ MY }} DB cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups based on the pricing policy"
---

# Stopping and starting {{ MY }} clusters

If necessary, you can stop and restart a DB cluster. You are not charged for the time when your cluster is stopped: you only continue to pay for the storage size and backups based on the [pricing policy](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}


## Stopping a cluster {#stop-cluster}

{% include [cluster-stop](../../_includes/mdb/cluster-stop.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the desired cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Stop**.
   1. Confirm that you want to stop the cluster and click **Stop**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI cluster stop command:

      ```bash
      {{ yc-mdb-my }} cluster stop --help
      ```

   1. To get a cluster ID and name, request the list of clusters in the folder:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. To stop a cluster, run the command:

      ```bash
      {{ yc-mdb-my }} cluster stop <cluster name or ID>
      ```

- API

   Use the [stop](../api-ref/Cluster/stop.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **STOPPED** clusters.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the stopped cluster in the list, click ![options](../../_assets/horizontal-ellipsis.svg), and select **Start**.
   1. Confirm that you want to start the cluster: click **Start** in the dialog box that opens.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI cluster start command:

      ```bash
      {{ yc-mdb-my }} cluster start --help
      ```

   1. To get a cluster ID and name, request the list of clusters in the folder:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. To start a cluster, run the command:

      ```bash
      {{ yc-mdb-my }} cluster start <cluster name or ID>
      ```

- API

   Use the [start](../api-ref/Cluster/start.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

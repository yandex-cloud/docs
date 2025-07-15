---
title: Stopping and starting an Elasticsearch cluster
description: You can stop and restart an Elasticsearch cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.
keywords:
  - stopping Elasticsearch
  - starting Elasticsearch
  - Elasticsearch
---

# Stopping and starting a {{ ES }} cluster

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can stop and restart a {{ ES }} cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.

You are not charged for the time when your cluster is stopped; however, you still have to pay for the storage size based on the [pricing policy](../pricing.md#prices-storage).

{% include [pricing-status-warning.md](../../_includes/mdb/pricing-status-warning.md) %}

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder dashboard and select **Managed Service for Elasticsearch**.
  1. Find the cluster in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. In the dialog box that opens, confirm that you want to stop the cluster and click **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To stop a cluster, run the command:

    ```bash
    {{ yc-mdb-es }} cluster stop <cluster_name_or_ID>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

  To stop a cluster, use the [stop](../api-ref/Cluster/stop.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Stop](../api-ref/grpc/Cluster/stop.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Starting a cluster {#start-cluster}

You can restart **Stopped** clusters.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder dashboard and select **Managed Service for Elasticsearch**.
  1. Find the stopped cluster in the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. In the dialog box that opens, confirm that you want to start the cluster and click **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To start a stopped cluster, run the command:

    ```bash
    {{ yc-mdb-es }} cluster start <cluster_name_or_ID>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

  To start a cluster, use the [start](../api-ref/Cluster/start.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Start](../api-ref/grpc/Cluster/start.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

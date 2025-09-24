---
title: How to stop and start a {{ metastore-full-name }} cluster
description: Follow this guide to learn how to stop and start a {{ metastore-full-name }} cluster.
---

# Stopping and starting an {{ metastore-full-name }} cluster

{% include [Preview](../../../_includes/note-preview.md) %}

You can stop and restart an {{ metastore-name }} cluster as needed. When stopped, a cluster retains all its data. The data will be available again as soon as you restart the cluster.

## Stopping a cluster {#stop-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to stop a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
  1. Confirm stopping the cluster.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To stop a {{ metastore-name }} cluster, run the command:

  ```bash
  {{ yc-metastore }} cluster stop <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Starting a {#stop-cluster} cluster

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to start a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. In the cluster row, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
  1. Confirm starting the cluster.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To start a {{ metastore-name }} cluster, run this command:

  ```bash
  {{ yc-metastore }} cluster start <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}

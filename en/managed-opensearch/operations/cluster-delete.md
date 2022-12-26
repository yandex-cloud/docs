---
title: "Deleting an {{ OS }} cluster"
description: "You can delete an {{ OS }} cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the folder you want to delete a cluster from."
keywords:
  - creating an OpenSearch cluster
  - OpenSearch cluster
  - OpenSearch
---

# Deleting an {{ OS }} cluster

You can delete an {{ OS }} cluster if you no longer need it. All data in the cluster will be deleted.

## Before deleting a cluster {#before-you-delete}

* [Disable deletion protection](update.md) for the cluster if it is enabled.
* [Save the cluster ID](cluster-list.md#list-clusters).

   {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Deleting a cluster {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
   1. Select **{{ mos-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired cluster and select **Delete cluster**.
   1. Confirm cluster deletion and click **Delete**.

- API

   Use the [delete](../api-ref/Cluster/delete.md) API method and pass the ID of the cluster to delete in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

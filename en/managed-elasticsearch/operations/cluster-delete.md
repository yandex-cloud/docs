---
title: Deleting an Elasticsearch cluster
description: 'You can delete your Elasticsearch cluster if you no longer need it. All data in the cluster will be deleted. In the management console, select the directory from which you want to remove the cluster.'
keywords:
  - deleting an Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Deleting clusters

You can delete an {{ ES }} cluster if you no longer need it. All data in the cluster will be deleted.

{% list tabs %}

- Management console
  1. In the management console, select the folder you want to delete a cluster from.
  1. Select **{{ mes-name }}**.
  1. Click ![image](../../_assets/options.svg) for the cluster and select **Delete cluster**.
  1. Confirm cluster deletion and click **Delete**.

- API

  To delete the cluster, use the `delete` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


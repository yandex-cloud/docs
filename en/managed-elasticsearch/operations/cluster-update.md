---
title: Changing Elasticsearch cluster settings
description: 'After creating the cluster, you can change the host class settings, increase the storage size, or change additional settings for the Elasticsearch cluster.'
keywords:
  - Elasticsearch settings
  - Elasticsearch cluster settings
  - Elasticsearch
---

# Changing cluster settings

After creating an {{ ES }} cluster, you can:

- [Update the cluster configuration](#update-cluster).
- [Move the cluster](#move-cluster) from the current folder to another one.

## Changing the configuration {#update-cluster}

{% list tabs %}

- API

  Use the `update` API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - List of cluster configuration fields to be changed in the `updateMask` parameter.
  - The new configuration in the `configSpec` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't explicitly specified in the `config_Spec` parameter to their default values.
To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}
  - A new cluster name, in the `name` parameter (optional).

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- API

  To move a cluster from the current folder to a different one, use the `move` API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


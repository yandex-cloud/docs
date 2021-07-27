---
title: Information about the existing Elasticsearch clusters
description: 'You can request detailed information about each Managed Service for Elasticsearch cluster you create.'
keywords:
  - information about Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Information about existing clusters

You can request detailed information about each {{ mes-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ mes-name }}**.

- API

  Use the `list` API method: pass the ID of the required folder in the `folderId` request parameter.

  The response will contain cluster names and IDs.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need.

- API

  Use the `get` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

The operation list shows operations with clusters and related resources (for example, hosts and shards).

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need.
  1. Go to the **Operations** tab.

- API

  Use the `listOperations` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}


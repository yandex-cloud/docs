---
title: "Information about existing {{ OS }} clusters"
description: "You can request detailed information about each {{ OS }} cluster you created."
keywords:
  - Information about OpenSearch hosts
  - OpenSearch hosts
  - OpenSearch
---

# Information about existing clusters {{ OS }}

You can request detailed information about each {{ mos-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.

- API

   Use the [list](../api-ref/Cluster/list.md) API method and pass the folder ID in the `folderId` request parameter.

   The response will contain cluster names and IDs.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click on the name of the desired cluster.

- API

   Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

The operation list shows operations with clusters and related resources (for example, hosts and shards).

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mos-name }}**.
   1. Click the name of the desired cluster and select the ![operations.svg](../../_assets/mdb/operations.svg) **Operations** tab.

- API

   Use the [listOperations](../api-ref/Cluster/listOperations.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

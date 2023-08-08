---
title: "Information about existing Elasticsearch clusters"
description: "You can request detailed information about each {{ mes-name }} cluster you created."
keywords:
  - Information about Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch
---

# Information about existing {{ ES }} clusters

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can request detailed information about each {{ mes-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of clusters, run the following command:

   ```bash
   {{ yc-mdb-es }} cluster list
   ```

- API

   To get a list of clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/cluster_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Click the name of the cluster you need.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get cluster details, run the command:

   ```bash
   {{ yc-mdb-es }} cluster get <cluster name or ID>
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](#list-clusters).

- API

   To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

The operation list shows operations with clusters and related resources (for example, hosts and shards).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Click the name of the cluster you need.
   1. Go to the **Operations** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster operations, run the command:

   ```bash
   {{ yc-mdb-es }} cluster list-operations <cluster name or ID>
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](#list-clusters).

- API

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

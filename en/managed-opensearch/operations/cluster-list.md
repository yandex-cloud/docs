---
title: Information about existing {{ OS }} clusters
description: You can request detailed information about each {{ OS }} cluster you created.
keywords:
  - Information about OpenSearch hosts
  - OpenSearch hosts
  - OpenSearch
---

# Information about existing {{ OS }} clusters

You can request detailed information about each {{ mos-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

   In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ OS }} clusters in the default folder, run this command:

   ```bash
   {{ yc-mdb-os }} cluster list
   ```

   ```text
   +----------------------+------+-----------------------------+--------+---------+
   |          ID          | NAME |         CREATED AT          | HEALTH | STATUS  |
   +----------------------+------+-----------------------------+--------+---------+
   | c9wlk4v14uq7******** | myos | 2023-12-19T10:04:14.645214Z | ALIVE  | RUNNING |
   | ...                                                                          |
   +----------------------+------+-----------------------------+--------+---------+
   ```

- API {#api}

   To get a list of clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/cluster_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   The response will contain cluster names and IDs.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about an {{ OS }} cluster, run the following command:

   ```bash
   {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](#list-clusters).

- API {#api}

   To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

The operation list shows operations with clusters and related resources (for example, hosts and shards).

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and select the ![operations.svg](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

- API {#api}

   To get a list of cluster operations, use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

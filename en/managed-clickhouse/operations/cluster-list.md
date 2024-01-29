---
title: "Information about clusters in {{ mch-short-name }}"
description: "You can request detailed information about each {{ mch-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mch-name }}."
---

# Information about existing {{ CH }} clusters

You can request detailed information about each {{ mch-short-name }} cluster you created.


## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

   In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ CH }} clusters in the default folder, run the command:

   ```
   {{ yc-mdb-ch }} cluster list

   +----------------------+---------------+-----------------------------+--------+---------+
   |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
   +----------------------+---------------+-----------------------------+--------+---------+
   | c9wlk4v14uq7******** |     mych      | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
   | ...                                                                                   |
   +----------------------+---------------+-----------------------------+--------+---------+
   ```

- API {#api}

   To get a list of DB clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/cluster_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}


## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ CH }} cluster, run the following command:

   ```
   {{ yc-mdb-ch }} cluster get <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API {#api}

   To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name.
   1. Go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_operations }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```
   {{ yc-mdb-ch }} cluster list-operations <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API {#api}

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

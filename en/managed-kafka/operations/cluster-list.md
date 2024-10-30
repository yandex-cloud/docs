---
title: Information about clusters in {{ mkf-name }}
description: You can request detailed information about each {{ mkf-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mkf-name }}.
---

# Information about existing clusters in {{ mkf-name }}

You can request detailed information about each {{ mkf-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.


- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ KF }} clusters in the default folder, run the command:

   ```
   {{ yc-mdb-kf }} cluster list
   ```

   Result:

   ```
   +----------------------+----------+---------------------+--------+---------+
   |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
   +----------------------+----------+---------------------+--------+---------+
   | c9qaruvk2mma******** | kafka750 | 2020-12-18 05:21:27 | ALIVE  | RUNNING |
   | ...                                                                      |
   +----------------------+----------+---------------------+--------+---------+
   ```

- API {#api}

   To get a list of DB clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/Cluster/list.md) gRPC API call and provide the folder ID in the `folderId` request parameter.

   The response will contain cluster names and IDs.


{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name.


- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about an {{ KF }} cluster, run the following command:

   ```
   {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API {#api}

   To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).


{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/mkf-list-operations-about.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name.
   1. Go to the **{{ ui-key.yacloud.common.operations-key-value }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```
   {{ yc-mdb-kf }} cluster list-operations <cluster_name_or_ID>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).


- API {#api}

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) gRPC API call.


{% endlist %}

---
title: Information about clusters in {{ mmg-short-name }}
description: You can request detailed information about each {{ mmg-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mmg-name }}.
---

# Information about existing {{ MG }} clusters

You can request detailed information about each {{ mmg-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ MG }} clusters in the default folder, run the command:

  ```bash
  yc managed-mongodb cluster list
  ```

  Result:

  ```text
  +----------------------+------------+-----------------------------+--------+---------+
  |          ID          |    NAME    |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+------------+-----------------------------+--------+---------+
  | c9wlk4v14uq7******** | mymg       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                |
  +----------------------+------------+-----------------------------+--------+---------+
  ```

- API {#api}

  To get a list of DB clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/Cluster/list.md) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about the {{ MG }} cluster, run the following command:

  ```bash
  {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API {#api}

  To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mmg-name }} clusters are logged as a list of operations. Each operation is assigned a unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ mmg-name }} clusters, in the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}**. In the list that opens, you will also see operations with the resources that were deleted.

  You can get a list of operations for a cluster:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mongodb.switch_list }}**.
  1. Select the cluster you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.mongodb.switch_operations }}** panel for the selected cluster.

     You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mmg-name }} cluster, run this command:

  ```bash
  yc managed-mongodb cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |      DESCRIPTION       |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  | c9ql1rfrqk4u******** | 2024-09-07 16:37:10 | aje9k8luj4qf******** | 2024-09-07 16:44:28 | DONE   | Create MongoDB cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------------+
  ```

  You can get the cluster ID and name with a [list of clusters in the folder](#list-clusters).

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc managed-mongodb cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: c9ql1rfrqk4u********
    description: Create MongoDB cluster
    created_at: "2024-09-07T16:37:10.533508Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:28.147771Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
      cluster_id: c9q8tmbam8co********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- API {#api}

  Use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) gRPC API call and provide the cluster ID in the request.

  You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

### Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the cluster.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Run this command:

     ```bash
     yc operation get <operation_ID>
     ```

     Result:

     ```text
     id: c9ql1rfrqk4u********
     description: Create MongoDB cluster
     created_at: "2024-09-07T16:37:10.533508Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-09-07T16:44:28.147771Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.CreateClusterMetadata
       cluster_id: c9q8tmbam8co********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.mongodb.v1.Cluster
     ...
     ```

   - API {#api}

     Use the [get](../api-ref/Cluster/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call and provide the operation ID in the request.

   {% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

---
title: Information about clusters in {{ mkf-name }}
description: You can request detailed information about each {{ mkf-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mkf-name }}.
---

# Information about existing clusters in {{ mkf-name }}

You can request detailed information about each {{ mkf-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
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

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about the {{ KF }} cluster, run the following command:

  ```
  {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API {#api}

  To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) gRPC API call and provide the cluster ID in the request.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).


{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mkf-name }} clusters are logged as a list of operations. Each operation is assigned a unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of operations for a cluster:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Select the cluster you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

     You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ mkf-name }} cluster, run this command:

  ```bash
  yc managed-kafka cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |         DESCRIPTION         |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  | dqh0ntf6batm******** | 2024-09-07 16:36:46 | aje9k8luj4qf******** | 2024-09-07 16:44:12 | DONE   | Create Apache Kafka cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------------------+
  ```

  You can get the cluster ID and name with a [list of clusters in the folder](#list-clusters).

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc managed-kafka cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: dqh0ntf6batm********
    description: Create Apache Kafka cluster
    created_at: "2024-09-07T16:36:46.816682Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:12.944302Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.CreateClusterMetadata
      cluster_id: c9q13q0acgv7********
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
     id: dqh0ntf6batm********
     description: Create Apache Kafka cluster
     created_at: "2024-09-07T16:36:46.816682Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-09-07T16:44:12.944302Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.CreateClusterMetadata
       cluster_id: c9q13q0acgv7********
     response:
       '@type': type.googleapis.com/yandex.cloud.mdb.kafka.v1.Cluster
     ...
     ```

   - API {#api}

     Use the [get](../api-ref/Cluster/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call and provide the operation ID in the request.

   {% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

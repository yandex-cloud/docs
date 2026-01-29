# Information about existing {{ dataproc-name }} clusters

You can get details about each {{ dataproc-name }} cluster.

## Getting a list of clusters in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ dataproc-name }} clusters in the default folder, run this command:

    ```bash
    {{ yc-dp }} cluster list
    ```

- API {#api}

    Use the [list](../api-ref/Cluster/list.md) API method.

{% endlist %}

## Getting detailed information about a cluster {#detail}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the name of your cluster.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get {{ dataproc-name }} cluster details, run the command:

    ```bash
    {{ yc-dp }} cluster get <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](#list).

- API {#api}

    Use the [get](../api-ref/Cluster/get.md) API method and provide the cluster ID in the `clusterId` request parameter.

    You can get the cluster ID with the [list of clusters in the folder](#list).

{% endlist %}

## Viewing operations with clusters {#operations}

All actions with {{ dataproc-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ dataproc-name }} clusters, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}** in the left-hand panel. The list that opens also includes operations with the clusters you deleted.

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a {{ dataproc-name }} cluster.

  1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Select your cluster.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}** panel for the selected cluster.

     You will see a list of operations with the cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ dataproc-name }} cluster operations, run this command:

  ```bash
  yc dataproc cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c9q2n4s13p5v******** | 2024-08-06 06:19:47 | ajej2i98kcjd******** | 2024-08-06 06:21:36 | DONE   | Create Data Processing cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list).

  By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using `--format`:

  ```bash
  yc dataproc cluster list-operations epdplu8jn7sr******** --format yaml
  ```

  Result:

  ```text
  - id: c9q2n4s13p5v********
    description: Create Data Processing cluster
    created_at: "2024-08-06T06:19:47.755364Z"
    created_by: ajej2i98kcjd********
    modified_at: "2024-08-06T06:21:36.095300Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.dataproc.v1.CreateClusterMetadata
      cluster_id: c9q77tr1aq3g********
    response:
      '@type': type.googleapis.com/yandex.cloud.dataproc.v1.Cluster
  ...
  ```

- API {#api}

  Use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) gRPC API call and provide the cluster ID in the request.

  You can get the cluster ID with the [list of clusters in the folder](#list).

{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get the list of cluster operations](#get-operations).
1. Copy the ID of the operation you need.
1. Get operation details:

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
     id: c9q2n4s13p5v********
     description: Create Data Processing cluster
     created_at: "2024-08-06T06:19:47.755364Z"
     created_by: ajej2i98kcjd********
     modified_at: "2024-08-06T06:21:36.095300Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.dataproc.v1.CreateClusterMetadata
       cluster_id: c9q77tr1aq3g********
     response:
       '@type': type.googleapis.com/yandex.cloud.dataproc.v1.Cluster
     ...
     ```

   - API {#api}

     Use the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call and provide the operation ID in the request.

   {% endlist %}

### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
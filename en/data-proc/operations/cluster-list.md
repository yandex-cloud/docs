# Information about existing {{ dataproc-name }} clusters

You can get detailed information about each {{ dataproc-name }} cluster.

## Getting a list of clusters in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

    Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To request a list of {{ dataproc-name }} clusters in the default folder, run the command:

    ```bash
    {{ yc-dp }} cluster list
    ```

- API {#api}

    Use the [list](../api-ref/Cluster/list.md) API method.

{% endlist %}

## Getting detailed information about a cluster {#detail}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get {{ dataproc-name }} cluster details, run the command:

    ```bash
    {{ yc-dp }} cluster get <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with a [list of clusters in the folder](#list).

- API {#api}

    Use the [get](../api-ref/Cluster/get.md) API method and provide the cluster ID in the `clusterId` request parameter.

    You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}

## Viewing operations with clusters {#operations}

All actions with {{ dataproc-name }} clusters are logged as a list of operations. Each operation is assigned a unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all {{ dataproc-name }} clusters, in the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}**. The list that opens also includes operations with the clusters that were deleted.

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a {{ dataproc-name }} cluster.

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Select the cluster you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}** panel for the selected cluster.

     You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ dataproc-name }} cluster, run this command:

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

  You can get the cluster ID and name with a [list of clusters in the folder](#list).

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

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

  You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}

### Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for a cluster.
1. Copy the operation ID.
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
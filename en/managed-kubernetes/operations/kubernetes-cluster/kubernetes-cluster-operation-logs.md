# Viewing operations with a {{ managed-k8s-name }} cluster

All actions with {{ managed-k8s-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with all [{{ k8s }} clusters](../../concepts/index.md#kubernetes-cluster), in the left-hand panel, select ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.k8s.switch_operations }}**. The list that opens also includes operations with the clusters that were deleted.

  You can get a list of operations for a specific cluster:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster you need.
  1. Go to the ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

     You will see a list of operations with the selected cluster.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ managed-k8s-name }} cluster, run this command:

  ```bash
  yc managed-kubernetes cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | cat5g6mqaccn******** | 2024-05-14 18:40:02 | aje9k8luj4qf******** | 2024-05-14 18:40:03 | DONE   | Update cluster |
  | cati1flsiarv******** | 2024-05-14 18:29:13 | aje9k8luj4qf******** | 2024-05-14 18:36:17 | DONE   | Create cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc managed-kubernetes cluster list-operations <cluster_name_or_ID> --format yaml
  ```

  Result:

  ```text
  - id: cat5g6mqaccn********
    description: Update cluster
    created_at: "2024-05-14T18:40:02Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:40:03Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s-logs
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      service_account_id: ajeevjv1lv01********
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  - id: cati1flsiarv********
    description: Create cluster
    created_at: "2024-05-14T18:29:13Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:36:17Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.CreateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  ```

- API {#api}

  Use either the [listOperations](../../managed-kubernetes/api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../../managed-kubernetes/api-ref/grpc/Cluster/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the {{ managed-k8s-name }} cluster.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     Run this command:

     ```bash
     yc operation get <operation_ID>
     ```

     Result:

     ```text
     id: cat5g6mqaccn********
     description: Update cluster
     created_at: "2024-05-14T18:40:02Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-05-14T18:40:03Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
       cluster_id: cathr91hiupd********
     response:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
       id: cathr91hiupd********
       folder_id: b1g681qpemb4********
       created_at: "2024-05-14T18:29:13Z"
       name: my-k8s-logs
       status: RUNNING
       health: HEALTHY
       network_id: enpphqi8uvcm********
       ...
       service_account_id: ajeevjv1lv01********
       node_service_account_id: ajeevjv1lv01********
       release_channel: REGULAR
     ```

   - API {#api}

     Use the [OperationService/Get](../../managed-kubernetes/api-ref/grpc/Operation/get.md) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)

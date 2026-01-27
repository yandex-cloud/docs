# Viewing operations with clusters

All actions with {{ mgp-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
  1. Select the cluster.
  1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

     You will see a list of operations with the cluster.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ GP }} cluster operations, run this command:

  ```bash
  yc managed-greenplum cluster list-operations <cluster_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |       DESCRIPTION        |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------+
  | dqh0ntf6batm******** | 2024-09-07 16:36:46 | aje9k8luj4qf******** | 2024-09-07 16:44:12 | DONE   | Create Greenplum cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------+
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

  By default, information about operations is output as text. To get more detailed information, specify the `yaml` or `json` output data format using `--format`:

  ```bash
  yc managed-greenplum cluster list-operations c9qk2926qqu9******** --format yaml
  ```

  Result:

  ```text
  - id: dqh0ntf6batm********
    description: Create Greenplum cluster
    created_at: "2024-09-07T16:36:46.816682Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-09-07T16:44:12.944302Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.mdb.greenplum.v1.CreateClusterMetadata
      cluster_id: c9q13q0acgv7********
    response:
      '@type': type.googleapis.com/google.rpc.Status
      message: OK
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListOperations](../api-ref/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/operations'
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listOperations.md#yandex.cloud.mdb.greenplum.v1.ListClusterOperationsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.ListOperations](../api-ref/grpc/Cluster/listOperations.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.greenplum.v1.ClusterService.ListOperations
      ```

      You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listOperations.md#yandex.cloud.mdb.greenplum.v1.ListClusterOperationsResponse) to make sure your request was successful.

{% endlist %}

## Getting operation details {#get-operations-info}

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
      id: dqh0ntf6batm********
      description: Create Greenplum cluster
      created_at: "2024-09-07T16:36:46.816682Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-09-07T16:44:12.944302Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.mdb.greenplum.v1.CreateClusterMetadata
        cluster_id: c9q13q0acgv7********
      response:
        '@type': type.googleapis.com/yandex.cloud.mdb.greenplum.v1.Cluster
      ...
      ```

    - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Call the [Operation.Get](../api-ref/Operation/get.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-operation }}/operations/<operation_ID>'
          ```

      1. Check the [server response](../api-ref/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    - gRPC API {#grpc-api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

      1. Call the [OperationService.Get](../api-ref/grpc/Operation/get.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/operation/operation_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "operation_id": "<operation_ID>"
                  }' \
              {{ api-host-operation }}:{{ port-https }} \
              yandex.cloud.operation.OperationService.Get
          ```

      1. Check the [server response](../api-ref/grpc/Operation/get.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    {% endlist %}

## See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

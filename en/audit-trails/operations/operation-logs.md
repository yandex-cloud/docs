# Viewing operations with a trail

All actions with {{ at-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder where the trail resides.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Select the trail you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected trail.

     You will see a list of operations with the selected trail.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a trail, run this command:

  ```bash
  yc audit-trails trail list-operations <trail_name_or_ID>
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | cnpne9jsof71******** | 2024-03-26 16:57:32 | aje9k8luj4qf******** | 2024-03-26 16:57:32 | DONE   | operation_update |
  | cnp7308f90cf******** | 2024-03-26 16:50:22 | aje9k8luj4qf******** | 2024-03-26 16:50:23 | DONE   | operation_create |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc audit-trails trail list-operations <trail_name_or_ID> --format yaml
  ```

  Result:

  ```text
  - id: cnpne9jsof71********
    description: operation_update
    created_at: "2024-03-26T16:57:32.085739756Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T16:57:32.324291102Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.audittrails.v1.UpdateTrailMetadata
      trail_id: cnpr443sd0c0********
  - id: cnp7308f90cf********
    description: operation_create
    created_at: "2024-03-26T16:50:22.501Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T16:50:23.963321235Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.audittrails.v1.CreateTrailMetadata
      trail_id: cnpr443sd0c0********
  ```

- API {#api}

  Use the [listOperations](../api-ref/Trail/listOperations.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/ListOperations](../api-ref/grpc/Trail/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
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
      id: cnpne9jsof71********
      description: operation_update
      created_at: "2024-03-26T16:57:32.085Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-26T16:57:32.324Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.audittrails.v1.UpdateTrailMetadata
        trail_id: cnpr443sd0c0********
      response:
        '@type': type.googleapis.com/yandex.cloud.audittrails.v1.Trail
        id: cnpr443sd0c0********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-26T16:50:22.505Z"
        updated_at: "2024-03-26T16:57:32.111Z"
        name: operat-ions
        destination:
          object_storage:
            bucket_id: for-********
            object_prefix: nuts
        service_account_id: ajeevjv1lv01********
        status: ACTIVE
        filter:
          path_filter:
            root:
              any_filter:
                resource:
                  id: b1g681qpemb4********
                  type: resource-manager.folder
          event_filter: {}
        cloud_id: b1gia87mbaom********
      ```

    - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)

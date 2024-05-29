# Viewing operations with the service's resources

All actions with {{ backup-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   To see all operations with the service's resources, in the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. In the list that opens, you will also see operations with the resources that were deleted.

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

      ```yaml
      id: cdg4g6c4jlak********
      description: apply policy
      created_at: "2024-05-14T15:24:23.800129Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-05-14T15:24:23.800129Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.backup.v1.ApplyPolicyMetadata
      response:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      ```

   - API {#api}

      Use the [OperationService/Get](../backup/api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
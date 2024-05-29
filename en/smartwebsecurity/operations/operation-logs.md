# Viewing operations with a security profile

All actions with {{ sws-name }} security profiles are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   To see all operations with all [security profiles](../concepts/profiles.md), in the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. In the list that opens, you will also see operations with the security profiles that were deleted.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for security profiles.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
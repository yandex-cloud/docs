# Viewing operations with profiles

All actions with security profiles, WAF, and ARL are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   To see operations with all [profiles](../concepts/profiles.md), select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand panel. In the list that opens, you will also see operations with the profiles that were deleted.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for security profiles.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
# Viewing operations with profiles

Brief information about actions with {{ sws-name }} objects (e.g., security profiles, WAF and ARL, address lists) is saved as a list of operations. Each operation gets its own unique ID. Use this ID to get detailed information about an operation via the API.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To see operations with all {{ sws-name }} objects, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand panel. In the list that opens, you will also see operations with objects that were deleted.

{% endlist %}

## Getting information about an operation {#get-operations}

To get detailed information about an operation, provide its ID via the API:

* REST: To the [get](../api-ref/Operation/get.md) method.
* gRPC: To the [OperationService/Get](../api-ref/grpc/Operation/get.md) method.

#### See also {#see-also}

* [{#T}](./profile-get.md)
* [{#T}](../../api-design-guide/concepts/about-async.md)
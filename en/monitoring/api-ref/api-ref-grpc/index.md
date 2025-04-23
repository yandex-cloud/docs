# Overview

This API reference is organized by resource. To perform an operation on a resource, make an RPC call. For more information, see the [{{ yandex-cloud }} API guidelines](../../../api-design-guide/).

Service|Description|Use cases
------|--------|--------
[DashboardService](DashboardService.md) | Methods for managing dashboards |[grpcurl](../../operations/dashboard/api-examples.md)

## Processing mutating operation responses {#mutating-operations}

Any operation changing a resource state has an asynchronous signature. When these operations are called, the server returns the [Operation](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation.proto) object.

The `Operation` object contains operation data, e.g., its status, ID, creation date, etc. You can use it for operation status monitoring by checking the `done` field that changes to `true` once the operation is completed. Currently, all operations are synchronous, returning `done=true` or an error.

An error during an asynchronous operation causes the server to abort all running procedures and add the `error` description field to the `Operation` object.

If in response to your request, you receive an `Operation` object, proceed as follows:
* Check that `done=true`.
* Check that the `error` field is empty.
* Get the value of the `response` field.

Error example:
```text
code: 6
message: "ALREADY_EXISTS: Name must be uniq in parentId"
```

## Error handling {#error-handling}

If an error occurs, the {{ monitoring-name }} API returns the gRPC `status != OK`. The response body contains an error description in the following format:

```text
code: <number> error code
message: <string>  error message
```

Error description example:
```text
code: 6
message: "ALREADY_EXISTS: Name must be uniq in parentId"
```

Currently, there is no fixed list of error codes, so the `code` field is reserved for use in future {{ monitoring-name }} versions.

{% note tip %}

We recommend logging error messages, which will help the support team understand the problems’s cause.

{% endnote %}

### Object update conflicts {#conflicts-resolution}

To resolve conflicts when updating objects, use the optional `etag` field that you can provide to the mutating operations and retrieve using the `Get` method. An object will be updated if it is not modified by another concurrent request, and the operation's `etag` matches the server value. If an error occurs, get a new `etag` and retry the operation.

`etag`: Optional field. If it is not provided, the `last-write-wins` policy will be in effect.

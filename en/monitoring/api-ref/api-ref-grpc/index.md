# Overview

This API reference is organized by resource. To perform an operation on a resource, make a remote procedure call (RPC). For more information, see the [{{ yandex-cloud }} API concepts](../../../api-design-guide/) documentation.

| Service | Description | Use cases |
------|--------|--------
| [DashboardService](DashboardService.md) | A set of methods for managing dashboards. | [grpcurl](../../operations/dashboard/api-examples.md) |

## Processing mutating operation responses {#mutating-operations}

Any operations that change the state of a resource are asynchronous signature operations. When they are called, the server returns the [Operation](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation.proto) object.

The `Operation` object contains information about the operation: its status, ID, creation date, and more. You can use this object for operation status monitoring. The operation status is displayed in the `done` field. Once the operation is completed, the `done` field value changes to `true`. Currently, all operations are synchronous and return `done=true` or an error.

If an error occurs while performing an asynchronous operation, the server aborts all running procedures. The `Operation` object is added the `error` field describing the error.

If the `Operation` object is returned in response to a request:
* Make sure that `done=true`.
* Check that the `error` field contains no errors.
* Get a response from the `response` field.

Error example:
```
code: 6
message: "ALREADY_EXISTS: Name must be unique in parentId"
```

## Handling errors {#error-handling}

If an error occurs, the Monitoring API returns the gRPC `status != OK`. The response body contains a detailed error description in the following format:

```
code: <number> error code
message: <string> error text
```

Sample error message:
```
code: 6
message: "ALREADY_EXISTS: Name must be unique in parentId"
```

Currently, there is no fixed list of error codes, so the `code` field is reserved for use in future versions of Yandex Monitoring.

{% note tip %}

We recommend logging error messages. This will help the support team understand what caused the issue.

{% endnote %}

### Object update conflicts {#conflicts-resolution}

To resolve conflicts that may occur while updating objects, the optional `etag` field is used. You can pass it in mutating operations and get it using the `Get` method. An object will be modified if, during the request, it's not updated by another request running concurrently and the `etag` in the operation matches the value on the server. If an error occurs, get a new `etag` and retry the operation.

`etag`: Optional field. If it isn't passed, the `last-write-wins` policy applies.

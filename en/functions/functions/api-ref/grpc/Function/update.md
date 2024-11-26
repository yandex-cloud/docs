---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/update.md
---

# Cloud Functions Service, gRPC: FunctionService.Update

Updates the specified function.

## gRPC request

**rpc Update ([UpdateFunctionRequest](#yandex.cloud.serverless.functions.v1.UpdateFunctionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateFunctionRequest {#yandex.cloud.serverless.functions.v1.UpdateFunctionRequest}

```json
{
  "function_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string"
}
```

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to update.

To get a function ID make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the function should be updated. ||
|| name | **string**

New name for the function.
The name must be unique within the folder. ||
|| description | **string**

New description for the function. ||
|| labels | **string**

Function labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label, request the current set of labels with a [FunctionService.Get](/docs/functions/functions/api-ref/grpc/Function/get#Get) request. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "function_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "http_invoke_url": "string",
    "status": "Status"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateFunctionMetadata](#yandex.cloud.serverless.functions.v1.UpdateFunctionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Function](#yandex.cloud.serverless.functions.v1.Function)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateFunctionMetadata {#yandex.cloud.serverless.functions.v1.UpdateFunctionMetadata}

#|
||Field | Description ||
|| function_id | **string**

ID of the function that is being updated. ||
|#

## Function {#yandex.cloud.serverless.functions.v1.Function}

A serverless function. For details about the concept, see [Functions](/docs/functions/concepts/function).

#|
||Field | Description ||
|| id | **string**

ID of the function. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the function belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the function. ||
|| name | **string**

Name of the function. The name is unique within the folder. ||
|| description | **string**

Description of the function. ||
|| labels | **string**

Function labels as `key:value` pairs. ||
|| http_invoke_url | **string**

URL that needs to be requested to invoke the function. ||
|| status | enum **Status**

Status of the function.

- `STATUS_UNSPECIFIED`
- `CREATING`: Function is being created.
- `ACTIVE`: Function is ready to be invoked.
- `DELETING`: Function is being deleted.
- `ERROR`: Function failed. ||
|#
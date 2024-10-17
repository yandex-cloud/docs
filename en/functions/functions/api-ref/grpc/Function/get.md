---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/get.md
---

# Cloud Functions Service, gRPC: FunctionService.Get {#Get}

Returns the specified function.

To get the list of all available functions, make a [List](/docs/functions/functions/api-ref/grpc/Function/list#List) request.

## gRPC request

**rpc Get ([GetFunctionRequest](#yandex.cloud.serverless.functions.v1.GetFunctionRequest)) returns ([Function](#yandex.cloud.serverless.functions.v1.Function))**

## GetFunctionRequest {#yandex.cloud.serverless.functions.v1.GetFunctionRequest}

```json
{
  "functionId": "string"
}
```

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to return.

To get a function ID make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|#

## Function {#yandex.cloud.serverless.functions.v1.Function}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "httpInvokeUrl": "string",
  "status": "Status"
}
```

A serverless function. For details about the concept, see [Functions](/docs/functions/concepts/function).

#|
||Field | Description ||
|| id | **string**

ID of the function. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the function belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the function. ||
|| name | **string**

Name of the function. The name is unique within the folder. ||
|| description | **string**

Description of the function. ||
|| labels | **string**

Function labels as `key:value` pairs. ||
|| httpInvokeUrl | **string**

URL that needs to be requested to invoke the function. ||
|| status | enum **Status**

Status of the function.

- `STATUS_UNSPECIFIED`
- `CREATING`: Function is being created.
- `ACTIVE`: Function is ready to be invoked.
- `DELETING`: Function is being deleted.
- `ERROR`: Function failed. ||
|#
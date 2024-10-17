---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/setScalingPolicy.md
---

# Cloud Functions Service, gRPC: FunctionService.SetScalingPolicy {#SetScalingPolicy}

Set scaling policy for specified function and tag

## gRPC request

**rpc SetScalingPolicy ([SetScalingPolicyRequest](#yandex.cloud.serverless.functions.v1.SetScalingPolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SetScalingPolicyRequest {#yandex.cloud.serverless.functions.v1.SetScalingPolicyRequest}

```json
{
  "functionId": "string",
  "tag": "string",
  "provisionedInstancesCount": "int64",
  "zoneInstancesLimit": "int64",
  "zoneRequestsLimit": "int64"
}
```

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to retrieve scaling policies for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|| tag | **string**

Required field. Version tag.

To get the history of version tags make a [FunctionService.ListTagHistory](/docs/functions/functions/api-ref/grpc/Function/listTagHistory#ListTagHistory) request. ||
|| provisionedInstancesCount | **int64**

Minimum guaranteed provisioned instances count for all zones in total.
Billed separately. ||
|| zoneInstancesLimit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "functionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "functionId": "string",
    "tag": "string",
    "createdAt": "google.protobuf.Timestamp",
    "modifiedAt": "google.protobuf.Timestamp",
    "provisionedInstancesCount": "int64",
    "zoneInstancesLimit": "int64",
    "zoneRequestsLimit": "int64"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[SetScalingPolicyMetadata](#yandex.cloud.serverless.functions.v1.SetScalingPolicyMetadata)**

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
|| response | **[ScalingPolicy](#yandex.cloud.serverless.functions.v1.ScalingPolicy)**

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

## SetScalingPolicyMetadata {#yandex.cloud.serverless.functions.v1.SetScalingPolicyMetadata}

#|
||Field | Description ||
|| functionId | **string**

ID of the function for which scaling policy was set. ||
|#

## ScalingPolicy {#yandex.cloud.serverless.functions.v1.ScalingPolicy}

#|
||Field | Description ||
|| functionId | **string**

ID of the function that the scaling policy belongs to. ||
|| tag | **string**

Tag of the version that the scaling policy belongs to. For details, see [Version tag](/docs/functions/concepts/function#tag). ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the scaling policy ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp for the scaling policy ||
|| provisionedInstancesCount | **int64**

Minimum guaranteed provisioned instances count for all zones in total.
Billed separately. ||
|| zoneInstancesLimit | **int64**

Upper limit for instance count in each zone.
0 means no limit. ||
|| zoneRequestsLimit | **int64**

Upper limit of requests count in each zone.
0 means no limit. ||
|#
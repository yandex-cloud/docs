---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaRequest/create.md
---

# Quota Manager API, gRPC: QuotaRequestService.Create

Creates a quota request in the specified resource.

## gRPC request

**rpc Create ([CreateQuotaRequestRequest](#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateQuotaRequestRequest {#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "desired_quota_limits": [
    {
      "quota_id": "string",
      "desired_limit": "double"
    }
  ]
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. Resource to create a quota request in. ||
|| desired_quota_limits[] | **[DesiredQuotaLimit](#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest.DesiredQuotaLimit)**

Desired quota limits ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## DesiredQuotaLimit {#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest.DesiredQuotaLimit}

#|
||Field | Description ||
|| quota_id | **string**

Required field. ID of the quota ||
|| desired_limit | **double**

Desired limit of the quota ||
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
    "quota_request_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "resource": {
      "id": "string",
      "type": "string"
    },
    "created_at": "google.protobuf.Timestamp",
    "status": "Status",
    "quota_limits": [
      {
        "quota_id": "string",
        "desired_limit": "double",
        "approved_limit": "double",
        "unit": "string",
        "status": "Status",
        "message": "string",
        "modified_by": "string"
      }
    ],
    "created_by": "string"
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
|| metadata | **[CreateQuotaRequestMetadata](#yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata)**

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
|| response | **[QuotaRequest](#yandex.cloud.quotamanager.v1.QuotaRequest)**

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

## CreateQuotaRequestMetadata {#yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata}

#|
||Field | Description ||
|| quota_request_id | **string**

ID of the quota request that is being created. ||
|#

## QuotaRequest {#yandex.cloud.quotamanager.v1.QuotaRequest}

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| status | enum **Status**

Status of current quota request.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PROCESSED`: The request was processed.
- `CANCELED`: The request was canceled.
- `DELETING`: The request is deleting. ||
|| quota_limits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit)**

Quota limits ||
|| created_by | **string**

ID of the subject who created quota request. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource2}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## QuotaLimit {#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit}

#|
||Field | Description ||
|| quota_id | **string**

ID of the quota. ||
|| desired_limit | **double**

Desired limit. ||
|| approved_limit | **double**

Approved limit. ||
|| unit | **string**

Unit of quota. ||
|| status | enum **Status**

Status of current quota limit.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PARTIAL_APPROVED`: The request was partially approved.
- `APPROVED`: The request was approved.
- `REJECTED`: The request was rejected.
- `CANCELED`: The request was canceled. ||
|| message | **string** ||
|| modified_by | **string**

ID of the subject who modified quota limit. ||
|#
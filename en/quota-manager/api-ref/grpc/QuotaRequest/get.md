---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaRequest/get.md
---

# Quota Manager API, gRPC: QuotaRequestService.Get

Returns the specified quota request.

## gRPC request

**rpc Get ([GetQuotaRequestRequest](#yandex.cloud.quotamanager.v1.GetQuotaRequestRequest)) returns ([QuotaRequest](#yandex.cloud.quotamanager.v1.QuotaRequest))**

## GetQuotaRequestRequest {#yandex.cloud.quotamanager.v1.GetQuotaRequestRequest}

```json
{
  "quota_request_id": "string"
}
```

#|
||Field | Description ||
|| quota_request_id | **string**

Required field. ID of the quota request to return. ||
|#

## QuotaRequest {#yandex.cloud.quotamanager.v1.QuotaRequest}

```json
{
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
```

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)** ||
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

## Resource {#yandex.cloud.quotamanager.v1.Resource}

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
---
editable: false
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaRequest/create.md
---

# Quota Manager API, REST: QuotaRequest.Create

Creates a quota request in the specified resource.

## HTTP request

```
POST https://quota-manager.{{ api-host }}/quota-manager/v1/quotaRequests
```

## Body parameters {#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "desiredQuotaLimits": [
    {
      "quotaId": "string",
      "desiredLimit": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. Resource to create a quota request in. ||
|| desiredQuotaLimits[] | **[DesiredQuotaLimit](#yandex.cloud.quotamanager.v1.CreateQuotaRequestRequest.DesiredQuotaLimit)**

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
|| quotaId | **string**

Required field. ID of the quota ||
|| desiredLimit | **string**

Desired limit of the quota ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "quotaRequestId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "resource": {
      "id": "string",
      "type": "string"
    },
    "createdAt": "string",
    "status": "string",
    "quotaLimits": [
      {
        "quotaId": "string",
        "desiredLimit": "string",
        "approvedLimit": "string",
        "unit": "string",
        "status": "string",
        "message": "string",
        "modifiedBy": "string"
      }
    ],
    "createdBy": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateQuotaRequestMetadata](#yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| quotaRequestId | **string**

ID of the quota request that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## QuotaRequest {#yandex.cloud.quotamanager.v1.QuotaRequest}

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)** ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of current quota request.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PROCESSED`: The request was processed.
- `CANCELED`: The request was canceled.
- `DELETING`: The request is deleting. ||
|| quotaLimits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit)**

Quota limits ||
|| createdBy | **string**

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
|| quotaId | **string**

ID of the quota. ||
|| desiredLimit | **string**

Desired limit. ||
|| approvedLimit | **string**

Approved limit. ||
|| unit | **string**

Unit of quota. ||
|| status | **enum** (Status)

Status of current quota limit.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PARTIAL_APPROVED`: The request was partially approved.
- `APPROVED`: The request was approved.
- `REJECTED`: The request was rejected.
- `CANCELED`: The request was canceled. ||
|| message | **string** ||
|| modifiedBy | **string**

ID of the subject who modified quota limit. ||
|#
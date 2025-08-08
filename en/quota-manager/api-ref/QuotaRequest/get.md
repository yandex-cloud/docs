---
editable: false
apiPlayground:
  - url: https://quota-manager.{{ api-host }}/quota-manager/v1/quotaRequests/{quotaRequestId}
    method: get
    path:
      type: object
      properties:
        quotaRequestId:
          description: |-
            **string**
            Required field. ID of the quota request to return.
          type: string
      required:
        - quotaRequestId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaRequest/get.md
---

# Quota Manager API, REST: QuotaRequest.Get

Returns the specified quota request.

## HTTP request

```
GET https://quota-manager.{{ api-host }}/quota-manager/v1/quotaRequests/{quotaRequestId}
```

## Path parameters

#|
||Field | Description ||
|| quotaRequestId | **string**

Required field. ID of the quota request to return. ||
|#

## Response {#yandex.cloud.quotamanager.v1.QuotaRequest}

**HTTP Code: 200 - OK**

```json
{
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
```

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)** ||
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
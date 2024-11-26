---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/BillingAccount/bindBillableObject.md
---

# Billing API, REST: BillingAccount.BindBillableObject

Binds billable object to the specified billing account.

## HTTP request

```
POST https://billing.{{ api-host }}/billing/v1/billingAccounts/{billingAccountId}/billableObjectBindings
```

## Path parameters

#|
||Field | Description ||
|| billingAccountId | **string**

Required field. ID of the billing account to bind billable object.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/BillingAccount/list#List) request. ||
|#

## Body parameters {#yandex.cloud.billing.v1.BindBillableObjectRequest}

```json
{
  "billableObject": {
    "id": "string",
    "type": "string"
  }
}
```

#|
||Field | Description ||
|| billableObject | **[BillableObject](#yandex.cloud.billing.v1.BillableObject)**

[yandex.cloud.billing.v1.BillableObject](#yandex.cloud.billing.v1.BillableObject) to bind with billing account. ||
|#

## BillableObject {#yandex.cloud.billing.v1.BillableObject}

Represents a link to an object in other service.
This object is being billed in the scope of a billing account.

#|
||Field | Description ||
|| id | **string**

ID of the object in other service. ||
|| type | **string**

Billable object type. Can be one of the following:
* `cloud` ||
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
    "billableObjectId": "string"
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
    "effectiveTime": "string",
    "billableObject": {
      "id": "string",
      "type": "string"
    }
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
|| metadata | **[BindBillableObjectMetadata](#yandex.cloud.billing.v1.BindBillableObjectMetadata)**

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
|| response | **[BillableObjectBinding](#yandex.cloud.billing.v1.BillableObjectBinding)**

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

## BindBillableObjectMetadata {#yandex.cloud.billing.v1.BindBillableObjectMetadata}

#|
||Field | Description ||
|| billableObjectId | **string**

ID of the [yandex.cloud.billing.v1.BillableObject](#yandex.cloud.billing.v1.BillableObject) that was bound to billing account. ||
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

## BillableObjectBinding {#yandex.cloud.billing.v1.BillableObjectBinding}

Represents a binding of the BillableObject to a BillingAccount.

#|
||Field | Description ||
|| effectiveTime | **string** (date-time)

Timestamp when binding was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| billableObject | **[BillableObject](#yandex.cloud.billing.v1.BillableObject2)**

Object that is bound to billing account. ||
|#

## BillableObject {#yandex.cloud.billing.v1.BillableObject2}

Represents a link to an object in other service.
This object is being billed in the scope of a billing account.

#|
||Field | Description ||
|| id | **string**

ID of the object in other service. ||
|| type | **string**

Billable object type. Can be one of the following:
* `cloud` ||
|#
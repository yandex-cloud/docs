---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/bindBillableObject.md
---

# Billing API, gRPC: BillingAccountService.BindBillableObject

Binds billable object to the specified billing account.

## gRPC request

**rpc BindBillableObject ([BindBillableObjectRequest](#yandex.cloud.billing.v1.BindBillableObjectRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BindBillableObjectRequest {#yandex.cloud.billing.v1.BindBillableObjectRequest}

```json
{
  "billing_account_id": "string",
  "billable_object": {
    "id": "string",
    "type": "string"
  }
}
```

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. ID of the billing account to bind billable object.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|| billable_object | **[BillableObject](#yandex.cloud.billing.v1.BillableObject)**

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
    "billable_object_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "effective_time": "google.protobuf.Timestamp",
    "billable_object": {
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[BindBillableObjectMetadata](#yandex.cloud.billing.v1.BindBillableObjectMetadata)**

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
|| billable_object_id | **string**

ID of the [yandex.cloud.billing.v1.BillableObject](#yandex.cloud.billing.v1.BillableObject) that was bound to billing account. ||
|#

## BillableObjectBinding {#yandex.cloud.billing.v1.BillableObjectBinding}

Represents a binding of the BillableObject to a BillingAccount.

#|
||Field | Description ||
|| effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when binding was created. ||
|| billable_object | **[BillableObject](#yandex.cloud.billing.v1.BillableObject2)**

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
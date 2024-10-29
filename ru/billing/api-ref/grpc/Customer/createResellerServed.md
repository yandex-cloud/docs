---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Customer/createResellerServed.md
---

# Billing API, gRPC: CustomerService.CreateResellerServed {#CreateResellerServed}

Creates new reseller-served customer.

## gRPC request

**rpc CreateResellerServed ([CreateResellerServedCustomerRequest](#yandex.cloud.billing.v1.CreateResellerServedCustomerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateResellerServedCustomerRequest {#yandex.cloud.billing.v1.CreateResellerServedCustomerRequest}

```json
{
  "resellerId": "string",
  "name": "string",
  "person": {
    "name": "string",
    "longname": "string",
    "phone": "string",
    "email": "string",
    "postCode": "string",
    "postAddress": "string",
    "legalAddress": "string",
    "tin": "string"
  }
}
```

#|
||Field | Description ||
|| resellerId | **string**

Required field. ID of the reseller that customer will be associated with.</br>

Value must match either one of the three regular expressions:
</br>- `^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$`
</br>- `^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{32})$`
</br>- `^[a-z][-a-zA-Z0-9.]{0,48}[a-zA-Z0-9]$` ||
|| name | **string**

Required field. Name of the customer.

String length is not limited. ||
|| person | **[CustomerPerson](#yandex.cloud.billing.v1.CustomerPerson)**

Required field. Person of the customer. ||
|#

## CustomerPerson {#yandex.cloud.billing.v1.CustomerPerson}

Person of the customer. Contains legal information.

#|
||Field | Description ||
|| name | **string**

Optional. Name of the person.

String length is not limited. ||
|| longname | **string**

Optional. Long name of the person.

String length is not limited. ||
|| phone | **string**

Optional. Phone of the person.

Must be a valid telephone number or a valid [phoneword](https://en.m.wikipedia.org/wiki/Phoneword). ||
|| email | **string**

Optional. Email of the person.

Must be a valid [email address](https://en.wikipedia.org/wiki/Email_address). ||
|| postCode | **string**

Optional. Post code of the person.

String length is not limited. ||
|| postAddress | **string**

Optional. Post address of the person.

String length is not limited. ||
|| legalAddress | **string**

Optional. Legal address of the person.

String length is not limited. ||
|| tin | **string**

Optional. Tax identification number of the person.

String length is not limited. ||
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
    "resellerId": "string",
    "customerId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "billingAccountId": "string"
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
|| metadata | **[CustomerMetadata](#yandex.cloud.billing.v1.CustomerMetadata)**

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
|| response | **[Customer](#yandex.cloud.billing.v1.Customer)**

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

## CustomerMetadata {#yandex.cloud.billing.v1.CustomerMetadata}

#|
||Field | Description ||
|| resellerId | **string**

ID of the reseller. ||
|| customerId | **string**

ID of the customer. ||
|#

## Customer {#yandex.cloud.billing.v1.Customer}

A Customer resource.

#|
||Field | Description ||
|| id | **string**

ID of the customer. ||
|| billingAccountId | **string**

ID of the [yandex.cloud.billing.v1.BillingAccount](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount) assigned to the customer. ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/get.md
---

# Billing API, gRPC: BillingAccountService.Get

Returns the specified billing account.

## gRPC request

**rpc Get ([GetBillingAccountRequest](#yandex.cloud.billing.v1.GetBillingAccountRequest)) returns ([BillingAccount](#yandex.cloud.billing.v1.BillingAccount))**

## GetBillingAccountRequest {#yandex.cloud.billing.v1.GetBillingAccountRequest}

```json
{
  "id": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the billing account to return.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|#

## BillingAccount {#yandex.cloud.billing.v1.BillingAccount}

```json
{
  "id": "string",
  "name": "string",
  "created_at": "google.protobuf.Timestamp",
  "country_code": "string",
  "currency": "string",
  "active": "bool",
  "balance": "string"
}
```

A BillingAccount resource. For more information, see [BillingAccount](/docs/billing/concepts/billing-account).

#|
||Field | Description ||
|| id | **string**

ID of the billing account. ||
|| name | **string**

Name of the billing account. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| country_code | **string**

ISO 3166-1 alpha-2 country code of the billing account. ||
|| currency | **string**

Currency of the billing account.
Can be one of the following:
* `RUB`
* `USD`
* `KZT` ||
|| active | **bool**

Represents whether corresponding billable objects can be used or not. ||
|| balance | **string**

Current balance of the billing account. ||
|#
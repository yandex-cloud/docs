---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/BillingAccount/get.md
---

# Billing API, REST: BillingAccount.Get {#Get}

Returns the specified billing account.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts/{id}
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. ID of the billing account to return.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/BillingAccount/list#List) request. ||
|#

## Response {#yandex.cloud.billing.v1.BillingAccount}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "createdAt": "string",
  "countryCode": "string",
  "currency": "string",
  "active": "boolean",
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| countryCode | **string**

ISO 3166-1 alpha-2 country code of the billing account. ||
|| currency | **string**

Currency of the billing account.
Can be one of the following:
* `RUB`
* `USD`
* `KZT` ||
|| active | **boolean**

Represents whether corresponding billable objects can be used or not. ||
|| balance | **string**

Current balance of the billing account. ||
|#
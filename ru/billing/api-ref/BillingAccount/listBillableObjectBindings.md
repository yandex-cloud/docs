---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/BillingAccount/listBillableObjectBindings.md
---

# Billing API, REST: BillingAccount.ListBillableObjectBindings {#ListBillableObjectBindings}

Retrieves the list of billable object bindings associated with the specified billing account.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts/{billingAccountId}/billableObjectBindings
```

## Path parameters

#|
||Field | Description ||
|| billingAccountId | **string**

Required field. ID of the billing account to list associated billable object bindings.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/BillingAccount/list#List) request. ||
|#

## Query parameters {#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListBillableObjectBindingsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListBillableObjectBindingsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse}

**HTTP Code: 200 - OK**

```json
{
  "billableObjectBindings": [
    {
      "effectiveTime": "string",
      "billableObject": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| billableObjectBindings[] | **[BillableObjectBinding](#yandex.cloud.billing.v1.BillableObjectBinding)**

List of billable object bindings. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBillableObjectBindingsRequest.pageSize](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest), use
`nextPageToken` as the value
for the [ListBillableObjectBindingsRequest.pageToken](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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
|| billableObject | **[BillableObject](#yandex.cloud.billing.v1.BillableObject)**

Object that is bound to billing account. ||
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
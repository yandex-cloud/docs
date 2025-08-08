---
editable: false
apiPlayground:
  - url: https://billing.{{ api-host }}/billing/v1/billingAccounts
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListBillingAccountsResponse.nextPageToken](/docs/billing/api-ref/BillingAccount/list#yandex.cloud.billing.v1.ListBillingAccountsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results,
            set `pageToken` to the [ListBillingAccountsResponse.nextPageToken](/docs/billing/api-ref/BillingAccount/list#yandex.cloud.billing.v1.ListBillingAccountsResponse)
            returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/billing/v1/api-ref/BillingAccount/list.md
---

# Billing API, REST: BillingAccount.List

Retrieves the list of billing accounts available for current user.

## HTTP request

```
GET https://billing.{{ api-host }}/billing/v1/billingAccounts
```

## Query parameters {#yandex.cloud.billing.v1.ListBillingAccountsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListBillingAccountsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListBillingAccountsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.billing.v1.ListBillingAccountsResponse}

**HTTP Code: 200 - OK**

```json
{
  "billingAccounts": [
    {
      "id": "string",
      "name": "string",
      "createdAt": "string",
      "countryCode": "string",
      "currency": "string",
      "active": "boolean",
      "balance": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| billingAccounts[] | **[BillingAccount](#yandex.cloud.billing.v1.BillingAccount)**

List of billing accounts. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBillingAccountsRequest.pageSize](#yandex.cloud.billing.v1.ListBillingAccountsRequest), use
`nextPageToken` as the value
for the [ListBillingAccountsRequest.pageToken](#yandex.cloud.billing.v1.ListBillingAccountsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## BillingAccount {#yandex.cloud.billing.v1.BillingAccount}

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
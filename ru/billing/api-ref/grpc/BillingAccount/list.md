---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/list.md
---

# Billing API, gRPC: BillingAccountService.List {#List}

Retrieves the list of billing accounts available for current user.

## gRPC request

**rpc List ([ListBillingAccountsRequest](#yandex.cloud.billing.v1.ListBillingAccountsRequest)) returns ([ListBillingAccountsResponse](#yandex.cloud.billing.v1.ListBillingAccountsResponse))**

## ListBillingAccountsRequest {#yandex.cloud.billing.v1.ListBillingAccountsRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListBillingAccountsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListBillingAccountsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
returned by a previous list request. ||
|#

## ListBillingAccountsResponse {#yandex.cloud.billing.v1.ListBillingAccountsResponse}

```json
{
  "billingAccounts": [
    {
      "id": "string",
      "name": "string",
      "createdAt": "google.protobuf.Timestamp",
      "countryCode": "string",
      "currency": "string",
      "active": "bool",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| countryCode | **string**

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
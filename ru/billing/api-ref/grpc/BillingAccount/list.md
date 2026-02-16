---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/list.md
---

# Billing API, gRPC: BillingAccountService.List

Retrieves the list of billing accounts available for current user.

## gRPC request

**rpc List ([ListBillingAccountsRequest](#yandex.cloud.billing.v1.ListBillingAccountsRequest)) returns ([ListBillingAccountsResponse](#yandex.cloud.billing.v1.ListBillingAccountsResponse))**

## ListBillingAccountsRequest {#yandex.cloud.billing.v1.ListBillingAccountsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListBillingAccountsResponse.next_page_token](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListBillingAccountsResponse.next_page_token](#yandex.cloud.billing.v1.ListBillingAccountsResponse)
returned by a previous list request. ||
|#

## ListBillingAccountsResponse {#yandex.cloud.billing.v1.ListBillingAccountsResponse}

```json
{
  "billing_accounts": [
    {
      "id": "string",
      "name": "string",
      "created_at": "google.protobuf.Timestamp",
      "country_code": "string",
      "currency": "string",
      "active": "bool",
      "balance": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| billing_accounts[] | **[BillingAccount](#yandex.cloud.billing.v1.BillingAccount)**

List of billing accounts. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBillingAccountsRequest.page_size](#yandex.cloud.billing.v1.ListBillingAccountsRequest), use
`next_page_token` as the value
for the [ListBillingAccountsRequest.page_token](#yandex.cloud.billing.v1.ListBillingAccountsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## BillingAccount {#yandex.cloud.billing.v1.BillingAccount}

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
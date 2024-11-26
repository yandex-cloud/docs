---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Customer/list.md
---

# Billing API, gRPC: CustomerService.List

Retrieves the list of customers associated with the specified reseller.

## gRPC request

**rpc List ([ListCustomersRequest](#yandex.cloud.billing.v1.ListCustomersRequest)) returns ([ListCustomersResponse](#yandex.cloud.billing.v1.ListCustomersResponse))**

## ListCustomersRequest {#yandex.cloud.billing.v1.ListCustomersRequest}

```json
{
  "reseller_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| reseller_id | **string**

Required field. ID of the reseller. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListCustomersResponse.next_page_token](#yandex.cloud.billing.v1.ListCustomersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListCustomersResponse.next_page_token](#yandex.cloud.billing.v1.ListCustomersResponse)
returned by a previous list request. ||
|#

## ListCustomersResponse {#yandex.cloud.billing.v1.ListCustomersResponse}

```json
{
  "customers": [
    {
      "id": "string",
      "billing_account_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| customers[] | **[Customer](#yandex.cloud.billing.v1.Customer)**

List of customers. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCustomersRequest.page_size](#yandex.cloud.billing.v1.ListCustomersRequest), use
`next_page_token` as the value
for the [ListCustomersRequest.page_token](#yandex.cloud.billing.v1.ListCustomersRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Customer {#yandex.cloud.billing.v1.Customer}

A Customer resource.

#|
||Field | Description ||
|| id | **string**

ID of the customer. ||
|| billing_account_id | **string**

ID of the [yandex.cloud.billing.v1.BillingAccount](/docs/billing/api-ref/grpc/BillingAccount/get#yandex.cloud.billing.v1.BillingAccount) assigned to the customer. ||
|#
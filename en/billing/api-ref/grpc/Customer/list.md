---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/Customer/list.md
---

# Billing API, gRPC: CustomerService.List {#List}

Retrieves the list of customers associated with the specified reseller.

## gRPC request

**rpc List ([ListCustomersRequest](#yandex.cloud.billing.v1.ListCustomersRequest)) returns ([ListCustomersResponse](#yandex.cloud.billing.v1.ListCustomersResponse))**

## ListCustomersRequest {#yandex.cloud.billing.v1.ListCustomersRequest}

```json
{
  "resellerId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| resellerId | **string**

Required field. ID of the reseller. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListCustomersResponse.nextPageToken](#yandex.cloud.billing.v1.ListCustomersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListCustomersResponse.nextPageToken](#yandex.cloud.billing.v1.ListCustomersResponse)
returned by a previous list request. ||
|#

## ListCustomersResponse {#yandex.cloud.billing.v1.ListCustomersResponse}

```json
{
  "customers": [
    {
      "id": "string",
      "billingAccountId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| customers[] | **[Customer](#yandex.cloud.billing.v1.Customer)**

List of customers. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCustomersRequest.pageSize](#yandex.cloud.billing.v1.ListCustomersRequest), use
`nextPageToken` as the value
for the [ListCustomersRequest.pageToken](#yandex.cloud.billing.v1.ListCustomersRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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
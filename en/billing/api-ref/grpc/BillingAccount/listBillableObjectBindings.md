---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/listBillableObjectBindings.md
---

# Billing API, gRPC: BillingAccountService.ListBillableObjectBindings

Retrieves the list of billable object bindings associated with the specified billing account.

## gRPC request

**rpc ListBillableObjectBindings ([ListBillableObjectBindingsRequest](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest)) returns ([ListBillableObjectBindingsResponse](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse))**

## ListBillableObjectBindingsRequest {#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest}

```json
{
  "billing_account_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| billing_account_id | **string**

Required field. ID of the billing account to list associated billable object bindings.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListBillableObjectBindingsResponse.next_page_token](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListBillableObjectBindingsResponse.next_page_token](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
returned by a previous list request. ||
|#

## ListBillableObjectBindingsResponse {#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse}

```json
{
  "billable_object_bindings": [
    {
      "effective_time": "google.protobuf.Timestamp",
      "billable_object": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| billable_object_bindings[] | **[BillableObjectBinding](#yandex.cloud.billing.v1.BillableObjectBinding)**

List of billable object bindings. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBillableObjectBindingsRequest.page_size](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest), use
`next_page_token` as the value
for the [ListBillableObjectBindingsRequest.page_token](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## BillableObjectBinding {#yandex.cloud.billing.v1.BillableObjectBinding}

Represents a binding of the BillableObject to a BillingAccount.

#|
||Field | Description ||
|| effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when binding was created. ||
|| billable_object | **[BillableObject](#yandex.cloud.billing.v1.BillableObject)**

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
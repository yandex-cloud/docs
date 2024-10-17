---
editable: false
sourcePath: en/_api-ref-grpc/billing/v1/api-ref/grpc/BillingAccount/listBillableObjectBindings.md
---

# Billing API, gRPC: BillingAccountService.ListBillableObjectBindings {#ListBillableObjectBindings}

Retrieves the list of billable object bindings associated with the specified billing account.

## gRPC request

**rpc ListBillableObjectBindings ([ListBillableObjectBindingsRequest](#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest)) returns ([ListBillableObjectBindingsResponse](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse))**

## ListBillableObjectBindingsRequest {#yandex.cloud.billing.v1.ListBillableObjectBindingsRequest}

```json
{
  "billingAccountId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| billingAccountId | **string**

Required field. ID of the billing account to list associated billable object bindings.
To get the billing account ID, use [BillingAccountService.List](/docs/billing/api-ref/grpc/BillingAccount/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListBillableObjectBindingsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListBillableObjectBindingsResponse.nextPageToken](#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse)
returned by a previous list request. ||
|#

## ListBillableObjectBindingsResponse {#yandex.cloud.billing.v1.ListBillableObjectBindingsResponse}

```json
{
  "billableObjectBindings": [
    {
      "effectiveTime": "google.protobuf.Timestamp",
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
|| effectiveTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when binding was created. ||
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
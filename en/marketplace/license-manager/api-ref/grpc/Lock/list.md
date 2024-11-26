---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/v1/license-manager/api-ref/grpc/Lock/list.md
---

# Yandex Cloud Marketplace License Manager, gRPC: LockService.List

Returns subscriptions locks for specified resource and folder.

## gRPC request

**rpc List ([ListLocksRequest](#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest)) returns ([ListLocksResponse](#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse))**

## ListLocksRequest {#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest}

```json
{
  "resource_id": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource that the subscription locks belong to. ||
|| folder_id | **string**

Required field. ID of the folder that the subscription locks belong to. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListLocksResponse.next_page_token](#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListLocksResponse.next_page_token](#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subscription locks listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Lock.product_id] field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `product_id="my-product-id"`. ||
|| order_by | **string**

Sorting order for the list of subscription locks. ||
|#

## ListLocksResponse {#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse}

```json
{
  "locks": [
    {
      "id": "string",
      "instance_id": "string",
      "resource_id": "string",
      "start_time": "google.protobuf.Timestamp",
      "end_time": "google.protobuf.Timestamp",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "state": "State",
      "template_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| locks[] | **[Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock)**

List of subscription locks. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListLocksRequest.page_size](#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest), use `next_page_token` as the value
for the [ListLocksRequest.page_token](#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

#|
||Field | Description ||
|| id | **string**

ID of the subscription lock. ||
|| instance_id | **string**

ID of the subscription instance. ||
|| resource_id | **string**

ID of the resource. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the start of the subscription lock. ||
|| end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the end of the subscription lock. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| state | enum **State**

Subscription lock state.

- `STATE_UNSPECIFIED`
- `UNLOCKED`: Subscription unlocked.
- `LOCKED`: Subscription locked to the resource.
- `DELETED`: Subscription lock deleted. ||
|| template_id | **string**

ID of the subscription template. ||
|#
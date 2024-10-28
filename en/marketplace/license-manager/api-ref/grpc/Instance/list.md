---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/v1/license-manager/api-ref/grpc/Instance/list.md
---

# Yandex Cloud Marketplace License Manager, gRPC: InstanceService.List {#List}

Retrieves the list of subscription instances in the specified folder.

## gRPC request

**rpc List ([ListInstancesRequest](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest)) returns ([ListInstancesResponse](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse))**

## ListInstancesRequest {#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the subscription instance belongs to. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListInstancesResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListInstancesResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subscription instances listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Instance.name] field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-subscription-instance"`. ||
|| orderBy | **string**

Sorting order for the list of subscription instances. ||
|#

## ListInstancesResponse {#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse}

```json
{
  "instances": [
    {
      "id": "string",
      "cloudId": "string",
      "folderId": "string",
      "templateId": "string",
      "templateVersionId": "string",
      "description": "string",
      "startTime": "google.protobuf.Timestamp",
      "endTime": "google.protobuf.Timestamp",
      "createdAt": "google.protobuf.Timestamp",
      "updatedAt": "google.protobuf.Timestamp",
      "state": "State",
      "locks": [
        {
          "id": "string",
          "instanceId": "string",
          "resourceId": "string",
          "startTime": "google.protobuf.Timestamp",
          "endTime": "google.protobuf.Timestamp",
          "createdAt": "google.protobuf.Timestamp",
          "updatedAt": "google.protobuf.Timestamp",
          "state": "State",
          "templateId": "string"
        }
      ],
      "licenseTemplate": {
        "id": "string",
        "versionId": "string",
        "name": "string",
        "publisherId": "string",
        "productId": "string",
        "tariffId": "string",
        "licenseSkuId": "string",
        "period": "string",
        "createdAt": "google.protobuf.Timestamp",
        "updatedAt": "google.protobuf.Timestamp",
        "state": "State"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| instances[] | **[Instance](#yandex.cloud.marketplace.licensemanager.v1.Instance)**

List of subscription instances. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListInstancesRequest.pageSize](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest), use `next_page_token` as the value
for the [ListInstancesRequest.pageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Instance {#yandex.cloud.marketplace.licensemanager.v1.Instance}

#|
||Field | Description ||
|| id | **string**

ID of the subscription instance. ||
|| cloudId | **string**

ID of the cloud that the subscription instance belongs to. ||
|| folderId | **string**

ID of the folder that the subscription instance belongs to. ||
|| templateId | **string**

ID of the subscription template that was used to create subscription instance. ||
|| templateVersionId | **string**

ID of the version of subscription template. ||
|| description | **string**

Description of the subscription instance. ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the start of the subscription. ||
|| endTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the end of the subscription. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| state | enum **State**

Subscription state.

- `STATE_UNSPECIFIED`
- `PENDING`: Subscription created but not active yet.
- `ACTIVE`: Subscription is active.
- `CANCELLED`: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.
- `EXPIRED`: Subscription expired.
- `DEPRECATED`: Subscription deprecated.
- `DELETED`: Subscription deleted. ||
|| locks[] | **[Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock)**

List of subscription locks. ||
|| licenseTemplate | **[Template](#yandex.cloud.marketplace.licensemanager.v1.Template)**

Subscription template. ||
|#

## Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

#|
||Field | Description ||
|| id | **string**

ID of the subscription lock. ||
|| instanceId | **string**

ID of the subscription instance. ||
|| resourceId | **string**

ID of the resource. ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the start of the subscription lock. ||
|| endTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the end of the subscription lock. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| state | enum **State**

Subscription lock state.

- `STATE_UNSPECIFIED`
- `UNLOCKED`: Subscription unlocked.
- `LOCKED`: Subscription locked to the resource.
- `DELETED`: Subscription lock deleted. ||
|| templateId | **string**

ID of the subscription template. ||
|#

## Template {#yandex.cloud.marketplace.licensemanager.v1.Template}

#|
||Field | Description ||
|| id | **string**

ID of the subscription template. ||
|| versionId | **string**

Version of the subscription template. ||
|| name | **string**

Name of the subscription template. ||
|| publisherId | **string**

ID of publisher. ||
|| productId | **string**

ID of product. ||
|| tariffId | **string**

ID of tariff. ||
|| licenseSkuId | **string**

ID of subscription SKU. ||
|| period | **string**

Subscription period. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| state | enum **State**

Subscription template state.

- `STATE_UNSPECIFIED`
- `PENDING`: Subscription template created but not active yet.
- `ACTIVE`: Subscription template is active.
- `DEPRECATED`: Subscription template deprecated.
- `DELETED`: Subscription template deleted. ||
|#
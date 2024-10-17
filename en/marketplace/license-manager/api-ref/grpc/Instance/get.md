---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/v1/license-manager/api-ref/grpc/Instance/get.md
---

# Yandex Cloud Marketplace License Manager, gRPC: InstanceService.Get {#Get}

Returns the specified subscription instance.

To get the list of all available subscription instances, make a [List](/docs/marketplace/license-manager/api-ref/grpc/Instance/list#List) request.

## gRPC request

**rpc Get ([GetInstanceRequest](#yandex.cloud.marketplace.licensemanager.v1.GetInstanceRequest)) returns ([Instance](#yandex.cloud.marketplace.licensemanager.v1.Instance))**

## GetInstanceRequest {#yandex.cloud.marketplace.licensemanager.v1.GetInstanceRequest}

```json
{
  "instanceId": "string"
}
```

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the subscription instance. ||
|#

## Instance {#yandex.cloud.marketplace.licensemanager.v1.Instance}

```json
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
```

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
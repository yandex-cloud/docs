---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/saas/v1/license-manager/saas/api-ref/grpc/Lock/get.md
---

# Yandex Cloud Marketplace License Manager for SaaS, gRPC: LockService.Get {#Get}

Returns the specified subscription lock.

## gRPC request

**rpc Get ([GetLockRequest](#yandex.cloud.marketplace.licensemanager.saas.v1.GetLockRequest)) returns ([licensemanager.v1.Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock))**

## GetLockRequest {#yandex.cloud.marketplace.licensemanager.saas.v1.GetLockRequest}

```json
{
  "lockId": "string"
}
```

#|
||Field | Description ||
|| lockId | **string**

Required field. ID of the subscription lock. ||
|#

## licensemanager.v1.Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

```json
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
```

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
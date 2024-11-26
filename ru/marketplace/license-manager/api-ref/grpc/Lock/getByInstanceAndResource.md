---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/v1/license-manager/api-ref/grpc/Lock/getByInstanceAndResource.md
---

# Yandex Cloud Marketplace License Manager, gRPC: LockService.GetByInstanceAndResource

Returns the subscription lock for specified subscription instance and resource.

## gRPC request

**rpc GetByInstanceAndResource ([GetLockByInstanceAndResourceRequest](#yandex.cloud.marketplace.licensemanager.v1.GetLockByInstanceAndResourceRequest)) returns ([Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock))**

## GetLockByInstanceAndResourceRequest {#yandex.cloud.marketplace.licensemanager.v1.GetLockByInstanceAndResourceRequest}

```json
{
  "instance_id": "string",
  "resource_id": "string"
}
```

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the subscription instance. ||
|| resource_id | **string**

Required field. ID of the resource to which the subscription will be locked. ||
|#

## Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

```json
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
```

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
---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/saas/v1/license-manager/saas/api-ref/grpc/Lock/getByResourceID.md
---

# Yandex Cloud Marketplace License Manager for SaaS, gRPC: LockService.GetByResourceID

Returns the subscription lock for given resource and subscription.

## gRPC request

**rpc GetByResourceID ([GetLockByResourceIDRequest](#yandex.cloud.marketplace.licensemanager.saas.v1.GetLockByResourceIDRequest)) returns ([licensemanager.v1.Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock))**

## GetLockByResourceIDRequest {#yandex.cloud.marketplace.licensemanager.saas.v1.GetLockByResourceIDRequest}

```json
{
  "resource_id": "string",
  "instance_id": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to with subscription is locked. ||
|| instance_id | **string**

Required field. ID of the subscription ||
|#

## licensemanager.v1.Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

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
  "template_id": "string",
  "external_instance": {
    "name": "string",
    "properties": "map<string, string>",
    // Includes only one of the fields `subscription`, `license`
    "subscription": {
      "subscription_id": "string",
      "license_id": "string",
      "activation_key": "string"
    },
    "license": {
      "license_id": "string",
      "payload": "bytes"
    }
    // end of the list of possible fields
  }
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
|| external_instance | **[ExternalInstance](#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance)**

External subscription instance (optional), for usage convenience propagated
from parent subscription instance. ||
|#

## ExternalInstance {#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance}

ExternalInstance attachment to external service subscription.

#|
||Field | Description ||
|| name | **string**

Optional external subscription name. ||
|| properties | **object** (map<**string**, **string**>)

Mapping of vendor defined properties in key, value format. ||
|| subscription | **[ExternalSubscription](#yandex.cloud.marketplace.licensemanager.v1.ExternalSubscription)**

Includes only one of the fields `subscription`, `license`. ||
|| license | **[ExternalLicense](#yandex.cloud.marketplace.licensemanager.v1.ExternalLicense)**

Includes only one of the fields `subscription`, `license`. ||
|#

## ExternalSubscription {#yandex.cloud.marketplace.licensemanager.v1.ExternalSubscription}

#|
||Field | Description ||
|| subscription_id | **string**

External subscription id. ||
|| license_id | **string**

Optional: paired license id for external subscription. ||
|| activation_key | **string**

Optional: default activation key for external subscription. ||
|#

## ExternalLicense {#yandex.cloud.marketplace.licensemanager.v1.ExternalLicense}

#|
||Field | Description ||
|| license_id | **string**

External license bound to subscription instance. ||
|| payload | **bytes**

License (vendor specific) payload. ||
|#
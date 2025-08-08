---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/v1/license-manager/api-ref/grpc/Instance/get.md
---

# Yandex Cloud Marketplace License Manager, gRPC: InstanceService.Get

Returns the specified subscription instance.

To get the list of all available subscription instances, make a [List](/docs/marketplace/license-manager/api-ref/grpc/Instance/list#List) request.

## gRPC request

**rpc Get ([GetInstanceRequest](#yandex.cloud.marketplace.licensemanager.v1.GetInstanceRequest)) returns ([Instance](#yandex.cloud.marketplace.licensemanager.v1.Instance))**

## GetInstanceRequest {#yandex.cloud.marketplace.licensemanager.v1.GetInstanceRequest}

```json
{
  "instance_id": "string"
}
```

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the subscription instance. ||
|#

## Instance {#yandex.cloud.marketplace.licensemanager.v1.Instance}

```json
{
  "id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "template_id": "string",
  "template_version_id": "string",
  "description": "string",
  "start_time": "google.protobuf.Timestamp",
  "end_time": "google.protobuf.Timestamp",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "state": "State",
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
  ],
  "license_template": {
    "id": "string",
    "version_id": "string",
    "name": "string",
    "publisher_id": "string",
    "product_id": "string",
    "tariff_id": "string",
    "license_sku_id": "string",
    "period": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "state": "State"
  },
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

ID of the subscription instance. ||
|| cloud_id | **string**

ID of the cloud that the subscription instance belongs to. ||
|| folder_id | **string**

ID of the folder that the subscription instance belongs to. ||
|| template_id | **string**

ID of the subscription template that was used to create subscription instance. ||
|| template_version_id | **string**

ID of the version of subscription template. ||
|| description | **string**

Description of the subscription instance. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the start of the subscription. ||
|| end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the end of the subscription. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| license_template | **[Template](#yandex.cloud.marketplace.licensemanager.v1.Template)**

Subscription template. ||
|| external_instance | **[ExternalInstance](#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance)**

External subscription instance (optional). ||
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

## Template {#yandex.cloud.marketplace.licensemanager.v1.Template}

#|
||Field | Description ||
|| id | **string**

ID of the subscription template. ||
|| version_id | **string**

Version of the subscription template. ||
|| name | **string**

Name of the subscription template. ||
|| publisher_id | **string**

ID of publisher. ||
|| product_id | **string**

ID of product. ||
|| tariff_id | **string**

ID of tariff. ||
|| license_sku_id | **string**

ID of subscription SKU. ||
|| period | **string**

Subscription period. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| state | enum **State**

Subscription template state.

- `STATE_UNSPECIFIED`
- `PENDING`: Subscription template created but not active yet.
- `ACTIVE`: Subscription template is active.
- `DEPRECATED`: Subscription template deprecated.
- `DELETED`: Subscription template deleted. ||
|#
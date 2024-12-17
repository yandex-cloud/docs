---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/create.md
---

# IoT Core Service, gRPC: DeviceService.Create

Creates a device in the specified registry.

## gRPC request

**rpc Create ([CreateDeviceRequest](#yandex.cloud.iot.devices.v1.CreateDeviceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDeviceRequest {#yandex.cloud.iot.devices.v1.CreateDeviceRequest}

```json
{
  "registry_id": "string",
  "name": "string",
  "description": "string",
  "certificates": [
    {
      "certificate_data": "string"
    }
  ],
  "topic_aliases": "map<string, string>",
  "password": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to create a device in.

To get a registry ID, make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| name | **string**

Required field. Name of the device. The name must be unique within the registry. ||
|| description | **string**

Description of the device. ||
|| certificates[] | **[Certificate](#yandex.cloud.iot.devices.v1.CreateDeviceRequest.Certificate)**

Device certificate. ||
|| topic_aliases | **object** (map<**string**, **string**>)

Alias of a device topic.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/{id}/events`. ||
|| password | **string**

Device password.

The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. ||
|#

## Certificate {#yandex.cloud.iot.devices.v1.CreateDeviceRequest.Certificate}

Specification of a device certificate.

#|
||Field | Description ||
|| certificate_data | **string**

Public part of the device certificate. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "device_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "registry_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "topic_aliases": "map<string, string>",
    "status": "Status",
    "monitoring_data": {
      "last_auth_ip": "string",
      "last_auth_time": "google.protobuf.Timestamp",
      "last_pub_activity_time": "google.protobuf.Timestamp",
      "last_sub_activity_time": "google.protobuf.Timestamp",
      "last_online_time": "google.protobuf.Timestamp"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDeviceMetadata](#yandex.cloud.iot.devices.v1.CreateDeviceMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Device](#yandex.cloud.iot.devices.v1.Device)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateDeviceMetadata {#yandex.cloud.iot.devices.v1.CreateDeviceMetadata}

#|
||Field | Description ||
|| device_id | **string**

ID of the device that is being created. ||
|#

## Device {#yandex.cloud.iot.devices.v1.Device}

A device. For more information, see [Device](/docs/iot-core/concepts/index#device).

#|
||Field | Description ||
|| id | **string**

ID of the device. ||
|| registry_id | **string**

ID of the registry that the device belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the device. The name is unique within the registry. ||
|| description | **string**

Description of the device. 0-256 characters long. ||
|| topic_aliases | **object** (map<**string**, **string**>)

Alias of a device topic.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. ||
|| status | enum **Status**

Status of the device.

- `STATUS_UNSPECIFIED`
- `CREATING`: Device is being created.
- `ACTIVE`: Device is ready to use.
- `DELETING`: Device is being deleted. ||
|| monitoring_data | **[DeviceMonitoringData](#yandex.cloud.iot.devices.v1.DeviceMonitoringData)**

Device monitoring data, returns if FULL view specified. ||
|#

## DeviceMonitoringData {#yandex.cloud.iot.devices.v1.DeviceMonitoringData}

#|
||Field | Description ||
|| last_auth_ip | **string** ||
|| last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#
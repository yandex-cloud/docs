---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/update.md
---

# IoT Core Service, gRPC: DeviceService.Update {#Update}

Updates the specified device.

## gRPC request

**rpc Update ([UpdateDeviceRequest](#yandex.cloud.iot.devices.v1.UpdateDeviceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDeviceRequest {#yandex.cloud.iot.devices.v1.UpdateDeviceRequest}

```json
{
  "deviceId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "topicAliases": "string"
}
```

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device to update.

To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/grpc/Device/list#List) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the device are going to be updated. ||
|| name | **string**

Name of the device. The name must be unique within the registry. ||
|| description | **string**

Description of the device. ||
|| topicAliases | **string**

Alias of a device topic.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/{id}/events`. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "deviceId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "registryId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "topicAliases": "string",
    "status": "Status",
    "monitoringData": {
      "lastAuthIp": "string",
      "lastAuthTime": "google.protobuf.Timestamp",
      "lastPubActivityTime": "google.protobuf.Timestamp",
      "lastSubActivityTime": "google.protobuf.Timestamp",
      "lastOnlineTime": "google.protobuf.Timestamp"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateDeviceMetadata](#yandex.cloud.iot.devices.v1.UpdateDeviceMetadata)**

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

## UpdateDeviceMetadata {#yandex.cloud.iot.devices.v1.UpdateDeviceMetadata}

#|
||Field | Description ||
|| deviceId | **string**

ID of the device that is being updated. ||
|#

## Device {#yandex.cloud.iot.devices.v1.Device}

A device. For more information, see [Device](/docs/iot-core/concepts/index#device).

#|
||Field | Description ||
|| id | **string**

ID of the device. ||
|| registryId | **string**

ID of the registry that the device belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the device. The name is unique within the registry. ||
|| description | **string**

Description of the device. 0-256 characters long. ||
|| topicAliases | **string**

Alias of a device topic.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. ||
|| status | enum **Status**

Status of the device.

- `STATUS_UNSPECIFIED`
- `CREATING`: Device is being created.
- `ACTIVE`: Device is ready to use.
- `DELETING`: Device is being deleted. ||
|| monitoringData | **[DeviceMonitoringData](#yandex.cloud.iot.devices.v1.DeviceMonitoringData)**

Device monitoring data, returns if FULL view specified. ||
|#

## DeviceMonitoringData {#yandex.cloud.iot.devices.v1.DeviceMonitoringData}

#|
||Field | Description ||
|| lastAuthIp | **string** ||
|| lastAuthTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastPubActivityTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastSubActivityTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastOnlineTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#
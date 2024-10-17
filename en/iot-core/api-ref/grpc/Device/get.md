---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/get.md
---

# IoT Core Service, gRPC: DeviceService.Get {#Get}

Returns the specified device.

To get the list of available devices, make a [List](/docs/iot-core/api-ref/grpc/Device/list#List) request.

## gRPC request

**rpc Get ([GetDeviceRequest](#yandex.cloud.iot.devices.v1.GetDeviceRequest)) returns ([Device](#yandex.cloud.iot.devices.v1.Device))**

## GetDeviceRequest {#yandex.cloud.iot.devices.v1.GetDeviceRequest}

```json
{
  "deviceId": "string",
  "deviceView": "DeviceView"
}
```

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device to return.

To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/grpc/Device/list#List) request. ||
|| deviceView | enum **DeviceView**

Specifies which parts of the device resource should be returned
in the response.

- `BASIC`: Server responses without monitoring data.
The default value.
- `FULL`: Server responses with monitoring data. ||
|#

## Device {#yandex.cloud.iot.devices.v1.Device}

```json
{
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
```

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
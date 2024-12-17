---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/getByName.md
---

# IoT Core Service, gRPC: DeviceService.GetByName

## gRPC request

**rpc GetByName ([GetByNameDeviceRequest](#yandex.cloud.iot.devices.v1.GetByNameDeviceRequest)) returns ([Device](#yandex.cloud.iot.devices.v1.Device))**

## GetByNameDeviceRequest {#yandex.cloud.iot.devices.v1.GetByNameDeviceRequest}

```json
{
  "registry_id": "string",
  "device_name": "string",
  "device_view": "DeviceView"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to get device.

To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| device_name | **string**

Required field. Name of the device to return.

To get a device name make a [DeviceService.List](/docs/iot-core/api-ref/grpc/Device/list#List) request. ||
|| device_view | enum **DeviceView**

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
```

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
---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/list.md
---

# IoT Core Service, gRPC: DeviceService.List

Retrieves the list of devices in the specified registry.

## gRPC request

**rpc List ([ListDevicesRequest](#yandex.cloud.iot.devices.v1.ListDevicesRequest)) returns ([ListDevicesResponse](#yandex.cloud.iot.devices.v1.ListDevicesResponse))**

## ListDevicesRequest {#yandex.cloud.iot.devices.v1.ListDevicesRequest}

```json
{
  // Includes only one of the fields `registry_id`, `folder_id`
  "registry_id": "string",
  "folder_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "device_view": "DeviceView"
}
```

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry to list devices in.

To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request.

Includes only one of the fields `registry_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder to list devices in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `registry_id`, `folder_id`. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDevicesResponse.next_page_token](#yandex.cloud.iot.devices.v1.ListDevicesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDevicesResponse.next_page_token](#yandex.cloud.iot.devices.v1.ListDevicesResponse) returned by a previous list request. ||
|| device_view | enum **DeviceView**

Specifies which parts of the device resource should be returned
in the response.

- `BASIC`: Server responses without monitoring data.
The default value.
- `FULL`: Server responses with monitoring data. ||
|#

## ListDevicesResponse {#yandex.cloud.iot.devices.v1.ListDevicesResponse}

```json
{
  "devices": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| devices[] | **[Device](#yandex.cloud.iot.devices.v1.Device)**

List of devices. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDevicesRequest.page_size](#yandex.cloud.iot.devices.v1.ListDevicesRequest), use `next_page_token` as the value
for the [ListDevicesRequest.page_token](#yandex.cloud.iot.devices.v1.ListDevicesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
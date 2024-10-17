---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/list.md
---

# IoT Core Service, gRPC: DeviceService.List {#List}

Retrieves the list of devices in the specified registry.

## gRPC request

**rpc List ([ListDevicesRequest](#yandex.cloud.iot.devices.v1.ListDevicesRequest)) returns ([ListDevicesResponse](#yandex.cloud.iot.devices.v1.ListDevicesResponse))**

## ListDevicesRequest {#yandex.cloud.iot.devices.v1.ListDevicesRequest}

```json
{
  // Includes only one of the fields `registryId`, `folderId`
  "registryId": "string",
  "folderId": "string",
  // end of the list of possible fields
  "pageSize": "int64",
  "pageToken": "string",
  "deviceView": "DeviceView"
}
```

#|
||Field | Description ||
|| registryId | **string**

ID of the registry to list devices in.

To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request.

Includes only one of the fields `registryId`, `folderId`. ||
|| folderId | **string**

ID of the folder to list devices in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `registryId`, `folderId`. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDevicesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDevicesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDevicesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDevicesResponse) returned by a previous list request. ||
|| deviceView | enum **DeviceView**

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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| devices[] | **[Device](#yandex.cloud.iot.devices.v1.Device)**

List of devices. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDevicesRequest.pageSize](#yandex.cloud.iot.devices.v1.ListDevicesRequest), use `next_page_token` as the value
for the [ListDevicesRequest.pageToken](#yandex.cloud.iot.devices.v1.ListDevicesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
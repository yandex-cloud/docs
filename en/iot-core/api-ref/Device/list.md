---
editable: false
apiPlayground:
  - url: https://iot-devices.{{ api-host }}/iot-devices/v1/devices
    method: get
    path: null
    query:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            ID of the registry to list devices in.
            To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/Registry/list#List) request.
            Includes only one of the fields `registryId`, `folderId`.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder to list devices in.
            To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            Includes only one of the fields `registryId`, `folderId`.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListDevicesResponse.nextPageToken](/docs/iot-core/api-ref/Device/list#yandex.cloud.iot.devices.v1.ListDevicesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListDevicesResponse.nextPageToken](/docs/iot-core/api-ref/Device/list#yandex.cloud.iot.devices.v1.ListDevicesResponse) returned by a previous list request.
          type: string
        deviceView:
          description: |-
            **enum** (DeviceView)
            Specifies which parts of the device resource should be returned
            in the response.
            - `BASIC`: Server responses without monitoring data.
            The default value.
            - `FULL`: Server responses with monitoring data.
          type: string
          enum:
            - BASIC
            - FULL
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Device/list.md
---

# IoT Core Service, REST: Device.List

Retrieves the list of devices in the specified registry.

## HTTP request

```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/devices
```

## Query parameters {#yandex.cloud.iot.devices.v1.ListDevicesRequest}

#|
||Field | Description ||
|| registryId | **string**

ID of the registry to list devices in.

To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/Registry/list#List) request.

Includes only one of the fields `registryId`, `folderId`. ||
|| folderId | **string**

ID of the folder to list devices in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

Includes only one of the fields `registryId`, `folderId`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDevicesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDevicesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDevicesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDevicesResponse) returned by a previous list request. ||
|| deviceView | **enum** (DeviceView)

Specifies which parts of the device resource should be returned
in the response.

- `BASIC`: Server responses without monitoring data.
The default value.
- `FULL`: Server responses with monitoring data. ||
|#

## Response {#yandex.cloud.iot.devices.v1.ListDevicesResponse}

**HTTP Code: 200 - OK**

```json
{
  "devices": [
    {
      "id": "string",
      "registryId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "topicAliases": "object",
      "status": "string",
      "monitoringData": {
        "lastAuthIp": "string",
        "lastAuthTime": "string",
        "lastPubActivityTime": "string",
        "lastSubActivityTime": "string",
        "lastOnlineTime": "string",
        "lastDisconnectTime": "string"
      },
      "labels": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the device. The name is unique within the registry. ||
|| description | **string**

Description of the device. 0-256 characters long. ||
|| topicAliases | **object** (map<**string**, **string**>)

Alias of a device topic.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. ||
|| status | **enum** (Status)

Status of the device.

- `STATUS_UNSPECIFIED`
- `CREATING`: Device is being created.
- `ACTIVE`: Device is ready to use.
- `DELETING`: Device is being deleted. ||
|| monitoringData | **[DeviceMonitoringData](#yandex.cloud.iot.devices.v1.DeviceMonitoringData)**

Device monitoring data, returns if FULL view specified. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|#

## DeviceMonitoringData {#yandex.cloud.iot.devices.v1.DeviceMonitoringData}

#|
||Field | Description ||
|| lastAuthIp | **string** ||
|| lastAuthTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastPubActivityTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastSubActivityTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastOnlineTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastDisconnectTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
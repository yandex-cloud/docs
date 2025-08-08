---
editable: false
apiPlayground:
  - url: https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
    method: get
    path:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of the registry to list aliases for device topic.
            To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/Registry/list#List) request.
          type: string
      required:
        - registryId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a [ListDeviceTopicAliasesResponse.nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListDeviceTopicAliasesResponse.nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Registry/listDeviceTopicAliases.md
---

# IoT Core Service, REST: Registry.ListDeviceTopicAliases

Retrieves the list of device topic aliases for the specified registry.

## HTTP request

```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list aliases for device topic.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/Registry/list#List) request. ||
|#

## Query parameters {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListDeviceTopicAliasesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDeviceTopicAliasesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse}

**HTTP Code: 200 - OK**

```json
{
  "aliases": [
    {
      "deviceId": "string",
      "topicPrefix": "string",
      "alias": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| aliases[] | **[DeviceAlias](#yandex.cloud.iot.devices.v1.DeviceAlias)**

List of device aliases for the specified registry. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDeviceTopicAliasesRequest.pageSize](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest), use `next_page_token` as the value
for the [ListDeviceTopicAliasesRequest.pageToken](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## DeviceAlias {#yandex.cloud.iot.devices.v1.DeviceAlias}

A device topic alias.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. For more information, see [Using topic aliases](/docs/iot-core/concepts/topic#aliases).

#|
||Field | Description ||
|| deviceId | **string**

ID of the device that the alias belongs to. ||
|| topicPrefix | **string**

Prefix of a canonical topic name to be aliased, e.g. `$devices/abcdef`. ||
|| alias | **string**

Alias of a device topic. ||
|#
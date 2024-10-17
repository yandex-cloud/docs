---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listDeviceTopicAliases.md
---

# IoT Core Service, gRPC: RegistryService.ListDeviceTopicAliases {#ListDeviceTopicAliases}

Retrieves the list of device topic aliases for the specified registry.

## gRPC request

**rpc ListDeviceTopicAliases ([ListDeviceTopicAliasesRequest](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest)) returns ([ListDeviceTopicAliasesResponse](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse))**

## ListDeviceTopicAliasesRequest {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest}

```json
{
  "registryId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list aliases for device topic.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListDeviceTopicAliasesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDeviceTopicAliasesResponse.nextPageToken](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse) returned by a previous list request. ||
|#

## ListDeviceTopicAliasesResponse {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse}

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
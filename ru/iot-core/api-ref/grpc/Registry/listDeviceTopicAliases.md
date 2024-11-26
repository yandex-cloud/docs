---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listDeviceTopicAliases.md
---

# IoT Core Service, gRPC: RegistryService.ListDeviceTopicAliases

Retrieves the list of device topic aliases for the specified registry.

## gRPC request

**rpc ListDeviceTopicAliases ([ListDeviceTopicAliasesRequest](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest)) returns ([ListDeviceTopicAliasesResponse](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse))**

## ListDeviceTopicAliasesRequest {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest}

```json
{
  "registry_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to list aliases for device topic.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListDeviceTopicAliasesResponse.next_page_token](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDeviceTopicAliasesResponse.next_page_token](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse) returned by a previous list request. ||
|#

## ListDeviceTopicAliasesResponse {#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesResponse}

```json
{
  "aliases": [
    {
      "device_id": "string",
      "topic_prefix": "string",
      "alias": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| aliases[] | **[DeviceAlias](#yandex.cloud.iot.devices.v1.DeviceAlias)**

List of device aliases for the specified registry. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDeviceTopicAliasesRequest.page_size](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest), use `next_page_token` as the value
for the [ListDeviceTopicAliasesRequest.page_token](#yandex.cloud.iot.devices.v1.ListDeviceTopicAliasesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## DeviceAlias {#yandex.cloud.iot.devices.v1.DeviceAlias}

A device topic alias.

Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. For more information, see [Using topic aliases](/docs/iot-core/concepts/topic#aliases).

#|
||Field | Description ||
|| device_id | **string**

ID of the device that the alias belongs to. ||
|| topic_prefix | **string**

Prefix of a canonical topic name to be aliased, e.g. `$devices/abcdef`. ||
|| alias | **string**

Alias of a device topic. ||
|#
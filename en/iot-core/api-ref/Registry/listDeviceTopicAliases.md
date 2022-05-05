---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/Registry/listDeviceTopicAliases.md
---

# Method listDeviceTopicAliases
Retrieves the list of device topic aliases for the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. ID of the registry to list aliases for device topic.  To get a registry ID make a [list](/docs/iot-core/api-ref/Registry/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
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

 
Field | Description
--- | ---
aliases[] | **object**<br><p>A device topic alias.</p> <p>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. ``my/custom/alias`` match to ``$device/abcdef/events``. For more information, see <a href="/docs/iot-core/concepts/topic#aliases">Using topic aliases</a>.</p> 
aliases[].<br>deviceId | **string**<br><p>ID of the device that the alias belongs to.</p> 
aliases[].<br>topicPrefix | **string**<br><p>Prefix of a canonical topic name to be aliased, e.g. ``$devices/abcdef``.</p> 
aliases[].<br>alias | **string**<br><p>Alias of a device topic.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 
---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Registry/listDeviceTopicAliases.md
---

# IoT Core Service, REST: Registry.listDeviceTopicAliases
Retrieves the list of device topic aliases for the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | <p>Required. ID of the registry to list aliases for device topic.</p> <p>To get a registry ID make a <a href="/docs/iot-core/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
aliases[] | **object**<br><p>List of device aliases for the specified registry.</p> 
aliases[].<br>deviceId | **string**<br><p>ID of the device that the alias belongs to.</p> 
aliases[].<br>topicPrefix | **string**<br><p>Prefix of a canonical topic name to be aliased, e.g. ``$devices/abcdef``.</p> 
aliases[].<br>alias | **string**<br><p>Alias of a device topic.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/iot-core/api-ref/Registry/listDeviceTopicAliases#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 
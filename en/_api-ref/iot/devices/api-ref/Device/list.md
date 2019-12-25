---
editable: false
---

# Method list
Retrieves the list of devices in the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | ID of the registry to list devices in.  To get a registry ID make a [list](/docs/iot-core/api-ref/Registry/list) request.  The maximum string length in characters is 50.
folderId | ID of the folder to list devices in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/iot-core/api-ref/Device/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/iot-core/api-ref/Device/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
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
      "topicAliases": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
devices[] | **object**<br><p>A device. For more information, see <a href="/docs/iot-core/concepts/index#device">Device</a>.</p> 
devices[].<br>id | **string**<br><p>ID of the device.</p> 
devices[].<br>registryId | **string**<br><p>ID of the registry that the device belongs to.</p> 
devices[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
devices[].<br>name | **string**<br><p>Name of the device. The name is unique within the registry.</p> 
devices[].<br>description | **string**<br><p>Description of the device. 0-256 characters long.</p> 
devices[].<br>topicAliases | **object**<br><p>Alias of a device topic.</p> <p>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. <code>my/custom/alias</code> match to <code>$device/abcdef/events</code>.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/api-ref/Device/list#query_params">pageSize</a>, use <code>next_page_token</code> as the value for the <a href="/docs/iot-core/api-ref/Device/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own <code>next_page_token</code> to continue paging through the results.</p> 

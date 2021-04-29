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
deviceView | Specifies which parts of the device resource should be returned in the response.<ul> <li>BASIC: Server responses without monitoring data. The default value.</li> <li>FULL: Server responses with monitoring data.</li> </ul> 
 
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
      "topicAliases": "object",
      "status": "string",
      "monitoringData": {
        "lastAuthIp": "string",
        "lastAuthTime": "string",
        "lastPubActivityTime": "string",
        "lastSubActivityTime": "string",
        "lastOnlineTime": "string"
      }
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
devices[].<br>topicAliases | **object**<br><p>Alias of a device topic.</p> <p>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`.</p> 
devices[].<br>status | **string**<br><p>Status of the device.</p> <ul> <li>CREATING: Device is being created.</li> <li>ACTIVE: Device is ready to use.</li> <li>DELETING: Device is being deleted.</li> </ul> 
devices[].<br>monitoringData | **object**<br><p>Device monitoring data, returns if FULL view specified.</p> 
devices[].<br>monitoringData.<br>lastAuthIp | **string**<br>
devices[].<br>monitoringData.<br>lastAuthTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
devices[].<br>monitoringData.<br>lastPubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
devices[].<br>monitoringData.<br>lastSubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
devices[].<br>monitoringData.<br>lastOnlineTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/api-ref/Device/list#query_params">pageSize</a>, use `next_page_token` as the value for the <a href="/docs/iot-core/api-ref/Device/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `next_page_token` to continue paging through the results.</p> 
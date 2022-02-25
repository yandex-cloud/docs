---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/Registry/list.md
---


# Method list
Retrieves the list of registries in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list registries in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/iot-core/api-ref/Registry/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/iot-core/api-ref/Registry/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
registries[] | **object**<br><p>A registry. For more information, see <a href="/docs/iot-core/concepts/index#registry">Registry</a>.</p> 
registries[].<br>id | **string**<br><p>ID of the registry.</p> 
registries[].<br>folderId | **string**<br><p>ID of the folder that the registry belongs to.</p> 
registries[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
registries[].<br>name | **string**<br><p>Name of the registry. The name is unique within the folder.</p> 
registries[].<br>description | **string**<br><p>Description of the registry. 0-256 characters long.</p> 
registries[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
registries[].<br>status | **string**<br><p>Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
registries[].<br>logGroupId | **string**<br><p>ID of the logs group for the specified registry.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/api-ref/Registry/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/iot-core/api-ref/Registry/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 
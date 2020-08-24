---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/targetGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "targetGroups": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "labels": "object",
      "targets": [
        {
          "port": "string",
          "subnetId": "string",
          "ipAddress": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
targetGroups[] | **object**<br>
targetGroups[].<br>id | **string**<br><p>Output only. ID of the target group.</p> 
targetGroups[].<br>name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
targetGroups[].<br>description | **string**<br><p>Description of the target group. 0-256 characters long.</p> 
targetGroups[].<br>folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
targetGroups[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Maximum of 64 per resource.</p> 
targetGroups[].<br>targets[] | **object**<br><p>NOTE: all endpoints must use the same address_type - either ip or hostname.</p> 
targetGroups[].<br>targets[].<br>port | **string** (int64)<br><p>Endpoint port. Takes priority over Backend::port setting.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
targetGroups[].<br>targets[].<br>subnetId | **string**<br><p>ID of the subnet that target connected to.</p> 
targetGroups[].<br>targets[].<br>ipAddress | **string**<br>
nextPageToken | **string**<br>
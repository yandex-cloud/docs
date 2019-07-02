---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/devices
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | The maximum string length in characters is 50.
folderId | The maximum string length in characters is 50.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
 
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
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
devices[] | **object**<br>
devices[].<br>id | **string**<br>
devices[].<br>registryId | **string**<br>
devices[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
devices[].<br>name | **string**<br>
devices[].<br>description | **string**<br>
nextPageToken | **string**<br>
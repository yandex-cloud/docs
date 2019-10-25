---
editable: false
---

# Method listResources

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}/resources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
infrastructureId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
      "infrastructureId": "string",
      "deploymentId": "string",
      "deploymentNumber": "string",
      "resourceSpecName": "string",
      "resourceId": "string",
      "type": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resources[] | **object**<br>
resources[].<br>infrastructureId | **string**<br>
resources[].<br>deploymentId | **string**<br>
resources[].<br>deploymentNumber | **string**<br>
resources[].<br>resourceSpecName | **string**<br>
resources[].<br>resourceId | **string**<br>
resources[].<br>type | **string**<br>
resources[].<br>status | **string**<br>
nextPageToken | **string**<br>
---
editable: false
---

# Yandex Microcosm Service, REST: Infrastructure.listResources

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}/resources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
infrastructureId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum value is 1000.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
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
resources[] | **object**
resources[].<br>infrastructureId | **string**
resources[].<br>deploymentId | **string**
resources[].<br>deploymentNumber | **string**
resources[].<br>resourceSpecName | **string**
resources[].<br>resourceId | **string**
resources[].<br>type | **string**
resources[].<br>status | **string**
nextPageToken | **string**
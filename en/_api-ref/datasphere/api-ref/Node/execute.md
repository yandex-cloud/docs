---
editable: false
---

# Method execute
Executes deployed Node.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.api.cloud.yandex.net/datasphere/v1/nodes/{nodeId}:execute
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
nodeId | ID of the Node to perform request on.
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "input": "object"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder that will be matched with Node ACL.</p> 
input | **object**<br><p>Input data for the execution.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "output": "object"
}
```

 
Field | Description
--- | ---
output | **object**<br><p>Result of the execution.</p> 
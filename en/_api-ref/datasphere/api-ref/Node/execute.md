---
editable: false
---

# DataSphere API v1, REST: Node.execute
Executes deployed Node.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.{{ api-host }}/datasphere/v1/nodes/{nodeId}:execute
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
nodeId | <p>ID of the Node to perform request on.</p> 
 
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
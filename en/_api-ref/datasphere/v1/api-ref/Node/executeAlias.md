---
editable: false
---

# Method executeAlias
Executes NodeAlias requests.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.{{ api-host }}/datasphere/v1/aliases/{aliasName}:execute
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
aliasName | <p>Name of the Alias to perform request on</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "input": "object"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder that will be matched with Alias ACL</p> 
input | **object**<br><p>Input data for the execution</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "output": "object"
}
```

 
Field | Description
--- | ---
output | **object**<br><p>Result of the execution</p> 
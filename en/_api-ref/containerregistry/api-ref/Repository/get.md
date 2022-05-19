---
editable: false
---

# Method get
Returns the specified Repository resource.
 
To get the list of available Repository resources, make a [list](/docs/container-registry/api-ref/Repository/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories/{repositoryId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
repositoryId | Required. ID of the Repository resource to return.  To get the repository ID use a [list](/docs/container-registry/api-ref/Repository/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "id": "string"
}
```
A Repository resource. For more information, see [Repository](/docs/cloud/container-registry/repository).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
id | **string**<br><p>Output only. ID of the repository.</p> 
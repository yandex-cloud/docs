---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/Repository/get.md
---

# Container Registry API, REST: Repository.get
Returns the specified Repository resource.
 
To get the list of available Repository resources, make a [list](/docs/container-registry/api-ref/Repository/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories/{repositoryId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
repositoryId | <p>Required. ID of the Repository resource to return.</p> <p>To get the repository ID use a <a href="/docs/container-registry/api-ref/Repository/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "id": "string"
}
```
A Repository resource. For more information, see [Repository](/docs/container-registry/concepts/repository).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
id | **string**<br><p>Output only. ID of the repository.</p> 
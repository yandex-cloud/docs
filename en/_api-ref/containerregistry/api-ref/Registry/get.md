---
editable: false
---

# Method get
Returns the specified Registry resource.
 
To get the list of available Registry resources, make a [list](/docs/container-registry/api-ref/Registry/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/registries/{registryId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. ID of the Registry resource to return.  To get the registry ID use a [list](/docs/container-registry/api-ref/Registry/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "status": "string",
  "createdAt": "string",
  "labels": "object"
}
```
A Registry resource. For more information, see [Registry](/docs/cloud/containerregistry/registry).
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the registry.</p> 
folderId | **string**<br><p>ID of the folder that the registry belongs to.</p> 
name | **string**<br><p>Name of the registry.</p> 
status | **string**<br><p>Output only. Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs. Мaximum of 64 per resource.</p> 
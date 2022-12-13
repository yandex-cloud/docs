---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/Registry/listIpPermission.md
---

# Container Registry API, REST: Registry.listIpPermission
List ip permissions for the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/registries/{registryId}:listIpPermission
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | <p>Required. ID of the Registry to return ip permission list.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "permissions": [
    {
      "action": "string",
      "ip": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
permissions[] | **object**<br><p>List of ip permissions for registry</p> 
permissions[].<br>action | **string**
permissions[].<br>ip | **string**
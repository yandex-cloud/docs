---
editable: false
sourcePath: en/_api-ref/cdn/api-ref/Resource/getProviderCName.md
---


# Method getProviderCName
Get Provider's CNAME (edge endpoint) bind to specified folder id.
Returns UNIMPLEMENTED error, if provider doesn't support CNAME request.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/cname/{folderId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | Required. Folder ID to get provider's CNAME.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "cname": "string",
  "folderId": "string"
}
```

 
Field | Description
--- | ---
cname | **string**<br><p>Provider's CNAME.</p> 
folderId | **string**<br><p>ID of the folder that the provider belongs to.</p> 
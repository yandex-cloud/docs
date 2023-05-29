---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/Provider/listActivated.md
---

# Cloud CDN API, REST: Provider.listActivated
List activated providers for specified client.
 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/providers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the activate provider belongs to.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "providers": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
providers[] | **string**<br><p>Creates a list of providers.</p> 
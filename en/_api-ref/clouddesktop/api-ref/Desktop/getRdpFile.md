---
editable: false
---

# Method getRdpFile
Returns a RDP file for the specified desktop.
 

 
## HTTP request {#https-request}
```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}:getRdpFile
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopId | Required. ID of the desktop resource to return.  To get the desktop ID use a [list](/docs/cloud-desktop/api-ref/Desktop/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
user.subjectId | Required. Identity of the access binding.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "headers": "object",
  "content": "string"
}
```

 
Field | Description
--- | ---
headers | **object**<br><p>HTTP headers mapping.</p> 
content | **string**<br><p>RDP file content.</p> 
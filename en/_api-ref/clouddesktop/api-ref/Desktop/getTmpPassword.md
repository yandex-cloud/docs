---
editable: false
---

# Method getTmpPassword
Returns temporary password for the specified desktop.
 

 
## HTTP request {#https-request}
```
GET https://cloud-desktop.api.cloud.yandex.net/cloud-desktop/v1/desktops/{desktopId}:getTmpPassword
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopId | Required. ID of the desktop.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
subjectId | User of the desktop.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "password": "string"
}
```

 
Field | Description
--- | ---
password | **string**<br><p>Desktop user password.</p> 
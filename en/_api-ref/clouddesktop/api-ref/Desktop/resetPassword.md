---
editable: false
---

# Method resetPassword
Reset password
 

 
## HTTP request {#https-request}
```
POST https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}:resetPassword
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopId | <p>Required. ID of the desktop.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "user": {
    "subjectId": "string"
  }
}
```

 
Field | Description
--- | ---
user | **object**<br><p>Required. User of the desktop.</p> 
user.<br>subjectId | **string**<br><p>Required. Identity of the access binding.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "password": "string"
}
```

 
Field | Description
--- | ---
password | **string**<br><p>Generated password</p> 
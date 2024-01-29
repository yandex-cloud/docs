---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/getProfile.md
---

# Cloud Organization API, REST: OsLogin.getProfile
OsLogin Profiles
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles/{osLoginProfileId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
osLoginProfileId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "organizationId": "string",
  "subjectId": "string",
  "login": "string",
  "uid": "string",
  "isDefault": true,
  "homeDirectory": "string",
  "shell": "string"
}
```

 
Field | Description
--- | ---
id | **string**
organizationId | **string**
subjectId | **string**
login | **string**
uid | **string** (int64)
isDefault | **boolean** (boolean)
homeDirectory | **string**
shell | **string**
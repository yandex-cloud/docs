---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/getSettings.md
---

# Cloud Organization API, REST: OsLogin.getSettings
OsLogin settings
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}/osLoginSettings
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "userSshKeySettings": {
    "enabled": true,
    "allowManageOwnKeys": true
  },
  "sshCertificateSettings": {
    "enabled": true
  }
}
```

 
Field | Description
--- | ---
userSshKeySettings | **object**
userSshKeySettings.<br>enabled | **boolean** (boolean)
userSshKeySettings.<br>allowManageOwnKeys | **boolean** (boolean)
sshCertificateSettings | **object**
sshCertificateSettings.<br>enabled | **boolean** (boolean)
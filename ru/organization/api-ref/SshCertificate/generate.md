---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/SshCertificate/generate.md
---

# Cloud Organization API, REST: SshCertificate.generate
Members of an organization can generate certificates for themselves
Signing certificates for other users requires a special permission
 

 
## HTTP request {#https-request}
```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/sshCertificates:generate
```
 
## Body parameters {#body_params}
 
```json 
{
  "publicKey": "string",

  //  includes only one of the fields `subjectId`, `osLogin`
  "cloudId": "string",
  "organizationId": "string",
  // end of the list of possible fields

  "subjectId": "string",
  "osLogin": "string"
}
```

 
Field | Description
--- | ---
publicKey | **string**<br><p>Required. The maximum string length in characters is 15000.</p> 
cloudId | **string** <br> includes only one of the fields `cloudId`, `organizationId`<br><br><p>The maximum string length in characters is 50.</p> 
organizationId | **string** <br> includes only one of the fields `cloudId`, `organizationId`<br><br><p>The maximum string length in characters is 50.</p> 
subjectId | **string** <br> includes only one of the fields `subjectId`, `osLogin`<br><br><p>The maximum string length in characters is 50.</p> 
osLogin | **string** <br> includes only one of the fields `subjectId`, `osLogin`<br><br><p>The maximum string length in characters is 32.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "signedCertificate": "string"
}
```

 
Field | Description
--- | ---
signedCertificate | **string**<br><p>as per specification https://cvsweb.openbsd.org/src/usr.bin/ssh/PROTOCOL.certkeys?annotate=HEAD</p> 
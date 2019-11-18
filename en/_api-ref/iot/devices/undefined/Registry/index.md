---
editable: false
---

# Registry

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "logGroupId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>
status | **string**<br>
logGroupId | **string**<br>

## Methods {#methods}
Method | Description
--- | ---
[addCertificate](addCertificate.md) | 
[addPassword](addPassword.md) | 
[create](create.md) | 
[delete](delete.md) | 
[deleteCertificate](deleteCertificate.md) | 
[deletePassword](deletePassword.md) | 
[get](get.md) | 
[list](list.md) | 
[listCertificates](listCertificates.md) | 
[listDeviceTopicAliases](listDeviceTopicAliases.md) | 
[listOperations](listOperations.md) | 
[listPasswords](listPasswords.md) | 
[update](update.md) | 
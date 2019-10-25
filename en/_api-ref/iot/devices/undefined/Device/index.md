---
editable: false
---

# Device

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "topicAliases": "object"
}
```
 
Field | Description
--- | ---
id | **string**<br>
registryId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
topicAliases | **object**<br><p>map from alias to canonical topic name prefix, e.g. my/custom/alias -&gt; $device/abcdef/events</p> 

## Methods {#methods}
Method | Description
--- | ---
[addCertificate](addCertificate.md) | 
[create](create.md) | 
[delete](delete.md) | 
[deleteCertificate](deleteCertificate.md) | 
[get](get.md) | 
[list](list.md) | 
[listCertificates](listCertificates.md) | 
[listOperations](listOperations.md) | 
[update](update.md) | 
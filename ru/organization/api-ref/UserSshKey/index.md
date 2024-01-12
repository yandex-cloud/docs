---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/UserSshKey/index.md
---

# Cloud Organization API, REST: UserSshKey methods

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "subjectId": "string",
  "data": "string",
  "name": "string",
  "fingerprint": "string",
  "organizationId": "string",
  "createdAt": "string",
  "expiresAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**
subjectId | **string**
data | **string**
name | **string**
fingerprint | **string**
organizationId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
expiresAt | **string** (date-time)<br><p>Used for temporary keys, if empty the key doesn't expire</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[list](list.md) | 
[update](update.md) | 
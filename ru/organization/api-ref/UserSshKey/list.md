---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/UserSshKey/list.md
---

# Cloud Organization API, REST: UserSshKey.list

 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/userSshKeys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. The maximum string length in characters is 50.</p> 
subjectId | <p>The maximum string length in characters is 50.</p> 
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "sshKeys": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
sshKeys[] | **object**
sshKeys[].<br>id | **string**
sshKeys[].<br>subjectId | **string**
sshKeys[].<br>data | **string**
sshKeys[].<br>name | **string**
sshKeys[].<br>fingerprint | **string**
sshKeys[].<br>organizationId | **string**
sshKeys[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
sshKeys[].<br>expiresAt | **string** (date-time)<br><p>Used for temporary keys, if empty the key doesn't expire</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**
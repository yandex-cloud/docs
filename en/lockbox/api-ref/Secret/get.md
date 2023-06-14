---
editable: false
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/get.md
---

# Lockbox API, REST: Secret.get
Returns the specified secret.
 
To get the list of all available secrets, make a [list](/docs/lockbox/api-ref/Secret/list) request.
Use [get](/docs/lockbox/api-ref/Payload/get) to get the payload (confidential data themselves) of the secret.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | <p>Required. ID of the secret to return.</p> <p>To get a secret ID make a [List] request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "kmsKeyId": "string",
  "status": "string",
  "currentVersion": {
    "id": "string",
    "secretId": "string",
    "createdAt": "string",
    "destroyAt": "string",
    "description": "string",
    "status": "string",
    "payloadEntryKeys": [
      "string"
    ]
  },
  "deletionProtection": true
}
```
A secret that may contain several versions of the payload.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the secret.</p> 
folderId | **string**<br><p>ID of the folder that the secret belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the secret.</p> 
description | **string**<br><p>Description of the secret.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key.</p> 
kmsKeyId | **string**<br><p>Optional ID of the KMS key will be used to encrypt and decrypt the secret.</p> 
status | **string**<br><p>Status of the secret.</p> <ul> <li> <p>CREATING: The secret is being created.</p> </li> <li> <p>ACTIVE: The secret is active and the secret payload can be accessed.</p> <p>Can be set to INACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> <li> <p>INACTIVE: The secret is inactive and unusable.</p> <p>Can be set to ACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> </ul> 
currentVersion | **object**<br><p>Current (i.e. the ``latest``) version of the secret.</p> 
currentVersion.<br>id | **string**<br><p>ID of the version.</p> 
currentVersion.<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
currentVersion.<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
currentVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
currentVersion.<br>description | **string**<br><p>Description of the version.</p> 
currentVersion.<br>status | **string**<br><p>Status of the secret.</p> <ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 
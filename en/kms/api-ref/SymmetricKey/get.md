---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricKey/get.md
---

# Key Management Service API, REST: SymmetricKey.get
Returns the specified symmetric KMS key.
 
To get the list of available symmetric KMS keys, make a [list](/docs/kms/api-ref/SymmetricKey/list) request.
 
## HTTP request {#https-request}
```
GET https://kms.{{ api-host }}/kms/v1/keys/{keyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the symmetric KMS key to return. To get the ID of a symmetric KMS key use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "status": "string",
  "primaryVersion": {
    "id": "string",
    "keyId": "string",
    "status": "string",
    "algorithm": "string",
    "createdAt": "string",
    "primary": true,
    "destroyAt": "string",
    "hostedByHsm": true
  },
  "defaultAlgorithm": "string",
  "rotatedAt": "string",
  "rotationPeriod": "string",
  "deletionProtection": true
}
```
A symmetric KMS key that may contain several versions of the cryptographic material.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the key.</p> 
folderId | **string**<br><p>ID of the folder that the key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the key was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the key.</p> 
description | **string**<br><p>Description of the key.</p> 
labels | **object**<br><p>Custom labels for the key as ``key:value`` pairs. Maximum 64 per key.</p> 
status | **string**<br><p>Current status of the key.</p> <ul> <li>CREATING: The key is being created.</li> <li>ACTIVE: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> <li>INACTIVE: The key is inactive and unusable. Can be set to ACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> </ul> 
primaryVersion | **object**<br><p>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified.</p> <p>Symmetric KMS key version: metadata about actual cryptographic data.</p> 
primaryVersion.<br>id | **string**<br><p>ID of the key version.</p> 
primaryVersion.<br>keyId | **string**<br><p>ID of the symmetric KMS key that the version belongs to.</p> 
primaryVersion.<br>status | **string**<br><p>Status of the key version.</p> <p>Possible version status.</p> <ul> <li>ACTIVE: The version is active and can be used for encryption and decryption.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
primaryVersion.<br>algorithm | **string**<br><p>Encryption algorithm that should be used when using the key version to encrypt plaintext.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> <li>AES_256_HSM: AES algorithm with 256-bit keys hosted by HSM</li> </ul> 
primaryVersion.<br>createdAt | **string** (date-time)<br><p>Time when the key version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
primaryVersion.<br>primary | **boolean** (boolean)<br><p>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified.</p> 
primaryVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the key version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
primaryVersion.<br>hostedByHsm | **boolean** (boolean)<br><p>Indication of the version that is hosted by HSM.</p> 
defaultAlgorithm | **string**<br><p>Default encryption algorithm to be used with new versions of the key.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> <li>AES_256_HSM: AES algorithm with 256-bit keys hosted by HSM</li> </ul> 
rotatedAt | **string** (date-time)<br><p>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
rotationPeriod | **string**<br><p>Time period between automatic key rotations.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the key</p> 
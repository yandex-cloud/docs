---
editable: false
---

# Method reEncrypt
Re-encrypts previously encrypted text with the new key
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:reEncrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. Target key id  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | Target key version id, optional, defaults to primary  The maximum string length in characters is 50.
aadContext | Target additional authenticated data, optional  The maximum string length in characters is 8192.
sourceKeyId | Required. Source key id, may be equal to target key id  The maximum string length in characters is 50.
sourceAadContext | Source add-context, may differ from target add-context  The maximum string length in characters is 8192.
ciphertext | Required. Encrypted text to re-encrypt
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "versionId": "string",
  "sourceKeyId": "string",
  "sourceVersionId": "string",
  "ciphertext": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>Target key id</p> 
versionId | **string**<br><p>ID of target key version used for encryption</p> 
sourceKeyId | **string**<br><p>Source key id</p> 
sourceVersionId | **string**<br><p>ID of source key version used for decryption</p> 
ciphertext | **string** (byte)<br><p>Re-encrypted text</p> 
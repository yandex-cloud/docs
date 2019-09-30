---
editable: false
---

# Method encrypt
Encrypts given plaintext with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:encrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the KMS key to use for encryption.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | ID of the key version to encrypt plaintext with. Defaults to the primary version if not specified.  The maximum string length in characters is 50.
aadContext | Additional authentication data, if necessary. If specified, this data will be required for decryption with the SymmetricDecryptRequest.  The maximum string length in characters is 8192.
plaintext | Required. Text to be encrypted.  The maximum string length in characters is 32768.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "versionId": "string",
  "ciphertext": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>Required. ID of the KMS key that was used for encryption.</p> <p>The maximum string length in characters is 50.</p>
versionId | **string**<br><p>ID of the key version that was used for encryption.</p> <p>The maximum string length in characters is 50.</p>
ciphertext | **string** (byte)<br><p>Resulting encrypted text.</p>
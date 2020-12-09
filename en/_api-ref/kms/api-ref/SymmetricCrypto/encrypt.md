---
editable: false
---

# Method encrypt
Encrypts given plaintext with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://kms.yandex/kms/v1/keys/{keyId}:encrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the symmetric KMS key to use for encryption.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "versionId": "string",
  "aadContext": "string",
  "plaintext": "string"
}
```

 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the key version to encrypt plaintext with. Defaults to the primary version if not specified.</p> <p>The maximum string length in characters is 50.</p> 
aadContext | **string** (byte)<br><p>Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the `SymmetricDecryptRequest`. Should be encoded with base64.</p> <p>The maximum string length in characters is 8192.</p> 
plaintext | **string** (byte)<br><p>Required. Plaintext to be encrypted. Should be encoded with base64.</p> <p>The maximum string length in characters is 32768.</p> 
 
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
keyId | **string**<br><p>Required. ID of the symmetric KMS key that was used for encryption.</p> <p>The maximum string length in characters is 50.</p> 
versionId | **string**<br><p>ID of the key version that was used for encryption.</p> <p>The maximum string length in characters is 50.</p> 
ciphertext | **string** (byte)<br><p>Resulting ciphertext.</p> 
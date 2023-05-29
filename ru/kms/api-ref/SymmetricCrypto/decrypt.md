---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricCrypto/decrypt.md
---

# Key Management Service API, REST: SymmetricCrypto.decrypt
Decrypts the given ciphertext with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://kms.{{ api-host }}/kms/v1/keys/{keyId}:decrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the symmetric KMS key to use for decryption.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "aadContext": "string",
  "ciphertext": "string"
}
```

 
Field | Description
--- | ---
aadContext | **string** (byte)<br><p>Additional authenticated data, must be the same as was provided in the corresponding ``SymmetricEncryptRequest``. Should be encoded with base64.</p> <p>The maximum string length in characters is 8192.</p> 
ciphertext | **string** (byte)<br><p>Required. Ciphertext to be decrypted. Should be encoded with base64.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "versionId": "string",
  "plaintext": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>ID of the symmetric KMS key that was used for decryption.</p> 
versionId | **string**<br><p>ID of the key version that was used for decryption.</p> 
plaintext | **string** (byte)<br><p>Decrypted plaintext.</p> 
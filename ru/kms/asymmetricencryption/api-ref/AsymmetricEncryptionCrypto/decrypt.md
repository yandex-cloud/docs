---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/decrypt.md
---

# Key Management Service API, REST: AsymmetricEncryptionCrypto.decrypt
Decrypts the given ciphertext with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-kms }}/kms/v1/asymmetricEncryptionKeys/{keyId}:decrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the asymmetric KMS key to use for decryption.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "ciphertext": "string"
}
```

 
Field | Description
--- | ---
ciphertext | **string** (byte)<br><p>Required. Ciphertext to be decrypted. Should be encoded with base64.</p> <p>The maximum string length in characters is 32768.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "plaintext": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>ID of the asymmetric KMS key that was used for decryption.</p> 
plaintext | **string** (byte)<br><p>Decrypted plaintext.</p> 
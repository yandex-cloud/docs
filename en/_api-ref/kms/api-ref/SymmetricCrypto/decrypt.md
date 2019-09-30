---
editable: false
---

# Method decrypt
Decrypts the given ciphertext with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:decrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the KMS key to use for decryption.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
aadContext | Additional authentication data, must be the same as was provided in the corresponding SymmetricEncryptRequest.  The maximum string length in characters is 8192.
ciphertext | Required. Encrypted text to be decrypted.
 
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
keyId | **string**<br><p>ID of the KMS key that was used for decryption.</p>
versionId | **string**<br><p>ID of the key version that was used for decryption.</p>
plaintext | **string** (byte)<br><p>Resulting decrypted text.</p>
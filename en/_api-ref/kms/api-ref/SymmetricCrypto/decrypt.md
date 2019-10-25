---
editable: false
---

# Method decrypt
Decrypts given ciphertext
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:decrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
aadContext | Additional authenticated data, same as in corresponding EncryptRequest  The maximum string length in characters is 8192.
ciphertext | Required. Encrypted text to be decrypted
 
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
keyId | **string**<br>
versionId | **string**<br><p>The version was used for decryption</p> 
plaintext | **string** (byte)<br><p>Decrypted text</p> 
---
editable: false
---

# Method encrypt
Encrypts given plaintext with specified key
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:encrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | Version ID, defaults to primary version if not given  The maximum string length in characters is 50.
aadContext | Additional authenticated data, optional  The maximum string length in characters is 8192.
plaintext | Required. Plaintext to be encrypted  The maximum string length in characters is 4096.
 
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
keyId | **string**<br>
versionId | **string**<br><p>The version was used for encryption</p> 
ciphertext | **string** (byte)<br><p>Encrypted text</p> 
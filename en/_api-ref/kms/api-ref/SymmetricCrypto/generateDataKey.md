---
editable: false
---

# Method generateDataKey
Generates new symmetric DATA encryption key, encrypts it and returns to the caller
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:generateDataKey
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | Version ID, defaults to primary version if not given  The maximum string length in characters is 50.
aadContext | Additional authenticated data to be used by encryption algorithm (optional)  The maximum string length in characters is 8192.
dataKeySpec | Encryption algorithm create data key for<p>Supported symmetric encryption algorithms</p> 
skipPlaintext | Plaintext for data key won't be returned if this parameter is true
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "versionId": "string",
  "dataKeyPlaintext": "string",
  "dataKeyCiphertext": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br>
versionId | **string**<br><p>The key version used to encrypt data key</p> 
dataKeyPlaintext | **string** (byte)<br><p>Data key in plaintext or empty</p> 
dataKeyCiphertext | **string** (byte)<br><p>Ciphered data key</p> 
---
editable: false
---

# Method reEncrypt
Re-encrypts a ciphertext with the specified KMS key.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:reEncrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the new key to be used for encryption.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "versionId": "string",
  "aadContext": "string",
  "sourceKeyId": "string",
  "sourceAadContext": "string",
  "ciphertext": "string"
}
```

 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the version of the new key to be used for encryption. Defaults to the primary version if not specified.</p> <p>The maximum string length in characters is 50.</p> 
aadContext | **string** (byte)<br><p>Additional authenticated data to be required for decryption. Should be encoded with base64.</p> <p>The maximum string length in characters is 8192.</p> 
sourceKeyId | **string**<br><p>Required. ID of the key that the ciphertext is currently encrypted with. May be the same as for the new key.</p> <p>The maximum string length in characters is 50.</p> 
sourceAadContext | **string** (byte)<br><p>Additional authenticated data provided with the initial encryption request. Should be encoded with base64.</p> <p>The maximum string length in characters is 8192.</p> 
ciphertext | **string** (byte)<br><p>Required. Ciphertext to re-encrypt. Should be encoded with base64.</p> 
 
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
keyId | **string**<br><p>ID of the key that the ciphertext is encrypted with now.</p> 
versionId | **string**<br><p>ID of key version that was used for encryption.</p> 
sourceKeyId | **string**<br><p>ID of the key that the ciphertext was encrypted with previously.</p> 
sourceVersionId | **string**<br><p>ID of the key version that was used to decrypt the re-encrypted ciphertext.</p> 
ciphertext | **string** (byte)<br><p>Resulting re-encrypted ciphertext.</p> 
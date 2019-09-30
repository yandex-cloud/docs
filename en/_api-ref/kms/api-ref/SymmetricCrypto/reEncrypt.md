---
editable: false
---

# Method reEncrypt
Re-encrypts previously encrypted text with the specified key.
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:reEncrypt
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the new key to be used for encryption.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | ID of the version of the new key to be used for encryption. Defaults to the primary version if not specified.  The maximum string length in characters is 50.
aadContext | Additional authentication data to be required for decryption.  The maximum string length in characters is 8192.
sourceKeyId | Required. ID of the key that the text is currently encrypted with. May be the same as for the new key.  The maximum string length in characters is 50.
sourceAadContext | Authentication data provided with the initial encryption request.  The maximum string length in characters is 8192.
ciphertext | Required. Encrypted text to re-encrypt.
 
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
keyId | **string**<br><p>ID of the key that the text is encrypted with now.</p>
versionId | **string**<br><p>ID of key version that was used for encryption.</p>
sourceKeyId | **string**<br><p>ID of the key that the text was encrypted with previously.</p>
sourceVersionId | **string**<br><p>ID of the key version that was used to decrypt the re-encrypted text.</p>
ciphertext | **string** (byte)<br><p>Resulting re-encrypted text.</p>
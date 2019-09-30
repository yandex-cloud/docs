---
editable: false
---

# Method generateDataKey
Generates a new symmetric data encryption key and returns this data key
in plain text, and encrypted with the specified KMS key.
 

 
## HTTP request {#https-request}
```
POST https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}:generateDataKey
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the KMS key that the generated data key should be encrypted with.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | ID of the key version to encrypt the data key with. Defaults to the primary version if not specified.  The maximum string length in characters is 50.
aadContext | Additional authentication data, if necessary. If specified, this data will be required for decryption with the SymmetricDecryptRequest.  The maximum string length in characters is 8192.
dataKeySpec | Encryption algorithm and key length for the data key.<p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> </ul>
skipPlaintext | If `true`, the method won't return the data key in plain text. Default value is `false`.
 
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
keyId | **string**<br><p>ID of the KMS key that was used to encrypt the generated data key.</p>
versionId | **string**<br><p>ID of the key version that was used for encryption.</p>
dataKeyPlaintext | **string** (byte)<br><p>Generated data key in plain text. The field is empty, if the <a href="/docs/kms/api-ref/SymmetricCrypto/generateDataKey#query_params">skipPlaintext</a> parameter was set to <code>true</code>.</p>
dataKeyCiphertext | **string** (byte)<br><p>The encrypted data key.</p>
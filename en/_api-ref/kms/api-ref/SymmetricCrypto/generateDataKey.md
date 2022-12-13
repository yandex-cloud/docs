---
editable: false
---

# Key Management Service API, REST: SymmetricCrypto.generateDataKey
Generates a new symmetric data encryption key (not a KMS key) and returns
the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-kms-symcrypto }}/kms/v1/keys/{keyId}:generateDataKey
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the symmetric KMS key that the generated data key should be encrypted with.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "versionId": "string",
  "aadContext": "string",
  "dataKeySpec": "string",
  "skipPlaintext": true
}
```

 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the key version to encrypt the generated data key with. Defaults to the primary version if not specified.</p> <p>The maximum string length in characters is 50.</p> 
aadContext | **string** (byte)<br><p>Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the ``SymmetricDecryptRequest``. Should be encoded with base64.</p> <p>The maximum string length in characters is 8192.</p> 
dataKeySpec | **string**<br><p>Encryption algorithm and key length for the generated data key.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> <li>AES_256_HSM: AES algorithm with 256-bit keys hosted by HSM</li> </ul> 
skipPlaintext | **boolean** (boolean)<br><p>If ``true``, the method won't return the data key as plaintext. Default value is ``false``.</p> 
 
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
keyId | **string**<br><p>ID of the symmetric KMS key that was used to encrypt the generated data key.</p> 
versionId | **string**<br><p>ID of the key version that was used for encryption.</p> 
dataKeyPlaintext | **string** (byte)<br><p>Generated data key as plaintext. The field is empty, if the <a href="/docs/kms/api-ref/SymmetricCrypto/generateDataKey#body_params">skipPlaintext</a> parameter was set to ``true``.</p> 
dataKeyCiphertext | **string** (byte)<br><p>The encrypted data key.</p> 
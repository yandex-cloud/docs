---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureCrypto/getPublicKey.md
---

# Key Management Service API, REST: AsymmetricSignatureCrypto.getPublicKey
Gets value of public key.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}/publicKey
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the asymmetric KMS key to be used for public key retrieval.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "publicKey": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>ID of the asymmetric KMS key to get public key of.</p> 
publicKey | **string**<br><p>Public key value. The value is a PEM-encoded X.509 public key, also known as SubjectPublicKeyInfo (SPKI), as defined in RFC 5280.</p> 
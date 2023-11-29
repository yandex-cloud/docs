---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureCrypto/signHash.md
---

# Key Management Service API, REST: AsymmetricSignatureCrypto.signHash
Signs hash value specified KMS key.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}:signHash
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the asymmetric KMS key to use for signature.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "hash": "string"
}
```

 
Field | Description
--- | ---
hash | **string** (byte)<br><p>Required. Hash value to be signed. Should be encoded with base64.</p> <p>The maximum string length in characters is 4096.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyId": "string",
  "signature": "string"
}
```

 
Field | Description
--- | ---
keyId | **string**<br><p>ID of the asymmetric KMS key that was used for signature.</p> 
signature | **string** (byte)<br><p>Value of signature. Signature value is produced in accordance with RFC 8017 for RSA and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA.</p> 
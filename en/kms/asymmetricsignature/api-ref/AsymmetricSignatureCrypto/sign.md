---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureCrypto/sign.md
---

# Key Management Service API, REST: AsymmetricSignatureCrypto.sign
Signs data specified KMS key.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}:sign
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the asymmetric KMS key to use for signature.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "message": "string"
}
```

 
Field | Description
--- | ---
message | **string** (byte)<br><p>Required. Message to sign. Should be encoded with base64.</p> <p>The maximum string length in characters is 32768.</p> 
 
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
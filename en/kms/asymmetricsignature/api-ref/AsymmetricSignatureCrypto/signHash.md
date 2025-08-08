---
editable: false
apiPlayground:
  - url: https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}:signHash
    method: post
    path:
      type: object
      properties:
        keyId:
          description: |-
            **string**
            Required field. ID of the asymmetric KMS key to use for signature.
          type: string
      required:
        - keyId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        hash:
          description: |-
            **string** (bytes)
            Required field. Hash value to be signed.
            Should be encoded with base64.
          type: string
          format: bytes
      required:
        - hash
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureCrypto/signHash.md
---

# Key Management Service API, REST: AsymmetricSignatureCrypto.SignHash

Signs hash value specified KMS key.

## HTTP request

```
POST https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}:signHash
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to use for signature. ||
|#

## Body parameters {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashRequest}

```json
{
  "hash": "string"
}
```

#|
||Field | Description ||
|| hash | **string** (bytes)

Required field. Hash value to be signed.
Should be encoded with base64. ||
|#

## Response {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashResponse}

**HTTP Code: 200 - OK**

```json
{
  "keyId": "string",
  "signature": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the asymmetric KMS key that was used for signature. ||
|| signature | **string** (bytes)

Value of signature.
Signature value is produced in accordance with RFC 8017 for RSA
and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA. ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/signHash.md
---

# Key Management Service API, gRPC: AsymmetricSignatureCryptoService.SignHash {#SignHash}

Signs hash value specified KMS key.

## gRPC request

**rpc SignHash ([AsymmetricSignHashRequest](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashRequest)) returns ([AsymmetricSignHashResponse](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashResponse))**

## AsymmetricSignHashRequest {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashRequest}

```json
{
  "keyId": "string",
  "hash": "bytes"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to use for signature. ||
|| hash | **bytes**

Required field. Hash value to be signed.
Should be encoded with base64. ||
|#

## AsymmetricSignHashResponse {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignHashResponse}

```json
{
  "keyId": "string",
  "signature": "bytes"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the asymmetric KMS key that was used for signature. ||
|| signature | **bytes**

Value of signature.
Signature value is produced in accordance with RFC 8017 for RSA
and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA. ||
|#
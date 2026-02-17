---
editable: false
---

# Key Management Service API, gRPC: AsymmetricSignatureCryptoService.Sign

Signs data specified KMS key.

## gRPC request

**rpc Sign ([AsymmetricSignRequest](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignRequest)) returns ([AsymmetricSignResponse](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignResponse))**

## AsymmetricSignRequest {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignRequest}

```json
{
  "key_id": "string",
  "message": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the asymmetric KMS key to use for signature.

The maximum string length in characters is 50. ||
|| message | **bytes**

Required field. Message to sign.
Should be encoded with base64.

The maximum string length in characters is 32768. ||
|#

## AsymmetricSignResponse {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignResponse}

```json
{
  "key_id": "string",
  "signature": "bytes"
}
```

#|
||Field | Description ||
|| key_id | **string**

ID of the asymmetric KMS key that was used for signature. ||
|| signature | **bytes**

Value of signature.
Signature value is produced in accordance with RFC 8017 for RSA
and is a DER-encoded object as defined by ANSI X9.62-2005 and RFC 3279 Section 2.2.3 for ECDSA. ||
|#
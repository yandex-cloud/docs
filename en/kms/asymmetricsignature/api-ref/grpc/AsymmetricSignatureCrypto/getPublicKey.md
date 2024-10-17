---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/getPublicKey.md
---

# Key Management Service API, gRPC: AsymmetricSignatureCryptoService.GetPublicKey {#GetPublicKey}

Gets value of public key.

## gRPC request

**rpc GetPublicKey ([AsymmetricGetPublicKeyRequest](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricGetPublicKeyRequest)) returns ([AsymmetricGetPublicKeyResponse](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricGetPublicKeyResponse))**

## AsymmetricGetPublicKeyRequest {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricGetPublicKeyRequest}

```json
{
  "keyId": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the asymmetric KMS key to be used for public key retrieval. ||
|#

## AsymmetricGetPublicKeyResponse {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricGetPublicKeyResponse}

```json
{
  "keyId": "string",
  "publicKey": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

ID of the asymmetric KMS key to get public key of. ||
|| publicKey | **string**

Public key value.
The value is a PEM-encoded X.509 public key, also known as SubjectPublicKeyInfo (SPKI),
as defined in RFC 5280. ||
|#
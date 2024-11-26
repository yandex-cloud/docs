---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/get.md
---

# Key Management Service API, gRPC: AsymmetricSignatureKeyService.Get

Returns the specified asymmetric KMS key.

To get the list of available asymmetric KMS keys, make a [SymmetricKeyService.List] request.

## gRPC request

**rpc Get ([GetAsymmetricSignatureKeyRequest](#yandex.cloud.kms.v1.asymmetricsignature.GetAsymmetricSignatureKeyRequest)) returns ([AsymmetricSignatureKey](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey))**

## GetAsymmetricSignatureKeyRequest {#yandex.cloud.kms.v1.asymmetricsignature.GetAsymmetricSignatureKeyRequest}

```json
{
  "key_id": "string"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the asymmetric KMS key to return.
To get the ID of an asymmetric KMS key use a [AsymmetricSignatureKeyService.List](/docs/kms/api-ref/grpc/AsymmetricSignatureKey/list#List) request. ||
|#

## AsymmetricSignatureKey {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "status": "Status",
  "signature_algorithm": "AsymmetricSignatureAlgorithm",
  "deletion_protection": "bool"
}
```

An asymmetric KMS key that may contain several versions of the cryptographic material.

#|
||Field | Description ||
|| id | **string**

ID of the key. ||
|| folder_id | **string**

ID of the folder that the key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key was created. ||
|| name | **string**

Name of the key. ||
|| description | **string**

Description of the key. ||
|| labels | **string**

Custom labels for the key as `key:value` pairs. Maximum 64 per key. ||
|| status | enum **Status**

Current status of the key.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| signature_algorithm | enum **AsymmetricSignatureAlgorithm**

Signature Algorithm ID.

- `ASYMMETRIC_SIGNATURE_ALGORITHM_UNSPECIFIED`
- `RSA_2048_SIGN_PSS_SHA_256`: RSA-2048 signature with PSS padding and SHA-256
- `RSA_2048_SIGN_PSS_SHA_384`: RSA-2048 signature with PSS padding and SHA-384
- `RSA_2048_SIGN_PSS_SHA_512`: RSA-2048 signature with PSS padding and SHA-512
- `RSA_3072_SIGN_PSS_SHA_256`: RSA-3072 signature with PSS padding and SHA-256
- `RSA_3072_SIGN_PSS_SHA_384`: RSA-3072 signature with PSS padding and SHA-384
- `RSA_3072_SIGN_PSS_SHA_512`: RSA-3072 signature with PSS padding and SHA-512
- `RSA_4096_SIGN_PSS_SHA_256`: RSA-4096 signature with PSS padding and SHA-256
- `RSA_4096_SIGN_PSS_SHA_384`: RSA-4096 signature with PSS padding and SHA-384
- `RSA_4096_SIGN_PSS_SHA_512`: RSA-4096 signature with PSS padding and SHA-512
- `ECDSA_NIST_P256_SHA_256`: ECDSA signature with NIST P-256 curve and SHA-256
- `ECDSA_NIST_P384_SHA_384`: ECDSA signature with NIST P-384 curve and SHA-384
- `ECDSA_NIST_P521_SHA_512`: ECDSA signature with NIST P-521 curve and SHA-512
- `ECDSA_SECP256_K1_SHA_256`: ECDSA signature with SECP256_K1 curve and SHA-256 ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the key ||
|#
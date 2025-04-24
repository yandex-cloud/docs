---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/update.md
---

# Key Management Service API, gRPC: AsymmetricSignatureKeyService.Update

Updates the specified asymmetric KMS key.

## gRPC request

**rpc Update ([UpdateAsymmetricSignatureKeyRequest](#yandex.cloud.kms.v1.asymmetricsignature.UpdateAsymmetricSignatureKeyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateAsymmetricSignatureKeyRequest {#yandex.cloud.kms.v1.asymmetricsignature.UpdateAsymmetricSignatureKeyRequest}

```json
{
  "key_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "status": "Status",
  "labels": "map<string, string>",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the asymmetric KMS key to update.
To get the ID of a asymmetric KMS key use a [AsymmetricSignatureKeyService.List](/docs/kms/asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which attributes of the asymmetric KMS key are going to be updated. ||
|| name | **string**

New name for the asymmetric KMS key. ||
|| description | **string**

New description for the asymmetric KMS key. ||
|| status | enum **Status**

New status for the asymmetric KMS key.
Using the [AsymmetricSignatureKeyService.Update](#Update) method you can only set ACTIVE or INACTIVE status.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the asymmetric KMS key as `key:value` pairs. Maximum 64 per key. ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the asymmetric KMS key ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "key_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "status": "Status",
    "signature_algorithm": "AsymmetricSignatureAlgorithm",
    "deletion_protection": "bool"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateAsymmetricSignatureKeyMetadata](#yandex.cloud.kms.v1.asymmetricsignature.UpdateAsymmetricSignatureKeyMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[AsymmetricSignatureKey](#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateAsymmetricSignatureKeyMetadata {#yandex.cloud.kms.v1.asymmetricsignature.UpdateAsymmetricSignatureKeyMetadata}

#|
||Field | Description ||
|| key_id | **string**

ID of the key being updated. ||
|#

## AsymmetricSignatureKey {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey}

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
|| labels | **object** (map<**string**, **string**>)

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
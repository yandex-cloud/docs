---
editable: false
sourcePath: en/_api-ref/kms/v1/asymmetricsignature/api-ref/AsymmetricSignatureKey/delete.md
---

# Key Management Service API, REST: AsymmetricSignatureKey.Delete

Deletes the specified asymmetric KMS key. This action also automatically schedules
the destruction of all of the key's versions in 72 hours.

The key and its versions appear absent in [AsymmetricSignatureKeyService.Get](/docs/kms/api-ref/AsymmetricSignatureKey/get#Get) and [AsymmetricSignatureKeyService.List](/docs/kms/api-ref/AsymmetricSignatureKey/list#List)
requests, but can be restored within 72 hours with a request to tech support.

## HTTP request

```
DELETE https://{{ api-host-kms }}/kms/v1/asymmetricSignatureKeys/{keyId}
```

## Path parameters

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the key to be deleted. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "keyId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "string",
    "signatureAlgorithm": "string",
    "deletionProtection": "boolean"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[DeleteAsymmetricSignatureKeyMetadata](#yandex.cloud.kms.v1.asymmetricsignature.DeleteAsymmetricSignatureKeyMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## DeleteAsymmetricSignatureKeyMetadata {#yandex.cloud.kms.v1.asymmetricsignature.DeleteAsymmetricSignatureKeyMetadata}

#|
||Field | Description ||
|| keyId | **string**

ID of the key being deleted. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## AsymmetricSignatureKey {#yandex.cloud.kms.v1.asymmetricsignature.AsymmetricSignatureKey}

An asymmetric KMS key that may contain several versions of the cryptographic material.

#|
||Field | Description ||
|| id | **string**

ID of the key. ||
|| folderId | **string**

ID of the folder that the key belongs to. ||
|| createdAt | **string** (date-time)

Time when the key was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the key. ||
|| description | **string**

Description of the key. ||
|| labels | **string**

Custom labels for the key as `key:value` pairs. Maximum 64 per key. ||
|| status | **enum** (Status)

Current status of the key.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| signatureAlgorithm | **enum** (AsymmetricSignatureAlgorithm)

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
|| deletionProtection | **boolean**

Flag that inhibits deletion of the key ||
|#
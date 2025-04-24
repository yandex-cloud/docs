---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/delete.md
---

# Key Management Service API, gRPC: AsymmetricEncryptionKeyService.Delete

Deletes the specified asymmetric KMS key. This action also automatically schedules
the destruction of all of the key's versions in 72 hours.

The key and its versions appear absent in [AsymmetricEncryptionKeyService.Get](/docs/kms/asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/get#Get) and [AsymmetricEncryptionKeyService.List](/docs/kms/asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/list#List)
requests, but can be restored within 72 hours with a request to tech support.

## gRPC request

**rpc Delete ([DeleteAsymmetricEncryptionKeyRequest](#yandex.cloud.kms.v1.asymmetricencryption.DeleteAsymmetricEncryptionKeyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeleteAsymmetricEncryptionKeyRequest {#yandex.cloud.kms.v1.asymmetricencryption.DeleteAsymmetricEncryptionKeyRequest}

```json
{
  "key_id": "string"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the key to be deleted. ||
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
    "encryption_algorithm": "AsymmetricEncryptionAlgorithm",
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
|| metadata | **[DeleteAsymmetricEncryptionKeyMetadata](#yandex.cloud.kms.v1.asymmetricencryption.DeleteAsymmetricEncryptionKeyMetadata)**

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
|| response | **[AsymmetricEncryptionKey](#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricEncryptionKey)**

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

## DeleteAsymmetricEncryptionKeyMetadata {#yandex.cloud.kms.v1.asymmetricencryption.DeleteAsymmetricEncryptionKeyMetadata}

#|
||Field | Description ||
|| key_id | **string**

ID of the key being deleted. ||
|#

## AsymmetricEncryptionKey {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricEncryptionKey}

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
|| encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**

Asymmetric Encryption Algorithm ID.

- `ASYMMETRIC_ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256
- `RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256
- `RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256 ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the key ||
|#
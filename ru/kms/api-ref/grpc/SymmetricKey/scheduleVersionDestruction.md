---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md
---

# Key Management Service API, gRPC: SymmetricKeyService.ScheduleVersionDestruction {#ScheduleVersionDestruction}

Schedules the specified key version for destruction.

Scheduled destruction can be cancelled with the [SymmetricKeyService.CancelVersionDestruction](/docs/kms/api-ref/grpc/SymmetricKey/cancelVersionDestruction#CancelVersionDestruction) method.

## gRPC request

**rpc ScheduleVersionDestruction ([ScheduleSymmetricKeyVersionDestructionRequest](#yandex.cloud.kms.v1.ScheduleSymmetricKeyVersionDestructionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ScheduleSymmetricKeyVersionDestructionRequest {#yandex.cloud.kms.v1.ScheduleSymmetricKeyVersionDestructionRequest}

```json
{
  "keyId": "string",
  "versionId": "string",
  "pendingPeriod": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the key whose version should be scheduled for destruction. ||
|| versionId | **string**

Required field. ID of the version to be destroyed. ||
|| pendingPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time interval between the version destruction request and actual destruction.
Default value: 7 days. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "keyId": "string",
    "versionId": "string",
    "destroyAt": "google.protobuf.Timestamp"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "keyId": "string",
    "status": "Status",
    "algorithm": "SymmetricAlgorithm",
    "createdAt": "google.protobuf.Timestamp",
    "primary": "bool",
    "destroyAt": "google.protobuf.Timestamp",
    "hostedByHsm": "bool"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ScheduleSymmetricKeyVersionDestructionMetadata](#yandex.cloud.kms.v1.ScheduleSymmetricKeyVersionDestructionMetadata)**

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
|| response | **[SymmetricKeyVersion](#yandex.cloud.kms.v1.SymmetricKeyVersion)**

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

## ScheduleSymmetricKeyVersionDestructionMetadata {#yandex.cloud.kms.v1.ScheduleSymmetricKeyVersionDestructionMetadata}

#|
||Field | Description ||
|| keyId | **string**

ID of the key whose version is being scheduled for destruction. ||
|| versionId | **string**

ID of the version that is being scheduled for destruction. ||
|| destroyAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is scheduled to be destroyed. ||
|#

## SymmetricKeyVersion {#yandex.cloud.kms.v1.SymmetricKeyVersion}

Symmetric KMS key version: metadata about actual cryptographic data.

#|
||Field | Description ||
|| id | **string**

ID of the key version. ||
|| keyId | **string**

ID of the symmetric KMS key that the version belongs to. ||
|| status | enum **Status**

Status of the key version.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and can be used for encryption and decryption.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `SymmetricKeyVersion.destroyAt` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| algorithm | enum **SymmetricAlgorithm**

Encryption algorithm that should be used when using the key version to encrypt plaintext.

- `SYMMETRIC_ALGORITHM_UNSPECIFIED`
- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key version was created. ||
|| primary | **bool**

Indication of a primary version, that is to be used by default for all cryptographic
operations that don't have a key version explicitly specified. ||
|| destroyAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| hostedByHsm | **bool**

Indication of the version that is hosted by HSM. ||
|#
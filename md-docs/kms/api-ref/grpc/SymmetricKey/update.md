# Key Management Service API, gRPC: SymmetricKeyService.Update

Updates the specified symmetric KMS key.

## gRPC request

**rpc Update ([UpdateSymmetricKeyRequest](#yandex.cloud.kms.v1.UpdateSymmetricKeyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSymmetricKeyRequest {#yandex.cloud.kms.v1.UpdateSymmetricKeyRequest}

```json
{
  "key_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "status": "Status",
  "labels": "map<string, string>",
  "default_algorithm": "SymmetricAlgorithm",
  "rotation_period": "google.protobuf.Duration",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the symmetric KMS key to update.
To get the ID of a symmetric KMS key use a [SymmetricKeyService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which attributes of the symmetric KMS key are going to be updated. ||
|| name | **string**

New name for the symmetric KMS key.

The maximum string length in characters is 100. ||
|| description | **string**

New description for the symmetric KMS key.

The maximum string length in characters is 1024. ||
|| status | enum **Status**

New status for the symmetric KMS key.
Using the [SymmetricKeyService.Update](#Update) method you can only set ACTIVE or INACTIVE status.

- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption.
Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the symmetric KMS key as `key:value` pairs. Maximum 64 per key.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| default_algorithm | enum **SymmetricAlgorithm**

Default encryption algorithm to be used with new versions of the symmetric KMS key.

- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM
- `GOST_R_3412_2015_K`: GOST R 34.12-2015 Kuznyechik algorithm ||
|| rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time period between automatic symmetric KMS key rotations. ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the symmetric KMS key ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
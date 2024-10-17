---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/update.md
---

# Lockbox API, gRPC: SecretService.Update {#Update}

Updates the specified secret.

## gRPC request

**rpc Update ([UpdateSecretRequest](#yandex.cloud.lockbox.v1.UpdateSecretRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSecretRequest {#yandex.cloud.lockbox.v1.UpdateSecretRequest}

```json
{
  "secretId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "deletionProtection": "bool",
  // Includes only one of the fields `passwordPayloadSpecification`
  "passwordPayloadSpecification": {
    "passwordKey": "string",
    "length": "int64",
    "includeUppercase": "google.protobuf.BoolValue",
    "includeLowercase": "google.protobuf.BoolValue",
    "includeDigits": "google.protobuf.BoolValue",
    "includePunctuation": "google.protobuf.BoolValue",
    "includedPunctuation": "string",
    "excludedPunctuation": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret to update. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which attributes of the secret are going to be updated. ||
|| name | **string**

New name of the secret. ||
|| description | **string**

New description of the secret. ||
|| labels | **string**

Custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| deletionProtection | **bool**

Flag that inhibits deletion of the secret. ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| passwordKey | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
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
    "secretId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "kmsKeyId": "string",
    "status": "Status",
    "currentVersion": {
      "id": "string",
      "secretId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "destroyAt": "google.protobuf.Timestamp",
      "description": "string",
      "status": "Status",
      "payloadEntryKeys": [
        "string"
      ],
      // Includes only one of the fields `passwordPayloadSpecification`
      "passwordPayloadSpecification": {
        "passwordKey": "string",
        "length": "int64",
        "includeUppercase": "google.protobuf.BoolValue",
        "includeLowercase": "google.protobuf.BoolValue",
        "includeDigits": "google.protobuf.BoolValue",
        "includePunctuation": "google.protobuf.BoolValue",
        "includedPunctuation": "string",
        "excludedPunctuation": "string"
      }
      // end of the list of possible fields
    },
    "deletionProtection": "bool",
    // Includes only one of the fields `passwordPayloadSpecification`
    "passwordPayloadSpecification": {
      "passwordKey": "string",
      "length": "int64",
      "includeUppercase": "google.protobuf.BoolValue",
      "includeLowercase": "google.protobuf.BoolValue",
      "includeDigits": "google.protobuf.BoolValue",
      "includePunctuation": "google.protobuf.BoolValue",
      "includedPunctuation": "string",
      "excludedPunctuation": "string"
    }
    // end of the list of possible fields
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
|| metadata | **[UpdateSecretMetadata](#yandex.cloud.lockbox.v1.UpdateSecretMetadata)**

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
|| response | **[Secret](#yandex.cloud.lockbox.v1.Secret)**

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

## UpdateSecretMetadata {#yandex.cloud.lockbox.v1.UpdateSecretMetadata}

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret being updated. ||
|#

## Secret {#yandex.cloud.lockbox.v1.Secret}

A secret that may contain several versions of the payload.

#|
||Field | Description ||
|| id | **string**

ID of the secret. ||
|| folderId | **string**

ID of the folder that the secret belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the secret. ||
|| description | **string**

Description of the secret. ||
|| labels | **string**

Custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| kmsKeyId | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `CREATING`: The secret is being created.
- `ACTIVE`: The secret is active and the secret payload can be accessed.

  Can be set to INACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/grpc/Secret/deactivate#Deactivate) method.
- `INACTIVE`: The secret is inactive and unusable.

  Can be set to ACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/grpc/Secret/deactivate#Deactivate) method. ||
|| currentVersion | **[Version](#yandex.cloud.lockbox.v1.Version)**

Current (i.e. the `latest`) version of the secret. ||
|| deletionProtection | **bool**

Flag that inhibits deletion of the secret. ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|#

## Version {#yandex.cloud.lockbox.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| secretId | **string**

ID of the secret that the version belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|| destroyAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| description | **string**

Description of the version. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and the secret payload can be accessed.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `Version.destroyAt` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| payloadEntryKeys[] | **string**

Keys of the entries contained in the version payload. ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2}

#|
||Field | Description ||
|| passwordKey | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#
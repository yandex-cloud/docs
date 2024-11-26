---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/create.md
---

# Lockbox API, gRPC: SecretService.Create

Creates a secret in the specified folder.

## gRPC request

**rpc Create ([CreateSecretRequest](#yandex.cloud.lockbox.v1.CreateSecretRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSecretRequest {#yandex.cloud.lockbox.v1.CreateSecretRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "kms_key_id": "string",
  "version_description": "string",
  "version_payload_entries": [
    {
      "key": "string",
      // Includes only one of the fields `text_value`, `binary_value`
      "text_value": "string",
      "binary_value": "bytes"
      // end of the list of possible fields
    }
  ],
  "deletion_protection": "bool",
  // Includes only one of the fields `password_payload_specification`
  "password_payload_specification": {
    "password_key": "string",
    "length": "int64",
    "include_uppercase": "google.protobuf.BoolValue",
    "include_lowercase": "google.protobuf.BoolValue",
    "include_digits": "google.protobuf.BoolValue",
    "include_punctuation": "google.protobuf.BoolValue",
    "included_punctuation": "string",
    "excluded_punctuation": "string"
  },
  // end of the list of possible fields
  "create_version": "google.protobuf.BoolValue"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a secret in. ||
|| name | **string**

Name of the secret. ||
|| description | **string**

Description of the secret. ||
|| labels | **string**

Custom labels for the secret as `key:value` pairs. Maximum 64 per key.
For example, `"project": "mvp"` or `"source": "dictionary"`. ||
|| kms_key_id | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret. ||
|| version_description | **string**

Description of the first version. ||
|| version_payload_entries[] | **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**

Payload entries added to the first version. ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the secret. ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `password_payload_specification`. ||
|| create_version | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If true: a version will be created with either version_payload_entries or password_payload_specification (one is required).
If false: a version is NOT created, no matter version_payload_entries or password_payload_specification.
Default: a version is created IF either version_payload_entries or password_payload_specification are specified.
It's never allowed to set both version_payload_entries and password_payload_specification. ||
|#

## PayloadEntryChange {#yandex.cloud.lockbox.v1.PayloadEntryChange}

#|
||Field | Description ||
|| key | **string**

Required field. Non-confidential key of the entry. ||
|| text_value | **string**

Use the field to set a text value.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| binary_value | **bytes**

Use the field to set a binary value.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| password_key | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
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
    "secret_id": "string",
    "version_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "kms_key_id": "string",
    "status": "Status",
    "current_version": {
      "id": "string",
      "secret_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "destroy_at": "google.protobuf.Timestamp",
      "description": "string",
      "status": "Status",
      "payload_entry_keys": [
        "string"
      ],
      // Includes only one of the fields `password_payload_specification`
      "password_payload_specification": {
        "password_key": "string",
        "length": "int64",
        "include_uppercase": "google.protobuf.BoolValue",
        "include_lowercase": "google.protobuf.BoolValue",
        "include_digits": "google.protobuf.BoolValue",
        "include_punctuation": "google.protobuf.BoolValue",
        "included_punctuation": "string",
        "excluded_punctuation": "string"
      }
      // end of the list of possible fields
    },
    "deletion_protection": "bool",
    // Includes only one of the fields `password_payload_specification`
    "password_payload_specification": {
      "password_key": "string",
      "length": "int64",
      "include_uppercase": "google.protobuf.BoolValue",
      "include_lowercase": "google.protobuf.BoolValue",
      "include_digits": "google.protobuf.BoolValue",
      "include_punctuation": "google.protobuf.BoolValue",
      "included_punctuation": "string",
      "excluded_punctuation": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSecretMetadata](#yandex.cloud.lockbox.v1.CreateSecretMetadata)**

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

## CreateSecretMetadata {#yandex.cloud.lockbox.v1.CreateSecretMetadata}

#|
||Field | Description ||
|| secret_id | **string**

ID of the secret being created. ||
|| version_id | **string**

ID of the current version of the secret being created. ||
|#

## Secret {#yandex.cloud.lockbox.v1.Secret}

A secret that may contain several versions of the payload.

#|
||Field | Description ||
|| id | **string**

ID of the secret. ||
|| folder_id | **string**

ID of the folder that the secret belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the secret. ||
|| description | **string**

Description of the secret. ||
|| labels | **string**

Custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| kms_key_id | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `CREATING`: The secret is being created.
- `ACTIVE`: The secret is active and the secret payload can be accessed.

  Can be set to INACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/grpc/Secret/deactivate#Deactivate) method.
- `INACTIVE`: The secret is inactive and unusable.

  Can be set to ACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/grpc/Secret/deactivate#Deactivate) method. ||
|| current_version | **[Version](#yandex.cloud.lockbox.v1.Version)**

Current (i.e. the `latest`) version of the secret. ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the secret. ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2)**

Includes only one of the fields `password_payload_specification`. ||
|#

## Version {#yandex.cloud.lockbox.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| secret_id | **string**

ID of the secret that the version belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|| destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| description | **string**

Description of the version. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and the secret payload can be accessed.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `Version.destroy_at` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| payload_entry_keys[] | **string**

Keys of the entries contained in the version payload. ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2)**

Includes only one of the fields `password_payload_specification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification2}

#|
||Field | Description ||
|| password_key | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#
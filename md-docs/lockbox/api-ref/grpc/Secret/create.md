[Документация Yandex Cloud](../../../../index.md) > [Yandex Lockbox](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Secret](index.md) > Create

# Lockbox API, gRPC: SecretService.Create

Creates a secret in the specified folder.

## gRPC request

**rpc Create ([CreateSecretRequest](#yandex.cloud.lockbox.v1.CreateSecretRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSecretRequest {#yandex.cloud.lockbox.v1.CreateSecretRequest}

```json
{
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
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "kms_key_id": "string",
  "version_description": "string",
  "version_payload_entries": [
    {
      // Includes only one of the fields `text_value`, `binary_value`
      "text_value": "string",
      "binary_value": "bytes",
      // end of the list of possible fields
      "key": "string"
    }
  ],
  "deletion_protection": "bool",
  "create_version": "google.protobuf.BoolValue"
}
```

#|
||Field | Description ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `password_payload_specification`. ||
|| folder_id | **string**

Required field. ID of the folder to create a secret in.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the secret.

The maximum string length in characters is 100. ||
|| description | **string**

Description of the secret.

The maximum string length in characters is 1024. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the secret as `key:value` pairs. Maximum 64 per key.
For example, `"project": "mvp"` or `"source": "dictionary"`.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| kms_key_id | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret.

The maximum string length in characters is 50. ||
|| version_description | **string**

Description of the first version.

The maximum string length in characters is 256. ||
|| version_payload_entries[] | **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**

Payload entries added to the first version. ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the secret. ||
|| create_version | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If true: a version will be created with either version_payload_entries or password_payload_specification (one is required).
If false: a version is NOT created, no matter version_payload_entries or password_payload_specification.
Default: a version is created IF either version_payload_entries or password_payload_specification are specified.
It's never allowed to set both version_payload_entries and password_payload_specification. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| password_key | **string**

Required field. key of the entry to store generated password value

Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `. ||
|| length | **int64**

password length; by default, a reasonable length will be decided

The maximum value is 256. ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#

## PayloadEntryChange {#yandex.cloud.lockbox.v1.PayloadEntryChange}

#|
||Field | Description ||
|| text_value | **string**

Use the field to set a text value.

The maximum string length in characters is 65536.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| binary_value | **bytes**

Use the field to set a binary value.

The maximum string length in characters is 65536.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| key | **string**

Required field. Non-confidential key of the entry.

The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `. ||
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
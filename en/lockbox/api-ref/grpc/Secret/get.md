---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/get.md
---

# Lockbox API, gRPC: SecretService.Get

Returns the specified secret.

To get the list of all available secrets, make a [List](/docs/lockbox/api-ref/grpc/Secret/list#List) request.
Use [PayloadService.Get](/docs/lockbox/api-ref/grpc/Payload/get#Get) to get the payload (confidential data themselves) of the secret.

## gRPC request

**rpc Get ([GetSecretRequest](#yandex.cloud.lockbox.v1.GetSecretRequest)) returns ([Secret](#yandex.cloud.lockbox.v1.Secret))**

## GetSecretRequest {#yandex.cloud.lockbox.v1.GetSecretRequest}

```json
{
  "secret_id": "string"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Required field. ID of the secret to return.

To get a secret ID make a [List](/docs/lockbox/api-ref/grpc/Secret/list#List) request. ||
|#

## Secret {#yandex.cloud.lockbox.v1.Secret}

```json
{
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
```

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
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

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
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `password_payload_specification`. ||
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
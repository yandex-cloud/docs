---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/get.md
---

# Lockbox API, gRPC: SecretService.Get {#Get}

Returns the specified secret.

To get the list of all available secrets, make a [List](/docs/lockbox/api-ref/grpc/Secret/list#List) request.
Use [PayloadService.Get](/docs/lockbox/api-ref/grpc/Payload/get#Get) to get the payload (confidential data themselves) of the secret.

## gRPC request

**rpc Get ([GetSecretRequest](#yandex.cloud.lockbox.v1.GetSecretRequest)) returns ([Secret](#yandex.cloud.lockbox.v1.Secret))**

## GetSecretRequest {#yandex.cloud.lockbox.v1.GetSecretRequest}

```json
{
  "secretId": "string"
}
```

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret to return.

To get a secret ID make a [List](/docs/lockbox/api-ref/grpc/Secret/list#List) request. ||
|#

## Secret {#yandex.cloud.lockbox.v1.Secret}

```json
{
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
```

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
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

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
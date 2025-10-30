---
editable: false
apiPlayground:
  - url: https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}
    method: patch
    path:
      type: object
      properties:
        secretId:
          description: |-
            **string**
            Required field. ID of the secret to update.
          type: string
      required:
        - secretId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name of the secret.
          type: string
        description:
          description: |-
            **string**
            New description of the secret.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the secret as `key:value` pairs. Maximum 64 per key.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
        deletionProtection:
          description: |-
            **boolean**
            Flag that inhibits deletion of the secret.
          type: boolean
        passwordPayloadSpecification:
          description: |-
            **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**
            Includes only one of the fields `passwordPayloadSpecification`.
          $ref: '#/definitions/PasswordPayloadSpecification'
      required:
        - updateMask
      additionalProperties: false
    definitions:
      PasswordPayloadSpecification:
        type: object
        properties:
          passwordKey:
            description: |-
              **string**
              Required field. key of the entry to store generated password value
            pattern: '[-_./\\@0-9a-zA-Z]+'
            type: string
          length:
            description: |-
              **string** (int64)
              password length; by default, a reasonable length will be decided
            type: string
            format: int64
          includeUppercase:
            description: |-
              **boolean**
              whether at least one A..Z character is included in the password, true by default
            type: boolean
          includeLowercase:
            description: |-
              **boolean**
              whether at least one a..z character is included in the password, true by default
            type: boolean
          includeDigits:
            description: |-
              **boolean**
              whether at least one 0..9 character is included in the password, true by default
            type: boolean
          includePunctuation:
            description: |-
              **boolean**
              whether at least one punctuation character is included in the password, true by default
              punctuation characters by default (there are 32): !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{|}~
              to customize the punctuation characters, see included_punctuation and excluded_punctuation below
            type: boolean
          includedPunctuation:
            description: |-
              **string**
              If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
              a string of specific punctuation characters to use (at most, all the 32)
            type: string
          excludedPunctuation:
            description: |-
              **string**
              a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)
            type: string
        required:
          - passwordKey
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/update.md
---

# Lockbox API, REST: Secret.Update

Updates the specified secret.

## HTTP request

```
PATCH https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}
```

## Path parameters

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret to update. ||
|#

## Body parameters {#yandex.cloud.lockbox.v1.UpdateSecretRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
  // Includes only one of the fields `passwordPayloadSpecification`
  "passwordPayloadSpecification": {
    "passwordKey": "string",
    "length": "string",
    "includeUppercase": "boolean",
    "includeLowercase": "boolean",
    "includeDigits": "boolean",
    "includePunctuation": "boolean",
    "includedPunctuation": "string",
    "excludedPunctuation": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the secret. ||
|| description | **string**

New description of the secret. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| deletionProtection | **boolean**

Flag that inhibits deletion of the secret. ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| passwordKey | **string**

Required field. key of the entry to store generated password value ||
|| length | **string** (int64)

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **boolean**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **boolean**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **boolean**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **boolean**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
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
    "secretId": "string"
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
    "labels": "object",
    "kmsKeyId": "string",
    "status": "string",
    "currentVersion": {
      "id": "string",
      "secretId": "string",
      "createdAt": "string",
      "destroyAt": "string",
      "description": "string",
      "status": "string",
      "payloadEntryKeys": [
        "string"
      ],
      // Includes only one of the fields `passwordPayloadSpecification`
      "passwordPayloadSpecification": {
        "passwordKey": "string",
        "length": "string",
        "includeUppercase": "boolean",
        "includeLowercase": "boolean",
        "includeDigits": "boolean",
        "includePunctuation": "boolean",
        "includedPunctuation": "string",
        "excludedPunctuation": "string"
      }
      // end of the list of possible fields
    },
    "deletionProtection": "boolean",
    // Includes only one of the fields `passwordPayloadSpecification`
    "passwordPayloadSpecification": {
      "passwordKey": "string",
      "length": "string",
      "includeUppercase": "boolean",
      "includeLowercase": "boolean",
      "includeDigits": "boolean",
      "includePunctuation": "boolean",
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
|| metadata | **[UpdateSecretMetadata](#yandex.cloud.lockbox.v1.UpdateSecretMetadata)**

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

## Secret {#yandex.cloud.lockbox.v1.Secret}

A secret that may contain several versions of the payload.

#|
||Field | Description ||
|| id | **string**

ID of the secret. ||
|| folderId | **string**

ID of the folder that the secret belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the secret. ||
|| description | **string**

Description of the secret. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| kmsKeyId | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret. ||
|| status | **enum** (Status)

Status of the secret.

- `STATUS_UNSPECIFIED`
- `CREATING`: The secret is being created.
- `ACTIVE`: The secret is active and the secret payload can be accessed.

  Can be set to INACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/Secret/deactivate#Deactivate) method.
- `INACTIVE`: The secret is inactive and unusable.

  Can be set to ACTIVE using the [SecretService.Deactivate](/docs/lockbox/api-ref/Secret/deactivate#Deactivate) method. ||
|| currentVersion | **[Version](#yandex.cloud.lockbox.v1.Version)**

Current (i.e. the `latest`) version of the secret. ||
|| deletionProtection | **boolean**

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
|| createdAt | **string** (date-time)

Time when the version was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| destroyAt | **string** (date-time)

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string**

Description of the version. ||
|| status | **enum** (Status)

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
|| length | **string** (int64)

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **boolean**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **boolean**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **boolean**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **boolean**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#
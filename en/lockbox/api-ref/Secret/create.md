---
editable: false
apiPlayground:
  - url: https://{{ api-host-lockbox }}/lockbox/v1/secrets
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        passwordPayloadSpecification:
          description: |-
            **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**
            Includes only one of the fields `passwordPayloadSpecification`.
          $ref: '#/definitions/PasswordPayloadSpecification'
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a secret in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Name of the secret.
            The maximum string length in characters is 100.
          type: string
        description:
          description: |-
            **string**
            Description of the secret.
            The maximum string length in characters is 1024.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the secret as `key:value` pairs. Maximum 64 per key.
            For example, `"project": "mvp"` or `"source": "dictionary"`.
            The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
        kmsKeyId:
          description: |-
            **string**
            Optional ID of the KMS key will be used to encrypt and decrypt the secret.
            The maximum string length in characters is 50.
          type: string
        versionDescription:
          description: |-
            **string**
            Description of the first version.
            The maximum string length in characters is 256.
          type: string
        versionPayloadEntries:
          description: |-
            **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**
            Payload entries added to the first version.
          type: array
          items:
            $ref: '#/definitions/PayloadEntryChange'
        deletionProtection:
          description: |-
            **boolean**
            Flag that inhibits deletion of the secret.
          type: boolean
        createVersion:
          description: |-
            **boolean**
            If true: a version will be created with either version_payload_entries or password_payload_specification (one is required).
            If false: a version is NOT created, no matter version_payload_entries or password_payload_specification.
            Default: a version is created IF either version_payload_entries or password_payload_specification are specified.
            It's never allowed to set both version_payload_entries and password_payload_specification.
          type: boolean
      required:
        - folderId
      additionalProperties: false
    definitions:
      PasswordPayloadSpecification:
        type: object
        properties:
          passwordKey:
            description: |-
              **string**
              Required field. key of the entry to store generated password value
              Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `.
            pattern: '[-_./\\@0-9a-zA-Z]+'
            type: string
          length:
            description: |-
              **string** (int64)
              password length; by default, a reasonable length will be decided
              The maximum value is 256.
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
      PayloadEntryChange:
        type: object
        properties:
          textValue:
            description: |-
              **string**
              Use the field to set a text value.
              The maximum string length in characters is 65536.
              Includes only one of the fields `textValue`, `binaryValue`.
              Confidential value of the entry.
            type: string
          binaryValue:
            description: |-
              **string** (bytes)
              Use the field to set a binary value.
              The maximum string length in characters is 65536.
              Includes only one of the fields `textValue`, `binaryValue`.
              Confidential value of the entry.
            type: string
            format: bytes
          key:
            description: |-
              **string**
              Required field. Non-confidential key of the entry.
              The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `.
            pattern: '[-_./\\@0-9a-zA-Z]+'
            type: string
        required:
          - key
        oneOf:
          - required:
              - textValue
          - required:
              - binaryValue
---

# Lockbox API, REST: Secret.Create

Creates a secret in the specified folder.

## HTTP request

```
POST https://{{ api-host-lockbox }}/lockbox/v1/secrets
```

## Body parameters {#yandex.cloud.lockbox.v1.CreateSecretRequest}

```json
{
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
  },
  // end of the list of possible fields
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "kmsKeyId": "string",
  "versionDescription": "string",
  "versionPayloadEntries": [
    {
      // Includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // end of the list of possible fields
      "key": "string"
    }
  ],
  "deletionProtection": "boolean",
  "createVersion": "boolean"
}
```

#|
||Field | Description ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|| folderId | **string**

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
|| kmsKeyId | **string**

Optional ID of the KMS key will be used to encrypt and decrypt the secret.

The maximum string length in characters is 50. ||
|| versionDescription | **string**

Description of the first version.

The maximum string length in characters is 256. ||
|| versionPayloadEntries[] | **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**

Payload entries added to the first version. ||
|| deletionProtection | **boolean**

Flag that inhibits deletion of the secret. ||
|| createVersion | **boolean**

If true: a version will be created with either version_payload_entries or password_payload_specification (one is required).
If false: a version is NOT created, no matter version_payload_entries or password_payload_specification.
Default: a version is created IF either version_payload_entries or password_payload_specification are specified.
It's never allowed to set both version_payload_entries and password_payload_specification. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| passwordKey | **string**

Required field. key of the entry to store generated password value

Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `. ||
|| length | **string** (int64)

password length; by default, a reasonable length will be decided

The maximum value is 256. ||
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

## PayloadEntryChange {#yandex.cloud.lockbox.v1.PayloadEntryChange}

#|
||Field | Description ||
|| textValue | **string**

Use the field to set a text value.

The maximum string length in characters is 65536.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|| binaryValue | **string** (bytes)

Use the field to set a binary value.

The maximum string length in characters is 65536.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|| key | **string**

Required field. Non-confidential key of the entry.

The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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
---
editable: false
apiPlayground:
  - url: https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}:addVersion
    method: post
    path:
      type: object
      properties:
        secretId:
          description: |-
            **string**
            Required field. ID of the secret.
          type: string
      required:
        - secretId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        description:
          description: |-
            **string**
            Description of the version.
          type: string
        payloadEntries:
          description: |-
            **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**
            Describe how payload entries of the base version change in the added version.
          type: array
          items:
            $ref: '#/definitions/PayloadEntryChange'
        baseVersionId:
          description: |-
            **string**
            Optional base version id. Defaults to the current version if not specified
          type: string
      additionalProperties: false
    definitions:
      PayloadEntryChange:
        type: object
        properties:
          key:
            description: |-
              **string**
              Required field. Non-confidential key of the entry.
            pattern: '[-_./\\@0-9a-zA-Z]+'
            type: string
          textValue:
            description: |-
              **string**
              Use the field to set a text value.
              Includes only one of the fields `textValue`, `binaryValue`.
              Confidential value of the entry.
            type: string
          binaryValue:
            description: |-
              **string** (bytes)
              Use the field to set a binary value.
              Includes only one of the fields `textValue`, `binaryValue`.
              Confidential value of the entry.
            type: string
            format: bytes
        required:
          - key
        oneOf:
          - required:
              - textValue
          - required:
              - binaryValue
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/addVersion.md
---

# Lockbox API, REST: Secret.AddVersion

Adds new version based on a previous one.

## HTTP request

```
POST https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}:addVersion
```

## Path parameters

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret. ||
|#

## Body parameters {#yandex.cloud.lockbox.v1.AddVersionRequest}

```json
{
  "description": "string",
  "payloadEntries": [
    {
      "key": "string",
      // Includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string"
      // end of the list of possible fields
    }
  ],
  "baseVersionId": "string"
}
```

#|
||Field | Description ||
|| description | **string**

Description of the version. ||
|| payloadEntries[] | **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**

Describe how payload entries of the base version change in the added version. ||
|| baseVersionId | **string**

Optional base version id. Defaults to the current version if not specified ||
|#

## PayloadEntryChange {#yandex.cloud.lockbox.v1.PayloadEntryChange}

#|
||Field | Description ||
|| key | **string**

Required field. Non-confidential key of the entry. ||
|| textValue | **string**

Use the field to set a text value.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|| binaryValue | **string** (bytes)

Use the field to set a binary value.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
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
    "secretId": "string",
    "versionId": "string"
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
|| metadata | **[AddVersionMetadata](#yandex.cloud.lockbox.v1.AddVersionMetadata)**

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
|| response | **[Version](#yandex.cloud.lockbox.v1.Version)**

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

## AddVersionMetadata {#yandex.cloud.lockbox.v1.AddVersionMetadata}

#|
||Field | Description ||
|| secretId | **string**

ID of the secret. ||
|| versionId | **string**

ID of the added version. ||
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
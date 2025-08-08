---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}
    method: patch
    path:
      type: object
      properties:
        userpoolId:
          description: |-
            **string**
            Required field. ID of the userpool to update.
            To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request.
          type: string
      required:
        - userpoolId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
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
            Name of the userpool.
            The name must be unique within the organization.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the userpool.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as key:value pairs.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        userSettings:
          description: |-
            **[UserSettings](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.UserSettings)**
            User settings for the userpool.
          $ref: '#/definitions/UserSettings'
        passwordQualityPolicy:
          description: |-
            **[PasswordQualityPolicy](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy)**
            Password quality policy for the userpool.
          $ref: '#/definitions/PasswordQualityPolicy'
        passwordLifetimePolicy:
          description: |-
            **[PasswordLifetimePolicy](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy)**
            Password lifetime policy for the userpool.
          $ref: '#/definitions/PasswordLifetimePolicy'
        bruteforceProtectionPolicy:
          description: |-
            **[BruteforceProtectionPolicy](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy)**
            Bruteforce protection policy for the userpool.
          $ref: '#/definitions/BruteforceProtectionPolicy'
      additionalProperties: false
    definitions:
      UserSettings:
        type: object
        properties:
          allowEditSelfPassword:
            description: |-
              **boolean**
              Whether users can change their own passwords.
            type: boolean
          allowEditSelfInfo:
            description: |-
              **boolean**
              Whether users can edit their own profile information.
            type: boolean
          allowEditSelfContacts:
            description: |-
              **boolean**
              Whether users can edit their own contact information.
            type: boolean
          allowEditSelfLogin:
            description: |-
              **boolean**
              Whether users can edit their own login information.
            type: boolean
      RequiredClasses:
        type: object
        properties:
          lowers:
            description: |-
              **boolean**
              Whether lowercase letters are required.
            type: boolean
          uppers:
            description: |-
              **boolean**
              Whether uppercase letters are required.
            type: boolean
          digits:
            description: |-
              **boolean**
              Whether digits are required.
            type: boolean
          specials:
            description: |-
              **boolean**
              Whether special characters are required.
            type: boolean
      MinLengthByClassSettings:
        type: object
        properties:
          one:
            description: |-
              **string** (int64)
              Minimum length for passwords with one character class.
            type: string
            format: int64
          two:
            description: |-
              **string** (int64)
              Minimum length for passwords with two character classes.
            type: string
            format: int64
          three:
            description: |-
              **string** (int64)
              Minimum length for passwords with three character classes.
            type: string
            format: int64
      PasswordQualityPolicy:
        type: object
        properties:
          allowSimilar:
            description: |-
              **boolean**
              Whether passwords similar to previous ones are allowed.
            type: boolean
          maxLength:
            description: |-
              **string** (int64)
              Maximum password length. Zero means no maximum length is enforced.
            type: string
            format: int64
          minLength:
            description: |-
              **string** (int64)
              Minimum password length.
            type: string
            format: int64
          matchLength:
            description: |-
              **string** (int64)
              Minimum length of substrings to check for similarity to vulnerable sequences.
            type: string
            format: int64
          requiredClasses:
            description: |-
              **[RequiredClasses](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses)**
              Character classes required in passwords.
            $ref: '#/definitions/RequiredClasses'
          minLengthByClassSettings:
            description: |-
              **[MinLengthByClassSettings](/docs/organization/idp/api-ref/Userpool/get#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings)**
              Minimum length requirements based on character class diversity.
              If not specified, these checks are disabled.
            $ref: '#/definitions/MinLengthByClassSettings'
      PasswordLifetimePolicy:
        type: object
        properties:
          minDaysCount:
            description: |-
              **string** (int64)
              Minimum number of days before a password can be changed.
            type: string
            format: int64
          maxDaysCount:
            description: |-
              **string** (int64)
              Maximum number of days a password remains valid.
              Zero means passwords never expire.
            type: string
            format: int64
      BruteforceProtectionPolicy:
        type: object
        properties:
          window:
            description: |-
              **string** (duration)
              Time window for counting failed authentication attempts.
            type: string
            format: duration
          block:
            description: |-
              **string** (duration)
              Duration of the block after too many failed attempts.
            type: string
            format: duration
          attempts:
            description: |-
              **string** (int64)
              Number of failed attempts allowed within the window before blocking.
            type: string
            format: int64
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/Userpool/update.md
---

# Identity Provider API, REST: Userpool.Update

Updates the specified userpool.

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}
```

## Path parameters

Request to update a userpool.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to update.
To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "userSettings": {
    "allowEditSelfPassword": "boolean",
    "allowEditSelfInfo": "boolean",
    "allowEditSelfContacts": "boolean",
    "allowEditSelfLogin": "boolean"
  },
  "passwordQualityPolicy": {
    "allowSimilar": "boolean",
    "maxLength": "string",
    "minLength": "string",
    "matchLength": "string",
    "requiredClasses": {
      "lowers": "boolean",
      "uppers": "boolean",
      "digits": "boolean",
      "specials": "boolean"
    },
    "minLengthByClassSettings": {
      "one": "string",
      "two": "string",
      "three": "string"
    }
  },
  "passwordLifetimePolicy": {
    "minDaysCount": "string",
    "maxDaysCount": "string"
  },
  "bruteforceProtectionPolicy": {
    "window": "string",
    "block": "string",
    "attempts": "string"
  }
}
```

Request to update a userpool.

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the userpool.
The name must be unique within the organization. ||
|| description | **string**

Description of the userpool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs. ||
|| userSettings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings)**

User settings for the userpool. ||
|| passwordQualityPolicy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy)**

Password quality policy for the userpool. ||
|| passwordLifetimePolicy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy)**

Password lifetime policy for the userpool. ||
|| bruteforceProtectionPolicy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy)**

Bruteforce protection policy for the userpool. ||
|#

## UserSettings {#yandex.cloud.organizationmanager.v1.idp.UserSettings}

Settings that control user capabilities within a userpool.

#|
||Field | Description ||
|| allowEditSelfPassword | **boolean**

Whether users can change their own passwords. ||
|| allowEditSelfInfo | **boolean**

Whether users can edit their own profile information. ||
|| allowEditSelfContacts | **boolean**

Whether users can edit their own contact information. ||
|| allowEditSelfLogin | **boolean**

Whether users can edit their own login information. ||
|#

## PasswordQualityPolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy}

Policy that defines password quality requirements.

#|
||Field | Description ||
|| allowSimilar | **boolean**

Whether passwords similar to previous ones are allowed. ||
|| maxLength | **string** (int64)

Maximum password length. Zero means no maximum length is enforced. ||
|| minLength | **string** (int64)

Minimum password length. ||
|| matchLength | **string** (int64)

Minimum length of substrings to check for similarity to vulnerable sequences. ||
|| requiredClasses | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses)**

Character classes required in passwords. ||
|| minLengthByClassSettings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
|#

## RequiredClasses {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses}

Character classes that can be required in passwords.

#|
||Field | Description ||
|| lowers | **boolean**

Whether lowercase letters are required. ||
|| uppers | **boolean**

Whether uppercase letters are required. ||
|| digits | **boolean**

Whether digits are required. ||
|| specials | **boolean**

Whether special characters are required. ||
|#

## MinLengthByClassSettings {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings}

Minimum password length requirements based on character class diversity.

#|
||Field | Description ||
|| one | **string** (int64)

Minimum length for passwords with one character class. ||
|| two | **string** (int64)

Minimum length for passwords with two character classes. ||
|| three | **string** (int64)

Minimum length for passwords with three character classes. ||
|#

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| minDaysCount | **string** (int64)

Minimum number of days before a password can be changed. ||
|| maxDaysCount | **string** (int64)

Maximum number of days a password remains valid.
Zero means passwords never expire. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy}

Policy that defines protection against brute force attacks.

#|
||Field | Description ||
|| window | **string** (duration)

Time window for counting failed authentication attempts. ||
|| block | **string** (duration)

Duration of the block after too many failed attempts. ||
|| attempts | **string** (int64)

Number of failed attempts allowed within the window before blocking. ||
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
    "userpoolId": "string"
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
    "organizationId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdAt": "string",
    "updatedAt": "string",
    "domains": [
      "string"
    ],
    "status": "string",
    "userSettings": {
      "allowEditSelfPassword": "boolean",
      "allowEditSelfInfo": "boolean",
      "allowEditSelfContacts": "boolean",
      "allowEditSelfLogin": "boolean"
    },
    "passwordQualityPolicy": {
      "allowSimilar": "boolean",
      "maxLength": "string",
      "minLength": "string",
      "matchLength": "string",
      "requiredClasses": {
        "lowers": "boolean",
        "uppers": "boolean",
        "digits": "boolean",
        "specials": "boolean"
      },
      "minLengthByClassSettings": {
        "one": "string",
        "two": "string",
        "three": "string"
      }
    },
    "passwordLifetimePolicy": {
      "minDaysCount": "string",
      "maxDaysCount": "string"
    },
    "bruteforceProtectionPolicy": {
      "window": "string",
      "block": "string",
      "attempts": "string"
    }
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
|| metadata | **[UpdateUserpoolMetadata](#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolMetadata)**

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
|| response | **[Userpool](#yandex.cloud.organizationmanager.v1.idp.Userpool)**

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

## UpdateUserpoolMetadata {#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolMetadata}

Metadata for the [UserpoolService.Update](#Update) operation.

#|
||Field | Description ||
|| userpoolId | **string**

ID of the userpool that is being updated. ||
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

## Userpool {#yandex.cloud.organizationmanager.v1.idp.Userpool}

A userpool is a container for users in the Identity Provider system.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the userpool. ||
|| organizationId | **string**

ID of the organization this userpool belongs to. ||
|| name | **string**

Name of the userpool. ||
|| description | **string**

Description of the userpool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs. ||
|| createdAt | **string** (date-time)

Timestamp when the userpool was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the userpool was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| domains[] | **string**

List of domains associated with this userpool. ||
|| status | **enum** (Status)

Current status of the userpool.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `CREATING`: The userpool is in the process of being created.
- `ACTIVE`: The userpool is active and operational.
- `DELETING`: The userpool is in the process of being deleted. ||
|| userSettings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings2)**

User settings for this userpool. ||
|| passwordQualityPolicy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy2)**

Password quality policy for this userpool. ||
|| passwordLifetimePolicy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy2)**

Password lifetime policy for this userpool. ||
|| bruteforceProtectionPolicy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy2)**

Bruteforce protection policy for this userpool. ||
|#

## UserSettings {#yandex.cloud.organizationmanager.v1.idp.UserSettings2}

Settings that control user capabilities within a userpool.

#|
||Field | Description ||
|| allowEditSelfPassword | **boolean**

Whether users can change their own passwords. ||
|| allowEditSelfInfo | **boolean**

Whether users can edit their own profile information. ||
|| allowEditSelfContacts | **boolean**

Whether users can edit their own contact information. ||
|| allowEditSelfLogin | **boolean**

Whether users can edit their own login information. ||
|#

## PasswordQualityPolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy2}

Policy that defines password quality requirements.

#|
||Field | Description ||
|| allowSimilar | **boolean**

Whether passwords similar to previous ones are allowed. ||
|| maxLength | **string** (int64)

Maximum password length. Zero means no maximum length is enforced. ||
|| minLength | **string** (int64)

Minimum password length. ||
|| matchLength | **string** (int64)

Minimum length of substrings to check for similarity to vulnerable sequences. ||
|| requiredClasses | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses2)**

Character classes required in passwords. ||
|| minLengthByClassSettings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings2)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
|#

## RequiredClasses {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses2}

Character classes that can be required in passwords.

#|
||Field | Description ||
|| lowers | **boolean**

Whether lowercase letters are required. ||
|| uppers | **boolean**

Whether uppercase letters are required. ||
|| digits | **boolean**

Whether digits are required. ||
|| specials | **boolean**

Whether special characters are required. ||
|#

## MinLengthByClassSettings {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings2}

Minimum password length requirements based on character class diversity.

#|
||Field | Description ||
|| one | **string** (int64)

Minimum length for passwords with one character class. ||
|| two | **string** (int64)

Minimum length for passwords with two character classes. ||
|| three | **string** (int64)

Minimum length for passwords with three character classes. ||
|#

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy2}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| minDaysCount | **string** (int64)

Minimum number of days before a password can be changed. ||
|| maxDaysCount | **string** (int64)

Maximum number of days a password remains valid.
Zero means passwords never expire. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy2}

Policy that defines protection against brute force attacks.

#|
||Field | Description ||
|| window | **string** (duration)

Time window for counting failed authentication attempts. ||
|| block | **string** (duration)

Duration of the block after too many failed attempts. ||
|| attempts | **string** (int64)

Number of failed attempts allowed within the window before blocking. ||
|#
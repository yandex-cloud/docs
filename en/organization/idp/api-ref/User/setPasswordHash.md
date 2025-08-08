---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users/{userId}:setPasswordHash
    method: post
    path:
      type: object
      properties:
        userId:
          description: |-
            **string**
            Required field. ID of the user to set the password hash for.
          type: string
      required:
        - userId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        hash:
          description: |-
            **[PasswordHash](/docs/organization/idp/api-ref/User/create#yandex.cloud.organizationmanager.v1.idp.PasswordHash)**
            Password hash to set.
          $ref: '#/definitions/PasswordHash'
      additionalProperties: false
    definitions:
      PasswordHash:
        type: object
        properties:
          passwordHash:
            description: |-
              **string**
              Required field. The password hash string.
            type: string
          passwordHashType:
            description: |-
              **enum** (PasswordHashType)
              Required field. Type of the password hash.
              - `PASSWORD_HASH_TYPE_UNSPECIFIED`: The password hash type is not specified.
              - `AD_MD4`: Microsoft Active Directory MD4 hash.
            type: string
            enum:
              - PASSWORD_HASH_TYPE_UNSPECIFIED
              - AD_MD4
        required:
          - passwordHash
          - passwordHashType
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/User/setPasswordHash.md
---

# Identity Provider API, REST: User.SetPasswordHash

Sets a password hash for the specified user.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users/{userId}:setPasswordHash
```

## Path parameters

Request to set a password hash for a user.

#|
||Field | Description ||
|| userId | **string**

Required field. ID of the user to set the password hash for. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashRequest}

```json
{
  "hash": {
    "passwordHash": "string",
    "passwordHashType": "string"
  }
}
```

Request to set a password hash for a user.

#|
||Field | Description ||
|| hash | **[PasswordHash](#yandex.cloud.organizationmanager.v1.idp.PasswordHash)**

Password hash to set. ||
|#

## PasswordHash {#yandex.cloud.organizationmanager.v1.idp.PasswordHash}

Password hash information.

#|
||Field | Description ||
|| passwordHash | **string**

Required field. The password hash string. ||
|| passwordHashType | **enum** (PasswordHashType)

Required field. Type of the password hash.

- `PASSWORD_HASH_TYPE_UNSPECIFIED`: The password hash type is not specified.
- `AD_MD4`: Microsoft Active Directory MD4 hash. ||
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
    "userId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[SetPasswordHashMetadata](#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## SetPasswordHashMetadata {#yandex.cloud.organizationmanager.v1.idp.SetPasswordHashMetadata}

Metadata for the [UserService.SetPasswordHash](#SetPasswordHash) operation.

#|
||Field | Description ||
|| userId | **string**

ID of the user whose password hash is being set. ||
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
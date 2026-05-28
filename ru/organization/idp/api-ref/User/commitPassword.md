---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:commitPassword
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        externalUserId:
          description: |-
            **string**
            Required field. External identifier of the user whose password was written back.
            The maximum string length in characters is 50.
          type: string
        password:
          description: |-
            **string**
            Required field. The password that was written back.
            The maximum string length in characters is 128.
          type: string
        modifyingOperationId:
          description: |-
            **string**
            Required field. ID of the operation that triggered this writeback.
            The maximum string length in characters is 50.
          type: string
        needChange:
          description: |-
            **boolean**
            Whether the user must change their password on next login.
          type: boolean
        errorDetails:
          description: |-
            **[PasswordWritebackErrorDetails](#yandex.cloud.organizationmanager.v1.idp.PasswordWritebackErrorDetails)**
            Error details if the writeback failed.
          $ref: '#/definitions/PasswordWritebackErrorDetails'
        expiresAt:
          description: |-
            **string** (date-time)
            Timestamp when the password expires.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        generated:
          description: |-
            **boolean**
            Whether the password was system-generated.
          type: boolean
        userpoolId:
          description: |-
            **string**
            Required field. ID of the userpool the user belongs to.
            The maximum string length in characters is 50.
          type: string
      required:
        - externalUserId
        - password
        - modifyingOperationId
        - userpoolId
      additionalProperties: false
    definitions:
      PasswordWritebackErrorDetails:
        type: object
        properties:
          errorCode:
            description: |-
              **enum** (PasswordWritebackErrorCode)
              Type of error, used for UI rendering.
              - `PERMISSION_DENIED`: The IdentityHub sync agent does not have permission to set the password.
              - `PASSWORD_POLICY_VIOLATION`: The password does not meet the directory's password policy.
              - `UNKNOWN_ERROR`: An unknown error occurred.
              - `DEADLINE_EXCEEDED`: The writeback operation timed out.
            type: string
            enum:
              - PASSWORD_WRITEBACK_ERROR_CODE_UNSPECIFIED
              - PERMISSION_DENIED
              - PASSWORD_POLICY_VIOLATION
              - UNKNOWN_ERROR
              - DEADLINE_EXCEEDED
          errorMessage:
            description: |-
              **string**
              Exact error message from LDAP, for debugging purposes.
            type: string
---

# Identity Provider API, REST: User.CommitPassword

Commits the result of a password writeback operation.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:commitPassword
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.CommitPasswordRequest}

```json
{
  "externalUserId": "string",
  "password": "string",
  "modifyingOperationId": "string",
  "needChange": "boolean",
  "errorDetails": {
    "errorCode": "string",
    "errorMessage": "string"
  },
  "expiresAt": "string",
  "generated": "boolean",
  "userpoolId": "string"
}
```

Request to commit the result of a password writeback operation.

#|
||Field | Description ||
|| externalUserId | **string**

Required field. External identifier of the user whose password was written back.

The maximum string length in characters is 50. ||
|| password | **string**

Required field. The password that was written back.

The maximum string length in characters is 128. ||
|| modifyingOperationId | **string**

Required field. ID of the operation that triggered this writeback.

The maximum string length in characters is 50. ||
|| needChange | **boolean**

Whether the user must change their password on next login. ||
|| errorDetails | **[PasswordWritebackErrorDetails](#yandex.cloud.organizationmanager.v1.idp.PasswordWritebackErrorDetails)**

Error details if the writeback failed. ||
|| expiresAt | **string** (date-time)

Timestamp when the password expires.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| generated | **boolean**

Whether the password was system-generated. ||
|| userpoolId | **string**

Required field. ID of the userpool the user belongs to.

The maximum string length in characters is 50. ||
|#

## PasswordWritebackErrorDetails {#yandex.cloud.organizationmanager.v1.idp.PasswordWritebackErrorDetails}

Error details from LDAP password writeback.

#|
||Field | Description ||
|| errorCode | **enum** (PasswordWritebackErrorCode)

Type of error, used for UI rendering.

- `PERMISSION_DENIED`: The IdentityHub sync agent does not have permission to set the password.
- `PASSWORD_POLICY_VIOLATION`: The password does not meet the directory's password policy.
- `UNKNOWN_ERROR`: An unknown error occurred.
- `DEADLINE_EXCEEDED`: The writeback operation timed out. ||
|| errorMessage | **string**

Exact error message from LDAP, for debugging purposes. ||
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
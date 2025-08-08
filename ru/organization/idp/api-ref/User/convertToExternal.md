---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users/{userId}:convertToExternal
    method: post
    path:
      type: object
      properties:
        userId:
          description: |-
            **string**
            Required field. ID of the user to convert.
          type: string
      required:
        - userId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        externalId:
          description: |-
            **string**
            Required field. External identifier to associate with the user.
          type: string
      required:
        - externalId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/User/convertToExternal.md
---

# Identity Provider API, REST: User.ConvertToExternal

Converts a user to use external authentication.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users/{userId}:convertToExternal
```

## Path parameters

Request to convert a user to use external authentication.

#|
||Field | Description ||
|| userId | **string**

Required field. ID of the user to convert. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.ConvertToExternalUserRequest}

```json
{
  "externalId": "string"
}
```

Request to convert a user to use external authentication.

#|
||Field | Description ||
|| externalId | **string**

Required field. External identifier to associate with the user. ||
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
    "userId": "string",
    "externalId": "string"
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
    "userpoolId": "string",
    "status": "string",
    "username": "string",
    "fullName": "string",
    "givenName": "string",
    "familyName": "string",
    "email": "string",
    "phoneNumber": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "externalId": "string"
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
|| metadata | **[ConvertToExternalUserMetadata](#yandex.cloud.organizationmanager.v1.idp.ConvertToExternalUserMetadata)**

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
|| response | **[User](#yandex.cloud.organizationmanager.v1.idp.User)**

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

## ConvertToExternalUserMetadata {#yandex.cloud.organizationmanager.v1.idp.ConvertToExternalUserMetadata}

Metadata for the [UserService.ConvertToExternal](#ConvertToExternal) operation.

#|
||Field | Description ||
|| userId | **string**

ID of the user being converted. ||
|| externalId | **string**

External identifier being associated with the user. ||
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

## User {#yandex.cloud.organizationmanager.v1.idp.User}

A user in the Identity Provider system.

Users are created within a userpool and can authenticate to access cloud resources.
Each user has a unique identifier, credentials, and profile information.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the user.
This ID is generated automatically when the user is created. ||
|| userpoolId | **string**

ID of the userpool this user belongs to.
To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request. ||
|| status | **enum** (Status)

Current status of the user.
Determines whether the user can authenticate and access the system.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `ACTIVE`: The user is active and can authenticate.
Active users have full access to the system according to their permissions.
- `SUSPENDED`: The user is suspended and cannot authenticate.
Suspended users retain their data but cannot access the system.
- `DELETING`: The user is in the process of being deleted.
This is a transitional state before the user is completely removed from the system. ||
|| username | **string**

Username used for authentication.
Usually in the format of an email address. ||
|| fullName | **string**

User's full name (display name).
This is typically shown in the UI and used for identification purposes. ||
|| givenName | **string**

User's first name.
Part of the user's profile information. ||
|| familyName | **string**

User's last name.
Part of the user's profile information. ||
|| email | **string**

User's email address. ||
|| phoneNumber | **string**

User's phone number. ||
|| createdAt | **string** (date-time)

Timestamp when the user was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the user was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| externalId | **string**

External identifier for federation with external identity systems.
This ID can be used to link this user with an account in an external system. ||
|#
---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users
    method: get
    path: null
    query:
      type: object
      properties:
        userpoolId:
          description: |-
            **string**
            Required field. ID of the userpool to list users in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for pagination.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
          type: string
      required:
        - userpoolId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/User/list.md
---

# Identity Provider API, REST: User.List

Retrieves the list of users in the specified userpool.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.ListUsersRequest}

Request to list users in a userpool.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to list users in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. ||
|| pageToken | **string**

Page token for pagination. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
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
  ],
  "nextPageToken": "string"
}
```

Response message for [UserService.List](#List).

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.organizationmanager.v1.idp.User)**

List of users. ||
|| nextPageToken | **string**

Token for getting the next page of the list. ||
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
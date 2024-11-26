---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/users/api-ref/User/list.md
---

# Users, REST: User.List

List users in a specific folder.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/users/v1/users
```

## Query parameters {#yandex.cloud.ai.assistants.v1.users.ListUsersRequest}

Request message for listing users in a specific folder.

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID from which to list users. ||
|| pageSize | **string** (int64)

Maximum number of users to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.users.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "source": "string",
      "createdBy": "string",
      "createdAt": "string",
      "updatedBy": "string",
      "updatedAt": "string",
      "expirationConfig": {
        "expirationPolicy": "string",
        "ttlDays": "string"
      },
      "expiresAt": "string",
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.ai.assistants.v1.users.User)**

List of users in the specified folder. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## User {#yandex.cloud.ai.assistants.v1.users.User}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the user. ||
|| folderId | **string**

ID of the folder that the user belongs to. ||
|| name | **string**

Name of the user. ||
|| description | **string**

Description of the user. ||
|| source | **string** ||
|| createdBy | **string**

Identifier of the subject who created this user. ||
|| createdAt | **string** (date-time)

Timestamp representing when the user was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this user. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this user was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the user, defining when and how the user will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the user will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/users/api-ref/grpc/User/list.md
---

# Users, gRPC: UserService.List {#List}

List users in a specific folder.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.ai.assistants.v1.users.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.ai.assistants.v1.users.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.ai.assistants.v1.users.ListUsersRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

Request message for listing users in a specific folder.

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID from which to list users. ||
|| pageSize | **int64**

Maximum number of users to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## ListUsersResponse {#yandex.cloud.ai.assistants.v1.users.ListUsersResponse}

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
      "createdAt": "google.protobuf.Timestamp",
      "updatedBy": "string",
      "updatedAt": "google.protobuf.Timestamp",
      "expirationConfig": {
        "expirationPolicy": "ExpirationPolicy",
        "ttlDays": "int64"
      },
      "expiresAt": "google.protobuf.Timestamp",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the user was created. ||
|| updatedBy | **string**

Identifier of the subject who last updated this user. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this user was updated. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the user, defining when and how the user will expire. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the user will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **int64** ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/users/api-ref/grpc/User/list.md
---

# Users, gRPC: UserService.List

List users in a specific folder.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.ai.assistants.v1.users.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.ai.assistants.v1.users.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.ai.assistants.v1.users.ListUsersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing users in a specific folder.

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID from which to list users. ||
|| page_size | **int64**

Maximum number of users to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListUsersResponse {#yandex.cloud.ai.assistants.v1.users.ListUsersResponse}

```json
{
  "users": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "source": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_by": "string",
      "updated_at": "google.protobuf.Timestamp",
      "expiration_config": {
        "expiration_policy": "ExpirationPolicy",
        "ttl_days": "int64"
      },
      "expires_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.ai.assistants.v1.users.User)**

List of users in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## User {#yandex.cloud.ai.assistants.v1.users.User}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the user. ||
|| folder_id | **string**

ID of the folder that the user belongs to. ||
|| name | **string**

Name of the user. ||
|| description | **string**

Description of the user. ||
|| source | **string** ||
|| created_by | **string**

Identifier of the subject who created this user. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the user was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this user. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this user was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the user, defining when and how the user will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the user will expire. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#
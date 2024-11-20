---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/users/api-ref/grpc/User/get.md
---

# Users, gRPC: UserService.Get {#Get}

Retrieve details of a specific user by its ID.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.ai.assistants.v1.users.GetUserRequest)) returns ([User](#yandex.cloud.ai.assistants.v1.users.User))**

## GetUserRequest {#yandex.cloud.ai.assistants.v1.users.GetUserRequest}

```json
{
  "userId": "string"
}
```

Request message for retrieving a user by ID.

#|
||Field | Description ||
|| userId | **string**

Required field. ID of the user to retrieve. ||
|#

## User {#yandex.cloud.ai.assistants.v1.users.User}

```json
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
```

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
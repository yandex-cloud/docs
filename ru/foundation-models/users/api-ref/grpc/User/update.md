---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/users/api-ref/grpc/User/update.md
---

# Users, gRPC: UserService.Update

Update an existing user.

## gRPC request

**rpc Update ([UpdateUserRequest](#yandex.cloud.ai.assistants.v1.users.UpdateUserRequest)) returns ([User](#yandex.cloud.ai.assistants.v1.users.User))**

## UpdateUserRequest {#yandex.cloud.ai.assistants.v1.users.UpdateUserRequest}

```json
{
  "user_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
  "labels": "string"
}
```

Request message for updating an existing user.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. A field mask specifying which fields to update. ||
|| name | **string**

New name for the user. ||
|| description | **string**

New description for the user. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

New expiration configuration for the user. ||
|| labels | **string**

New set of labels for the user. ||
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

## User {#yandex.cloud.ai.assistants.v1.users.User}

```json
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
  "labels": "string"
}
```

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
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the user, defining when and how the user will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the user will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/users/api-ref/grpc/User/delete.md
---

# Users, gRPC: UserService.Delete

Delete a user by its ID.

## gRPC request

**rpc Delete ([DeleteUserRequest](#yandex.cloud.ai.assistants.v1.users.DeleteUserRequest)) returns ([DeleteUserResponse](#yandex.cloud.ai.assistants.v1.users.DeleteUserResponse))**

## DeleteUserRequest {#yandex.cloud.ai.assistants.v1.users.DeleteUserRequest}

```json
{
  "user_id": "string"
}
```

Request message for deleting a user by ID.

#|
||Field | Description ||
|| user_id | **string**

Required field. ID of the user to delete. ||
|#

## DeleteUserResponse {#yandex.cloud.ai.assistants.v1.users.DeleteUserResponse}

```json
{}
```

Response message for the delete operation.

#|
||Field | Description ||
|| Empty | > ||
|#
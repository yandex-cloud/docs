---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/users/api-ref/User/delete.md
---

# Users, REST: User.Delete {#Delete}

Delete a user by its ID.

## HTTP request

```
DELETE https://rest-assistant.{{ api-host }}/users/v1/users/{userId}
```

## Path parameters

Request message for deleting a user by ID.

#|
||Field | Description ||
|| userId | **string**

Required field. ID of the user to delete. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.users.DeleteUserResponse}

**HTTP Code: 200 - OK**
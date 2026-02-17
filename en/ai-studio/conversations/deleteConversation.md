---
editable: false
---

# REST: Delete a conversation

[CURRENTLY NOT SUPPORTED]

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/conversations/{conversation_id}
```

## Path parameters

#|
||Field | Description ||
|| conversation_id | **string**

Required field. The ID of the conversation to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

Success

**Response schema: application/json**

```json
{
  "object": "string",
  "deleted": "boolean",
  "id": "string"
}
```

#|
||Field | Description ||
|| object | **enum**

Required field. 

- `conversation.deleted` ||
|| deleted | **boolean**

Required field.  ||
|| id | **string**

Required field.  ||
|#
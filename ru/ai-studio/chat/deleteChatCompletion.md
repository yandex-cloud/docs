---
editable: false
---

# REST: Delete chat completion

[CURRENTLY NOT SUPPORTED]

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/chat/completions/{completion_id}
```

## Path parameters

#|
||Field | Description ||
|| completion_id | **string**

Required field. The ID of the chat completion to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

The chat completion was deleted successfully.

**Response schema: application/json**

```json
{}
```
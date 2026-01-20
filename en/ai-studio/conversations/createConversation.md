---
editable: false
sourcePath: en/_openapi/openai-compatible/conversations/createConversation.md
---

# REST: Create a conversation

Create a conversation.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/conversations
```

## Body parameters

**Request schema: application/json**

```json
{
  "metadata": "unknown",
  "items": "unknown"
}
```

#|
||Field | Description ||
|| metadata | Any of **unknown** \| **null** ||
|| items | Any of **unknown** \| **null** ||
|#

## Response {#200}

**HTTP Code: 200**

Success

**Response schema: application/json**

```json
{
  "id": "string",
  "object": "string",
  "metadata": "unknown",
  "created_at": "integer"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. The unique ID of the conversation. ||
|| object | **enum**

Required field. The object type, which is always `conversation`.

- `conversation` ||
|| metadata | **unknown**

Required field. Set of 16 key-value pairs that can be attached to an object. This can be         useful for storing additional information about the object in a structured         format, and querying for objects via API or the dashboard.
        Keys are strings with a maximum length of 64 characters. Values
are strings         with a maximum length of 512 characters. ||
|| created_at | **integer**

Required field. The time at which the conversation was created, measured in seconds since the Unix epoch. ||
|#
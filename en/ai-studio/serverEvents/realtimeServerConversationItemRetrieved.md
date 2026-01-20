---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemRetrieved.md
---

# REST: conversation.item.retrieved

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.retrieved
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item": {
    "id": "string",
    "object": "string",
    "type": "string",
    "role": "string | null",
    "status": "string | null",
    "content": "array | null",
    "call_id": "string | null",
    "name": "string | null",
    "arguments": "string | null",
    "output": "string | null",
    "metadata": "object | null"
  }
}
```

Returned when a conversation item is retrieved with `conversation.item.retrieve`. Includes the full content of the item, including audio data.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.retrieved`.

- `conversation.item.retrieved` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item | **[RealtimeConversationItem](#RealtimeConversationItem)**

Required field. A single item within a Realtime conversation. ||
|#

## RealtimeConversationItem {#RealtimeConversationItem}

A single item within a Realtime conversation.

#|
||Field | Description ||
|| id | **string**

Item ID. ||
|| object | **string**

Object type identifier (e.g., realtime.item). ||
|| type | **string**

Required field. Item type (message, function_call, function_call_output, mcp_call, etc.). ||
|| role | **string \| null**

Role for message items (user, assistant, system). ||
|| status | **string \| null**

Item status, if applicable. ||
|| content | **array \| null**

Item content parts. ||
|| call_id | **string \| null**

Call ID for tool/function call items. ||
|| name | **string \| null**

Tool/function name for call items. ||
|| arguments | **string \| null**

Tool/function call arguments as JSON string. ||
|| output | **string \| null**

Tool/function output as string or JSON-encoded string. ||
|| metadata | **object \| null**

Developer-defined metadata. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
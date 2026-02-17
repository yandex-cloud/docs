---
editable: false
---

# REST: conversation.item.create

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/conversation.item.create
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "previous_item_id": "string",
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

Add a new item to the conversation context (messages, tool results, function calls, etc.). If successful, the server responds with conversation item events.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.create`.

- `conversation.item.create` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| previous_item_id | **string**

The ID of the preceding item after which the new item will be inserted. If omitted, the item is appended. Use `root` to insert at the beginning. ||
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
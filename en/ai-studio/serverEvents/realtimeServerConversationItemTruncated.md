---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemTruncated.md
---

# REST: conversation.item.truncated

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.truncated
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string",
  "content_index": "integer",
  "audio_end_ms": "integer"
}
```

Returned when an earlier assistant audio message item is truncated by the client with a `conversation.item.truncate` event.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.truncated`.

- `conversation.item.truncated` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the assistant message item that was truncated. ||
|| content_index | **integer**

Required field. The index of the content part that was truncated. ||
|| audio_end_ms | **integer**

Required field. The duration up to which the audio was truncated, in milliseconds. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
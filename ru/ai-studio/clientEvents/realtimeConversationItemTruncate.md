---
editable: false
---

# REST: conversation.item.truncate

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/conversation.item.truncate
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

Truncate an earlier assistant audio message item to synchronize server context with what the user actually heard. The server responds with `conversation.item.truncated`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.truncate`.

- `conversation.item.truncate` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
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
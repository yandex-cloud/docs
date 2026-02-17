---
editable: false
---

# REST: input_audio_buffer.committed

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/input_audio_buffer.committed
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "previous_item_id": "string",
  "item_id": "string"
}
```

Returned when the input audio buffer is committed (client or server VAD). `item_id` is the ID of the user message item that will be created.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.committed`.

- `input_audio_buffer.committed` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| previous_item_id | **string**

The ID of the preceding item (if applicable). ||
|| item_id | **string**

Required field. The ID of the user message item that will be created. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
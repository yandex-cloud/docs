---
editable: false
---

# REST: input_audio_buffer.speech_stopped

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/input_audio_buffer.speech_stopped
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "audio_end_ms": "integer",
  "item_id": "string"
}
```

Returned when speech stops in the input audio buffer (server VAD mode).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.speech_stopped`.

- `input_audio_buffer.speech_stopped` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| audio_end_ms | **integer**

Required field.  ||
|| item_id | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK
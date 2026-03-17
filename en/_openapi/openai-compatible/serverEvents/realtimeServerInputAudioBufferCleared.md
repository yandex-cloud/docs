---
editable: false
---

# REST: input_audio_buffer.cleared '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/input_audio_buffer.cleared
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string"
}
```

Returned when the input audio buffer is cleared.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.cleared`.

- `input_audio_buffer.cleared` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
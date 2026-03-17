---
editable: false
---

# REST: input_audio_buffer.clear '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/input_audio_buffer.clear
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string"
}
```

Clear the audio bytes in the input audio buffer. The server responds with `input_audio_buffer.cleared`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.clear`.

- `input_audio_buffer.clear` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
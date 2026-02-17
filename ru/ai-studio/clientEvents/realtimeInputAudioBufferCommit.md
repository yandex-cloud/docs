---
editable: false
---

# REST: input_audio_buffer.commit

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/input_audio_buffer.commit
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string"
}
```

Commit the user input audio buffer, creating a new user message item. Errors if the buffer is empty. The server responds with `input_audio_buffer.committed`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.commit`.

- `input_audio_buffer.commit` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
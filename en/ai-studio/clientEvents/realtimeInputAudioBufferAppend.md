---
editable: false
sourcePath: en/_openapi/openai-compatible/clientEvents/realtimeInputAudioBufferAppend.md
---

# REST: input_audio_buffer.append

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/input_audio_buffer.append
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "audio": "string"
}
```

Append audio bytes to the input audio buffer (base64). The buffer can be committed later into a new user message item. The server does not send a confirmation for this event.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.append`.

- `input_audio_buffer.append` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| audio | **string**

Required field. Base64-encoded audio bytes in the format specified by the session's `input_audio_format`. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
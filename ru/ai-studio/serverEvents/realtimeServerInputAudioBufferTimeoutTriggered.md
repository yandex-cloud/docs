---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerInputAudioBufferTimeoutTriggered.md
---

# REST: input_audio_buffer.timeout_triggered '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/input_audio_buffer.timeout_triggered
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "audio_start_ms": "integer",
  "audio_end_ms": "integer"
}
```

Returned when server VAD triggers a timeout (if configured).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.timeout_triggered`.

- `input_audio_buffer.timeout_triggered` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| audio_start_ms | **integer**

Required field.  ||
|| audio_end_ms | **integer**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK
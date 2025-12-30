---
editable: false
sourcePath: en/_openapi/openai-compatible/clientEvents/realtimeOutputAudioBufferClear.md
---

# REST: output_audio_buffer.clear '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/output_audio_buffer.clear
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string"
}
```

Clear the output audio buffer on the server side (used by some playback strategies).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `output_audio_buffer.clear`.

- `output_audio_buffer.clear` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerInputAudioBufferDtmfEventReceived.md
---

# REST: input_audio_buffer.dtmf_event_received '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/input_audio_buffer.dtmf_event_received
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "digit": "string",
  "timestamp_ms": "integer"
}
```

Returned when a DTMF event is received (telephony integrations).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `input_audio_buffer.dtmf_event_received`.

- `input_audio_buffer.dtmf_event_received` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| digit | **string**

Required field. The DTMF digit received. ||
|| timestamp_ms | **integer**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK
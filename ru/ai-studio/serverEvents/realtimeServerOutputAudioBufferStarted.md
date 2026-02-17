---
editable: false
---

# REST: output_audio_buffer.started '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/output_audio_buffer.started
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "response_id": "string"
}
```

Returned when the output audio buffer starts playing/streaming.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `output_audio_buffer.started`.

- `output_audio_buffer.started` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK
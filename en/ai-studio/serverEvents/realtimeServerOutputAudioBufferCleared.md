---
editable: false
---

# REST: output_audio_buffer.cleared '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/output_audio_buffer.cleared
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

Returned when the output audio buffer is cleared.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `output_audio_buffer.cleared`.

- `output_audio_buffer.cleared` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK
---
editable: false
---

# REST: response.output_audio_transcript.delta '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.output_audio_transcript.delta
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "response_id": "string",
  "output_index": "integer",
  "item_id": "string",
  "content_index": "integer",
  "delta": "string"
}
```

Returned when the model-generated transcription of audio output is updated.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.output_audio_transcript.delta`.

- `response.output_audio_transcript.delta` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field. The ID of the response. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the item. ||
|| content_index | **integer**

Required field. The index of the content part in the item's content array. ||
|| delta | **string**

Required field. The transcript delta. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
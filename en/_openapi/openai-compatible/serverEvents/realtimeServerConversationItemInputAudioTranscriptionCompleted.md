---
editable: false
---

# REST: conversation.item.input_audio_transcription.completed

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.input_audio_transcription.completed
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string",
  "content_index": "integer",
  "transcript": "string",
  "usage": "object"
}
```

Output of audio transcription for user audio written to the input audio buffer. Transcription begins when the buffer is committed (client or server VAD).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.input_audio_transcription.completed`.

- `conversation.item.input_audio_transcription.completed` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the item containing the audio that was transcribed. ||
|| content_index | **integer**

Required field. The index of the content part in the item's content array. ||
|| transcript | **string**

Required field. The transcribed text. ||
|| usage | **object**

Token usage information (when provided by the backend). ||
|#

## Response {#200}

**HTTP Code: 200**

OK
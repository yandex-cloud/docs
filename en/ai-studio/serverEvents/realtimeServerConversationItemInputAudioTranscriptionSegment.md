---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemInputAudioTranscriptionSegment.md
---

# REST: conversation.item.input_audio_transcription.segment '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.input_audio_transcription.segment
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string",
  "content_index": "integer",
  "id": "string",
  "speaker": "string",
  "start": "number",
  "end": "number",
  "text": "string"
}
```

Returned when an input audio transcription segment is identified for an item.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.input_audio_transcription.segment`.

- `conversation.item.input_audio_transcription.segment` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the item containing the input audio content. ||
|| content_index | **integer**

Required field. The index of the input audio content part within the item. ||
|| id | **string**

Required field. The segment identifier. ||
|| speaker | **string**

The detected speaker label for this segment. ||
|| start | **number**

Required field. Start time of the segment in seconds. ||
|| end | **number**

Required field. End time of the segment in seconds. ||
|| text | **string**

Required field. The text for this segment. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
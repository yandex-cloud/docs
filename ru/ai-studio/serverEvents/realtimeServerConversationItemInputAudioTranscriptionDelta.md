---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemInputAudioTranscriptionDelta.md
---

# REST: conversation.item.input_audio_transcription.delta '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.input_audio_transcription.delta
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string",
  "content_index": "integer",
  "delta": "string",
  "logprobs": [
    {}
  ]
}
```

Returned when incremental input audio transcription results are produced.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.input_audio_transcription.delta`.

- `conversation.item.input_audio_transcription.delta` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the item containing the audio that is being transcribed. ||
|| content_index | **integer**

Required field. The index of the content part in the item's content array. ||
|| delta | **string**

Required field. The text delta. ||
|| logprobs[] | **object** ||
|#

## Response {#200}

**HTTP Code: 200**

OK
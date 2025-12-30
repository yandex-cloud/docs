---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemInputAudioTranscriptionFailed.md
---

# REST: conversation.item.input_audio_transcription.failed '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.input_audio_transcription.failed
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string",
  "content_index": "integer",
  "error": {
    "type": "string",
    "code": "string",
    "message": "string",
    "param": "string | null",
    "event_id": "string | null"
  }
}
```

Returned when input audio transcription is configured and a transcription request for a user message failed. Separate from generic `error` so the client can identify the related item.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.input_audio_transcription.failed`.

- `conversation.item.input_audio_transcription.failed` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the user message item. ||
|| content_index | **integer**

Required field. The index of the content part containing the audio. ||
|| error | **[RealtimeErrorObject](#RealtimeErrorObject)**

Required field. Details of an error. ||
|#

## RealtimeErrorObject {#RealtimeErrorObject}

Details of an error.

#|
||Field | Description ||
|| type | **string**

Required field. Error type. ||
|| code | **string**

Error code, if available. ||
|| message | **string**

Required field. Human-readable error message. ||
|| param | **string \| null**

Parameter related to the error, if any. ||
|| event_id | **string \| null**

The client-supplied event_id that caused the error, if any. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
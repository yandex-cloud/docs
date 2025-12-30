---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerResponseContentPartAdded.md
---

# REST: response.content_part.added

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.content_part.added
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
  "part": "unknown"
}
```

Returned when a new content part is added to an assistant message item during response generation.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.content_part.added`.

- `response.content_part.added` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field. The ID of the response. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the item to which the content part belongs. ||
|| content_index | **integer**

Required field. The index of the content part in the item's content array. ||
|| part | One of **[RealtimeInputTextPart](#RealtimeInputTextPart)** \| **[RealtimeOutputTextPart](#RealtimeOutputTextPart)** \| **[RealtimeInputAudioPart](#RealtimeInputAudioPart)** \| **[RealtimeOutputAudioPart](#RealtimeOutputAudioPart)** ||
|#

## RealtimeInputTextPart {#RealtimeInputTextPart}

#|
||Field | Description ||
|| type | **enum**

Required field. 

- `input_text` ||
|| text | **string**

Required field. Input text. ||
|#

## RealtimeOutputTextPart {#RealtimeOutputTextPart}

#|
||Field | Description ||
|| type | **enum**

Required field. 

- `output_text` ||
|| text | **string \| null**

Final text (present in done events). ||
|#

## RealtimeInputAudioPart {#RealtimeInputAudioPart}

#|
||Field | Description ||
|| type | **enum**

Required field. 

- `input_audio` ||
|| audio | **string \| null**

Base64-encoded audio (only present when included). ||
|| transcript | **string \| null**

Input audio transcript, if available. ||
|#

## RealtimeOutputAudioPart {#RealtimeOutputAudioPart}

#|
||Field | Description ||
|| type | **enum**

Required field. 

- `output_audio` ||
|| audio | **string \| null**

Base64-encoded audio (omitted in response.done). ||
|| transcript | **string \| null**

Output audio transcript, if enabled. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
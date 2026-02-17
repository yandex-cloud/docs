---
editable: false
---

# REST: session.created

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/session.created
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "session": {
    "type": "string",
    "object": "string",
    "id": "string",
    "model": "string",
    "output_modalities": [
      "string"
    ],
    "instructions": "string",
    "tools": [
      {}
    ],
    "turn_detection": {},
    "input_audio_transcription": {},
    "voice": "string | null",
    "audio": {}
  }
}
```

Returned when a Session is created. Emitted automatically when a new connection is established as the first server event. Contains the default Session configuration.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `session.created`.

- `session.created` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| session | **[RealtimeSession](#RealtimeSession)**

Required field. Realtime session configuration object. ||
|#

## RealtimeSession {#RealtimeSession}

Realtime session configuration object.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of session. Always `realtime` for the Realtime API.

- `realtime`
- `transcription` ||
|| object | **string**

Object type identifier (e.g., realtime.session). ||
|| id | **string**

Unique identifier of the Realtime session. ||
|| model | **string**

Model used to generate responses during the session. Currently, only gpt://{YANDEX_CLOUD_FOLDER_ID}/speech-realtime-250923 is supported. ||
|| output_modalities[] | **string** ||
|| instructions | **string**

Default system instructions prepended to model calls. Used to guide response content, format, and audio behavior. ||
|| tools[] | **[ToolsItem](#null)** ||
|| turn_detection | **[TurnDetection](#null)**

Server-side turn detection (VAD) configuration for audio input. ||
|| input_audio_transcription | **[InputAudioTranscription](#null)**

Configuration for transcribing input audio. ||
|| voice | **string \| null**

Voice identifier for audio output. ||
|| audio | **[Audio](#null)**

Configuration for input and output audio. ||
|#

## Response {#200}

**HTTP Code: 200**

OK
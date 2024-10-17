---
editable: false
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/upload.md
---

# Talk Analytics API, REST: Talk.Upload {#Upload}

rpc for uploading talk document as single message

## HTTP request

```
POST https://speechsense.{{ api-host }}/speechsense/v1/talks/upload
```

## Body parameters {#yandex.cloud.speechsense.v1.UploadTalkRequest}

```json
{
  "metadata": {
    "connectionId": "string",
    "fields": "string",
    "users": [
      {
        "id": "string",
        "role": "string",
        "fields": "string"
      }
    ]
  },
  "audio": {
    "audioMetadata": {
      // Includes only one of the fields `rawAudio`, `containerAudio`
      "rawAudio": {
        "audioEncoding": "string",
        "sampleRateHertz": "string",
        "audioChannelCount": "string"
      },
      "containerAudio": {
        "containerAudioType": "string"
      }
      // end of the list of possible fields
    },
    "audioData": {
      "data": "string"
    }
  }
}
```

request to create audio dialog

#|
||Field | Description ||
|| metadata | **[TalkMetadata](#yandex.cloud.speechsense.v1.TalkMetadata)** ||
|| audio | **[AudioRequest](#yandex.cloud.speechsense.v1.AudioRequest)**

audio payload ||
|#

## TalkMetadata {#yandex.cloud.speechsense.v1.TalkMetadata}

#|
||Field | Description ||
|| connectionId | **string**

id of connection this talk belongs too ||
|| fields | **string**

channel defined fields ||
|| users[] | **[UserMetadata](#yandex.cloud.speechsense.v1.UserMetadata)**

per user specific metadata ||
|#

## UserMetadata {#yandex.cloud.speechsense.v1.UserMetadata}

#|
||Field | Description ||
|| id | **string** ||
|| role | **enum** (UserRole)

- `USER_ROLE_UNSPECIFIED`
- `USER_ROLE_OPERATOR`
- `USER_ROLE_CLIENT`
- `USER_ROLE_BOT` ||
|| fields | **string** ||
|#

## AudioRequest {#yandex.cloud.speechsense.v1.AudioRequest}

request for sending small audios (< 128 mb) in one go

#|
||Field | Description ||
|| audioMetadata | **[AudioMetadata](#yandex.cloud.speechsense.v1.AudioMetadata)**

audio metadata ||
|| audioData | **[AudioChunk](#yandex.cloud.speechsense.v1.AudioChunk)**

Bytes with audio data. ||
|#

## AudioMetadata {#yandex.cloud.speechsense.v1.AudioMetadata}

Audio format options.

#|
||Field | Description ||
|| rawAudio | **[RawAudio](#yandex.cloud.speechsense.v1.RawAudio)**

Audio without container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|| containerAudio | **[ContainerAudio](#yandex.cloud.speechsense.v1.ContainerAudio)**

Audio is wrapped in container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|#

## RawAudio {#yandex.cloud.speechsense.v1.RawAudio}

RAW Audio format spec (no container to infer type). Used in AudioFormat options.

#|
||Field | Description ||
|| audioEncoding | **enum** (AudioEncoding)

Type of audio encoding

- `AUDIO_ENCODING_UNSPECIFIED`
- `AUDIO_ENCODING_LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sampleRateHertz | **string** (int64)

PCM sample rate ||
|| audioChannelCount | **string** (int64)

PCM channel count. ||
|#

## ContainerAudio {#yandex.cloud.speechsense.v1.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| containerAudioType | **enum** (ContainerAudioType)

Type of audio container.

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `CONTAINER_AUDIO_TYPE_WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
- `CONTAINER_AUDIO_TYPE_OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
- `CONTAINER_AUDIO_TYPE_MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format. ||
|#

## AudioChunk {#yandex.cloud.speechsense.v1.AudioChunk}

Data chunk with audio.

#|
||Field | Description ||
|| data | **string** (bytes)

Bytes with audio data. ||
|#

## Response {#yandex.cloud.speechsense.v1.UploadTalkResponse}

**HTTP Code: 200 - OK**

```json
{
  "talkId": "string"
}
```

#|
||Field | Description ||
|| talkId | **string**

id of created talk document ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/upload.md
---

# Talk Analytics API, gRPC: TalkService.Upload

rpc for uploading talk document as single message

## gRPC request

**rpc Upload ([UploadTalkRequest](#yandex.cloud.speechsense.v1.UploadTalkRequest)) returns ([UploadTalkResponse](#yandex.cloud.speechsense.v1.UploadTalkResponse))**

## UploadTalkRequest {#yandex.cloud.speechsense.v1.UploadTalkRequest}

```json
{
  "metadata": {
    "connection_id": "string",
    "fields": "string",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "string"
      }
    ]
  },
  "audio": {
    "audio_metadata": {
      // Includes only one of the fields `raw_audio`, `container_audio`
      "raw_audio": {
        "audio_encoding": "AudioEncoding",
        "sample_rate_hertz": "int64",
        "audio_channel_count": "int64"
      },
      "container_audio": {
        "container_audio_type": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "audio_data": {
      "data": "bytes"
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
|| connection_id | **string**

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
|| role | enum **UserRole**

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
|| audio_metadata | **[AudioMetadata](#yandex.cloud.speechsense.v1.AudioMetadata)**

audio metadata ||
|| audio_data | **[AudioChunk](#yandex.cloud.speechsense.v1.AudioChunk)**

Bytes with audio data. ||
|#

## AudioMetadata {#yandex.cloud.speechsense.v1.AudioMetadata}

Audio format options.

#|
||Field | Description ||
|| raw_audio | **[RawAudio](#yandex.cloud.speechsense.v1.RawAudio)**

Audio without container.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|| container_audio | **[ContainerAudio](#yandex.cloud.speechsense.v1.ContainerAudio)**

Audio is wrapped in container.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|#

## RawAudio {#yandex.cloud.speechsense.v1.RawAudio}

RAW Audio format spec (no container to infer type). Used in AudioFormat options.

#|
||Field | Description ||
|| audio_encoding | enum **AudioEncoding**

Type of audio encoding

- `AUDIO_ENCODING_UNSPECIFIED`
- `AUDIO_ENCODING_LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sample_rate_hertz | **int64**

PCM sample rate ||
|| audio_channel_count | **int64**

PCM channel count. ||
|#

## ContainerAudio {#yandex.cloud.speechsense.v1.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| container_audio_type | enum **ContainerAudioType**

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
|| data | **bytes**

Bytes with audio data. ||
|#

## UploadTalkResponse {#yandex.cloud.speechsense.v1.UploadTalkResponse}

```json
{
  "talk_id": "string"
}
```

#|
||Field | Description ||
|| talk_id | **string**

id of created talk document ||
|#
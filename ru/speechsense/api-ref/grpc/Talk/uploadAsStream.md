---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/uploadAsStream.md
---

# Talk Analytics API, gRPC: TalkService.UploadAsStream {#UploadAsStream}

rpc for streaming talk documents. First message should contain Talk related metadata,
second - audio metadata, others should contain audio bytes in chunks

## gRPC request

**rpc UploadAsStream (stream [StreamTalkRequest](#yandex.cloud.speechsense.v1.StreamTalkRequest)) returns ([UploadTalkResponse](#yandex.cloud.speechsense.v1.UploadTalkResponse))**

## StreamTalkRequest {#yandex.cloud.speechsense.v1.StreamTalkRequest}

```json
{
  // Includes only one of the fields `metadata`, `audio`
  "metadata": {
    "connectionId": "string",
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
    // Includes only one of the fields `audioMetadata`, `chunk`
    "audioMetadata": {
      // Includes only one of the fields `rawAudio`, `containerAudio`
      "rawAudio": {
        "audioEncoding": "AudioEncoding",
        "sampleRateHertz": "int64",
        "audioChannelCount": "int64"
      },
      "containerAudio": {
        "containerAudioType": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "chunk": {
      "data": "bytes"
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
}
```

streaming request to create audio dialog

#|
||Field | Description ||
|| metadata | **[TalkMetadata](#yandex.cloud.speechsense.v1.TalkMetadata)**

talk document metadata containing channel id and channel field values

Includes only one of the fields `metadata`, `audio`. ||
|| audio | **[AudioStreamingRequest](#yandex.cloud.speechsense.v1.AudioStreamingRequest)**

audio metadata or chunk

Includes only one of the fields `metadata`, `audio`. ||
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
|| role | enum **UserRole**

- `USER_ROLE_UNSPECIFIED`
- `USER_ROLE_OPERATOR`
- `USER_ROLE_CLIENT`
- `USER_ROLE_BOT` ||
|| fields | **string** ||
|#

## AudioStreamingRequest {#yandex.cloud.speechsense.v1.AudioStreamingRequest}

Streaming audio request
First message should be audio metadata.
The next messages are audio data chunks.

#|
||Field | Description ||
|| audioMetadata | **[AudioMetadata](#yandex.cloud.speechsense.v1.AudioMetadata)**

Session options. Should be the first message from user.

Includes only one of the fields `audioMetadata`, `chunk`. ||
|| chunk | **[AudioChunk](#yandex.cloud.speechsense.v1.AudioChunk)**

Chunk with audio data.

Includes only one of the fields `audioMetadata`, `chunk`. ||
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
|| audioEncoding | enum **AudioEncoding**

Type of audio encoding

- `AUDIO_ENCODING_UNSPECIFIED`
- `AUDIO_ENCODING_LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sampleRateHertz | **int64**

PCM sample rate ||
|| audioChannelCount | **int64**

PCM channel count. ||
|#

## ContainerAudio {#yandex.cloud.speechsense.v1.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| containerAudioType | enum **ContainerAudioType**

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
  "talkId": "string"
}
```

#|
||Field | Description ||
|| talkId | **string**

id of created talk document ||
|#
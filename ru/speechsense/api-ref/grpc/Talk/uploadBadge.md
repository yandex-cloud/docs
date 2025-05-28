---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/uploadBadge.md
---

# Talk Analytics API, gRPC: TalkService.UploadBadge

rpc for streaming document that contains combined talks. First message should contain Talk related metadata,
second - audio metadata, others should contain audio bytes in chunks

## gRPC request

**rpc UploadBadge (stream [StreamTalkRequest](#yandex.cloud.speechsense.v1.StreamTalkRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StreamTalkRequest {#yandex.cloud.speechsense.v1.StreamTalkRequest}

```json
{
  // Includes only one of the fields `metadata`, `audio`
  "metadata": {
    "connection_id": "string",
    "fields": "map<string, string>",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "map<string, string>"
      }
    ]
  },
  "audio": {
    // Includes only one of the fields `audio_metadata`, `chunk`
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
|| connection_id | **string**

id of connection this talk belongs too ||
|| fields | **object** (map<**string**, **string**>)

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
|| fields | **object** (map<**string**, **string**>) ||
|#

## AudioStreamingRequest {#yandex.cloud.speechsense.v1.AudioStreamingRequest}

Streaming audio request
First message should be audio metadata.
The next messages are audio data chunks.

#|
||Field | Description ||
|| audio_metadata | **[AudioMetadata](#yandex.cloud.speechsense.v1.AudioMetadata)**

Session options. Should be the first message from user.

Includes only one of the fields `audio_metadata`, `chunk`. ||
|| chunk | **[AudioChunk](#yandex.cloud.speechsense.v1.AudioChunk)**

Chunk with audio data.

Includes only one of the fields `audio_metadata`, `chunk`. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "badge_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "badge_id": "string",
    "talk_ids": [
      "string"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UploadBadgeMetadata](#yandex.cloud.speechsense.v1.UploadBadgeMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[UploadBadgeResponse](#yandex.cloud.speechsense.v1.UploadBadgeResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UploadBadgeMetadata {#yandex.cloud.speechsense.v1.UploadBadgeMetadata}

#|
||Field | Description ||
|| badge_id | **string**

id of uploaded badge ||
|#

## UploadBadgeResponse {#yandex.cloud.speechsense.v1.UploadBadgeResponse}

#|
||Field | Description ||
|| badge_id | **string**

id of uploaded badge ||
|| talk_ids[] | **string**

id of created talks related to badge ||
|#
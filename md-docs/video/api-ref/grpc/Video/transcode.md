[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Video](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Video](index.md) > Transcode

# Video API, gRPC: VideoService.Transcode

Initiates or updates video transcoding with specified parameters.
Can be used to start transcoding for videos with auto_transcode=DISABLE,
or to re-process a completed video with new transcoding settings.
Supports additional features like subtitle processing, translation, summarization, and speech-to-text.

## gRPC request

**rpc Transcode ([TranscodeVideoRequest](#yandex.cloud.video.v1.TranscodeVideoRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## TranscodeVideoRequest {#yandex.cloud.video.v1.TranscodeVideoRequest}

```json
{
  "video_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "subtitle_ids": [
    "string"
  ],
  "translation_settings": {
    "tracks": [
      {
        "input_track": {
          "track_index": "int64",
          "src_lang": "string"
        },
        "subtitles": [
          {
            "dst_lang": "string",
            "label": "string"
          }
        ],
        "audio": [
          {
            "dst_lang": "string",
            "label": "string"
          }
        ]
      }
    ]
  },
  "summarization_settings": {
    "tracks": [
      {
        "input_track": {
          "track_index": "int64",
          "src_lang": "string"
        }
      }
    ],
    "process_all_tracks": "bool"
  },
  "speech_to_text_settings": {
    "tracks": [
      {
        "input_track": {
          "track_index": "int64",
          "src_lang": "string"
        }
      }
    ],
    "process_all_tracks": "bool"
  }
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video to transcode.

The maximum string length in characters is 50. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which transcoding-specific fields should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| subtitle_ids[] | **string**

IDs of manually uploaded subtitle files to include in the transcoding process.
These subtitles will be embedded in the video output. ||
|| translation_settings | **[VideoTranslationSettings](#yandex.cloud.video.v1.VideoTranslationSettings)**

Settings for automatic translation of audio tracks.
Defines source tracks and target languages for subtitle and audio translation. ||
|| summarization_settings | **[VideoSummarizationSettings](#yandex.cloud.video.v1.VideoSummarizationSettings)**

Settings for automatic video content summarization.
Defines which audio tracks should be processed to generate text summaries. ||
|| speech_to_text_settings | **[VideoSpeechToTextSettings](#yandex.cloud.video.v1.VideoSpeechToTextSettings)**

Settings for automatic speech recognition (speech-to-text).
Defines which audio tracks should be transcribed to generate text transcripts. ||
|#

## VideoTranslationSettings {#yandex.cloud.video.v1.VideoTranslationSettings}

#|
||Field | Description ||
|| tracks[] | **[TranslationTrack](#yandex.cloud.video.v1.VideoTranslationSettings.TranslationTrack)**

Translation settings for each track. ||
|#

## TranslationTrack {#yandex.cloud.video.v1.VideoTranslationSettings.TranslationTrack}

#|
||Field | Description ||
|| input_track | **[InputTrack](#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack)**

Required field. Input track settings. ||
|| subtitles[] | **[SubtitleTrack](#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack)**

Settings for target subtitle tracks. ||
|| audio[] | **[AudioTrack](#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack)**

Settings for target audio tracks. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack}

#|
||Field | Description ||
|| track_index | **int64**

Input audio track index (one-based).

The minimum value is 1. ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
Track language will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible.

Value must match the regular expression ``` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho ```. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` ara|deu|eng|fra|ita|jpn|kaz|kor|rus|spa|tur|ukr|zho ```. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback.

The maximum string length in characters is 50. ||
|#

## AudioTrack {#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` eng|kaz|rus ```. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback.

The maximum string length in characters is 50. ||
|#

## VideoSummarizationSettings {#yandex.cloud.video.v1.VideoSummarizationSettings}

#|
||Field | Description ||
|| tracks[] | **[SummarizationTrack](#yandex.cloud.video.v1.VideoSummarizationSettings.SummarizationTrack)**

Summarization settings for each track. ||
|| process_all_tracks | **bool**

Summarize all available tracks.
If enabled, `tracks` parameter is ignored.
Enables automatic source language deduction for each track
and thus may lead to performance degradation. ||
|#

## SummarizationTrack {#yandex.cloud.video.v1.VideoSummarizationSettings.SummarizationTrack}

#|
||Field | Description ||
|| input_track | **[InputTrack](#yandex.cloud.video.v1.VideoSummarizationSettings.InputTrack)**

Required field. Input track settings. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoSummarizationSettings.InputTrack}

#|
||Field | Description ||
|| track_index | **int64**

Input audio track index (one-based).

The minimum value is 1. ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
It will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible.

Value must match the regular expression ``` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho ```. ||
|#

## VideoSpeechToTextSettings {#yandex.cloud.video.v1.VideoSpeechToTextSettings}

#|
||Field | Description ||
|| tracks[] | **[SpeechToTextTrack](#yandex.cloud.video.v1.VideoSpeechToTextSettings.SpeechToTextTrack)**

Speech-to-text settings for each track. ||
|| process_all_tracks | **bool**

Recognize speech from all available tracks.
If enabled, `tracks` parameter is ignored.
Enables automatic source language deduction for each track
and thus may lead to performance degradation. ||
|#

## SpeechToTextTrack {#yandex.cloud.video.v1.VideoSpeechToTextSettings.SpeechToTextTrack}

#|
||Field | Description ||
|| input_track | **[InputTrack](#yandex.cloud.video.v1.VideoSpeechToTextSettings.InputTrack)**

Required field. Input track settings. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoSpeechToTextSettings.InputTrack}

#|
||Field | Description ||
|| track_index | **int64**

Input audio track index (one-based).

The minimum value is 1. ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
It will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible.

Value must match the regular expression ``` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho ```. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
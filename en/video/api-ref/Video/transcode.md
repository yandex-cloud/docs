---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos/{videoId}:transcode
    method: post
    path:
      type: object
      properties:
        videoId:
          description: |-
            **string**
            Required field. ID of the video to transcode.
            The maximum string length in characters is 50.
          type: string
      required:
        - videoId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        fieldMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        subtitleIds:
          description: |-
            **string**
            IDs of manually uploaded subtitle files to include in the transcoding process.
            These subtitles will be embedded in the video output.
          type: array
          items:
            type: string
        translationSettings:
          description: |-
            **[VideoTranslationSettings](#yandex.cloud.video.v1.VideoTranslationSettings)**
            Settings for automatic translation of audio tracks.
            Defines source tracks and target languages for subtitle and audio translation.
          $ref: '#/definitions/VideoTranslationSettings'
        summarizationSettings:
          description: |-
            **[VideoSummarizationSettings](#yandex.cloud.video.v1.VideoSummarizationSettings)**
            Settings for automatic video content summarization.
            Defines which audio tracks should be processed to generate text summaries.
          $ref: '#/definitions/VideoSummarizationSettings'
        speechToTextSettings:
          description: |-
            **[VideoSpeechToTextSettings](#yandex.cloud.video.v1.VideoSpeechToTextSettings)**
            Settings for automatic speech recognition (speech-to-text).
            Defines which audio tracks should be transcribed to generate text transcripts.
          $ref: '#/definitions/VideoSpeechToTextSettings'
      required:
        - fieldMask
      additionalProperties: false
    definitions:
      InputTrack:
        type: object
        properties:
          trackIndex:
            description: |-
              **string** (int64)
              Input audio track index (one-based).
              The minimum value is 1.
            type: string
            format: int64
          srcLang:
            description: |-
              **string**
              Source track language represented as a three-letter code according to ISO 639-2/T.
              Track language will be deduced automatically if not provided.
              In the latter case the deduction accuracy is not guaranteed.
              For better performance please do specify the source track language when possible.
              Value must match the regular expression ` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho `.
            pattern: '|ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho'
            type: string
      SubtitleTrack:
        type: object
        properties:
          dstLang:
            description: |-
              **string**
              Required field. Target language represented as a three-letter code according to ISO 639-2/T.
              Value must match the regular expression ` ara|deu|eng|fra|ita|jpn|kaz|kor|rus|spa|tur|ukr|zho `.
            pattern: ara|deu|eng|fra|ita|jpn|kaz|kor|rus|spa|tur|ukr|zho
            type: string
          label:
            description: |-
              **string**
              Required field. Track label to be displayed on the screen during video playback.
              The maximum string length in characters is 50.
            type: string
        required:
          - dstLang
          - label
      AudioTrack:
        type: object
        properties:
          dstLang:
            description: |-
              **string**
              Required field. Target language represented as a three-letter code according to ISO 639-2/T.
              Value must match the regular expression ` eng|kaz|rus `.
            pattern: eng|kaz|rus
            type: string
          label:
            description: |-
              **string**
              Required field. Track label to be displayed on the screen during video playback.
              The maximum string length in characters is 50.
            type: string
        required:
          - dstLang
          - label
      TranslationTrack:
        type: object
        properties:
          inputTrack:
            description: |-
              **[InputTrack](#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack)**
              Required field. Input track settings.
            $ref: '#/definitions/InputTrack'
          subtitles:
            description: |-
              **[SubtitleTrack](#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack)**
              Settings for target subtitle tracks.
            type: array
            items:
              $ref: '#/definitions/SubtitleTrack'
          audio:
            description: |-
              **[AudioTrack](#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack)**
              Settings for target audio tracks.
            type: array
            items:
              $ref: '#/definitions/AudioTrack'
        required:
          - inputTrack
      VideoTranslationSettings:
        type: object
        properties:
          tracks:
            description: |-
              **[TranslationTrack](#yandex.cloud.video.v1.VideoTranslationSettings.TranslationTrack)**
              Translation settings for each track.
            type: array
            items:
              $ref: '#/definitions/TranslationTrack'
      SummarizationTrack:
        type: object
        properties:
          inputTrack:
            description: |-
              **[InputTrack](#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack)**
              Required field. Input track settings.
            $ref: '#/definitions/InputTrack'
        required:
          - inputTrack
      VideoSummarizationSettings:
        type: object
        properties:
          tracks:
            description: |-
              **[SummarizationTrack](#yandex.cloud.video.v1.VideoSummarizationSettings.SummarizationTrack)**
              Summarization settings for each track.
            type: array
            items:
              $ref: '#/definitions/SummarizationTrack'
          processAllTracks:
            description: |-
              **boolean**
              Summarize all available tracks.
              If enabled, `tracks` parameter is ignored.
              Enables automatic source language deduction for each track
              and thus may lead to performance degradation.
            type: boolean
      SpeechToTextTrack:
        type: object
        properties:
          inputTrack:
            description: |-
              **[InputTrack](#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack)**
              Required field. Input track settings.
            $ref: '#/definitions/InputTrack'
        required:
          - inputTrack
      VideoSpeechToTextSettings:
        type: object
        properties:
          tracks:
            description: |-
              **[SpeechToTextTrack](#yandex.cloud.video.v1.VideoSpeechToTextSettings.SpeechToTextTrack)**
              Speech-to-text settings for each track.
            type: array
            items:
              $ref: '#/definitions/SpeechToTextTrack'
          processAllTracks:
            description: |-
              **boolean**
              Recognize speech from all available tracks.
              If enabled, `tracks` parameter is ignored.
              Enables automatic source language deduction for each track
              and thus may lead to performance degradation.
            type: boolean
---

# Video API, REST: Video.Transcode

Initiates or updates video transcoding with specified parameters.
Can be used to start transcoding for videos with auto_transcode=DISABLE,
or to re-process a completed video with new transcoding settings.
Supports additional features like subtitle processing, translation, summarization, and speech-to-text.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos/{videoId}:transcode
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video to transcode.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.video.v1.TranscodeVideoRequest}

```json
{
  "fieldMask": "string",
  "subtitleIds": [
    "string"
  ],
  "translationSettings": {
    "tracks": [
      {
        "inputTrack": {
          "trackIndex": "string",
          "srcLang": "string"
        },
        "subtitles": [
          {
            "dstLang": "string",
            "label": "string"
          }
        ],
        "audio": [
          {
            "dstLang": "string",
            "label": "string"
          }
        ]
      }
    ]
  },
  "summarizationSettings": {
    "tracks": [
      {
        "inputTrack": {
          "trackIndex": "string",
          "srcLang": "string"
        }
      }
    ],
    "processAllTracks": "boolean"
  },
  "speechToTextSettings": {
    "tracks": [
      {
        "inputTrack": {
          "trackIndex": "string",
          "srcLang": "string"
        }
      }
    ],
    "processAllTracks": "boolean"
  }
}
```

#|
||Field | Description ||
|| fieldMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| subtitleIds[] | **string**

IDs of manually uploaded subtitle files to include in the transcoding process.
These subtitles will be embedded in the video output. ||
|| translationSettings | **[VideoTranslationSettings](#yandex.cloud.video.v1.VideoTranslationSettings)**

Settings for automatic translation of audio tracks.
Defines source tracks and target languages for subtitle and audio translation. ||
|| summarizationSettings | **[VideoSummarizationSettings](#yandex.cloud.video.v1.VideoSummarizationSettings)**

Settings for automatic video content summarization.
Defines which audio tracks should be processed to generate text summaries. ||
|| speechToTextSettings | **[VideoSpeechToTextSettings](#yandex.cloud.video.v1.VideoSpeechToTextSettings)**

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
|| inputTrack | **[InputTrack](#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack)**

Required field. Input track settings. ||
|| subtitles[] | **[SubtitleTrack](#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack)**

Settings for target subtitle tracks. ||
|| audio[] | **[AudioTrack](#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack)**

Settings for target audio tracks. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoTranslationSettings.InputTrack}

#|
||Field | Description ||
|| trackIndex | **string** (int64)

Input audio track index (one-based).

The minimum value is 1. ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
Track language will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible.

Value must match the regular expression ``` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho ```. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack}

#|
||Field | Description ||
|| dstLang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` ara|deu|eng|fra|ita|jpn|kaz|kor|rus|spa|tur|ukr|zho ```. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback.

The maximum string length in characters is 50. ||
|#

## AudioTrack {#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack}

#|
||Field | Description ||
|| dstLang | **string**

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
|| processAllTracks | **boolean**

Summarize all available tracks.
If enabled, `tracks` parameter is ignored.
Enables automatic source language deduction for each track
and thus may lead to performance degradation. ||
|#

## SummarizationTrack {#yandex.cloud.video.v1.VideoSummarizationSettings.SummarizationTrack}

#|
||Field | Description ||
|| inputTrack | **[InputTrack](#yandex.cloud.video.v1.VideoSummarizationSettings.InputTrack)**

Required field. Input track settings. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoSummarizationSettings.InputTrack}

#|
||Field | Description ||
|| trackIndex | **string** (int64)

Input audio track index (one-based).

The minimum value is 1. ||
|| srcLang | **string**

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
|| processAllTracks | **boolean**

Recognize speech from all available tracks.
If enabled, `tracks` parameter is ignored.
Enables automatic source language deduction for each track
and thus may lead to performance degradation. ||
|#

## SpeechToTextTrack {#yandex.cloud.video.v1.VideoSpeechToTextSettings.SpeechToTextTrack}

#|
||Field | Description ||
|| inputTrack | **[InputTrack](#yandex.cloud.video.v1.VideoSpeechToTextSettings.InputTrack)**

Required field. Input track settings. ||
|#

## InputTrack {#yandex.cloud.video.v1.VideoSpeechToTextSettings.InputTrack}

#|
||Field | Description ||
|| trackIndex | **string** (int64)

Input audio track index (one-based).

The minimum value is 1. ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
It will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible.

Value must match the regular expression ``` |ara|deu|eng|fra|ita|jpn|kor|rus|spa|tur|zho ```. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#
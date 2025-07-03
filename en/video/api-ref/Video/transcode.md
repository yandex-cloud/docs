---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/transcode.md
---

# Video API, REST: Video.Transcode

Transcode video.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos/{videoId}:transcode
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video. ||
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

IDs of active manually uploaded video subtitles. ||
|| translationSettings | **[VideoTranslationSettings](#yandex.cloud.video.v1.VideoTranslationSettings)**

Video translation settings. ||
|| summarizationSettings | **[VideoSummarizationSettings](#yandex.cloud.video.v1.VideoSummarizationSettings)**

Video summarization settings. ||
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

Input audio track index (one-based). ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
Track language will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack}

#|
||Field | Description ||
|| dstLang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback. ||
|#

## AudioTrack {#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack}

#|
||Field | Description ||
|| dstLang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback. ||
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

Input audio track index (one-based). ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
It will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible. ||
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
  "metadata": {
    "videoId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "channelId": "string",
    "title": "string",
    "description": "string",
    "thumbnailId": "string",
    "status": "string",
    "errorMessage": "string",
    "visibilityStatus": "string",
    "duration": "string",
    "autoTranscode": "string",
    "enableAd": "boolean",
    "subtitleIds": [
      "string"
    ],
    "features": {
      "summary": {
        "result": "string",
        "urls": [
          {
            "url": "string",
            "trackIndex": "string",
            "srcLang": "string"
          }
        ]
      }
    },
    // Includes only one of the fields `tusd`
    "tusd": {
      "url": "string",
      "fileSize": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `publicAccess`, `signUrlAccess`
    "publicAccess": "object",
    "signUrlAccess": "object",
    // end of the list of possible fields
    "createdAt": "string",
    "updatedAt": "string",
    "labels": "object"
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
|| metadata | **[TranscodeVideoMetadata](#yandex.cloud.video.v1.TranscodeVideoMetadata)**

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
|| response | **[Video](#yandex.cloud.video.v1.Video)**

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

## TranscodeVideoMetadata {#yandex.cloud.video.v1.TranscodeVideoMetadata}

#|
||Field | Description ||
|| videoId | **string**

ID of the video. ||
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

## Video {#yandex.cloud.video.v1.Video}

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channelId | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title displayed to users. ||
|| description | **string**

Detailed description of the video. ||
|| thumbnailId | **string**

ID of the video's thumbnail image. ||
|| status | **enum** (VideoStatus)

Video status.

- `VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.
- `WAIT_UPLOADING`: Waiting for all the bytes to be loaded.
- `UPLOADED`: Fully uploaded, ready to be transcoded.
- `PROCESSING`: Video is being processed.
- `READY`: Successfully processed and ready for use.
- `ERROR`: Video processing has failed. ||
|| errorMessage | **string**

Error message describing the reason for video processing failure, if any. ||
|| visibilityStatus | **enum** (VisibilityStatus)

Visibility status of the video.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video published and available for public viewing.
- `UNPUBLISHED`: Video unpublished, available only to administrators. ||
|| duration | **string** (duration)

Video duration. Optional, may be empty until the transcoding result is ready. ||
|| autoTranscode | **enum** (AutoTranscode)

Auto-transcoding setting.
Set ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `AUTO_TRANSCODE_UNSPECIFIED`: Unspecified auto transcoding value.
- `ENABLE`: Enable auto transcoding.
- `DISABLE`: Disable auto transcoding. ||
|| enableAd | **boolean**

Enable advertisement for this video.
Default: true.
Set explicitly to false to disable advertisements for a specific video. ||
|| subtitleIds[] | **string**

List of IDs defining the active subtitles for the video. ||
|| features | **[VideoFeatures](#yandex.cloud.video.v1.VideoFeatures)**

Additional video processing features and their results. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Video upload source definition (one source variant must be chosen). ||
|| publicAccess | **object**

Publicly accessible video available for viewing by anyone with the direct link.
No additional authorization or access control is applied.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings. ||
|| signUrlAccess | **object**

Checking access rights using url's signature.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings. ||
|| createdAt | **string** (date-time)

Time when video was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last video update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## VideoFeatures {#yandex.cloud.video.v1.VideoFeatures}

#|
||Field | Description ||
|| summary | **[Summary](#yandex.cloud.video.v1.VideoFeatures.Summary)**

Summarization result. ||
|#

## Summary {#yandex.cloud.video.v1.VideoFeatures.Summary}

#|
||Field | Description ||
|| result | **enum** (FeatureResult)

- `FEATURE_RESULT_UNSPECIFIED`
- `NOT_REQUESTED`: Feature has not been requested.
- `PROCESSING`: Feature is being processed.
- `SUCCESS`: Feature processing completed successfully.
- `FAILED`: Feature processing has failed. ||
|| urls[] | **[SummaryURL](#yandex.cloud.video.v1.VideoFeatures.Summary.SummaryURL)** ||
|#

## SummaryURL {#yandex.cloud.video.v1.VideoFeatures.Summary.SummaryURL}

#|
||Field | Description ||
|| url | **string** ||
|| trackIndex | **string** (int64)

Input audio track index (one-based). ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
Either provided in transcoding settings earlier or automatically deduced. ||
|#

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

Video upload source via tus protocol.

#|
||Field | Description ||
|| url | **string**

URL for uploading video via the tus protocol. ||
|| fileSize | **string** (int64)

Size of the uploaded file, in bytes. ||
|#
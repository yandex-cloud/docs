---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/transcode.md
---

# Video API, gRPC: VideoService.Transcode

Initiates or updates video transcoding with specified parameters.
Can be used to start transcoding for videos with auto_transcode=DISABLE,
or to re-process a completed video with new transcoding settings.
Supports additional features like subtitle processing, translation, and summarization.

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
  }
}
```

#|
||Field | Description ||
|| video_id | **string**

ID of the video to transcode. ||
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

Input audio track index (one-based). ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
Track language will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.VideoTranslationSettings.SubtitleTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback. ||
|#

## AudioTrack {#yandex.cloud.video.v1.VideoTranslationSettings.AudioTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Required field. Track label to be displayed on the screen during video playback. ||
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

Input audio track index (one-based). ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.
It will be deduced automatically if not provided.
In the latter case the deduction accuracy is not guaranteed.
For better performance please do specify the source track language when possible. ||
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
    "video_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
    "title": "string",
    "description": "string",
    "thumbnail_id": "string",
    "status": "VideoStatus",
    "error_message": "string",
    "visibility_status": "VisibilityStatus",
    "duration": "google.protobuf.Duration",
    "auto_transcode": "AutoTranscode",
    "style_preset_id": "string",
    "enable_ad": "google.protobuf.BoolValue",
    "subtitle_ids": [
      "string"
    ],
    "features": {
      "summary": {
        "result": "FeatureResult",
        "urls": [
          {
            "url": "string",
            "track_index": "int64",
            "src_lang": "string"
          }
        ]
      }
    },
    // Includes only one of the fields `tusd`
    "tusd": {
      "url": "string",
      "file_size": "int64"
    },
    // end of the list of possible fields
    // Includes only one of the fields `public_access`, `sign_url_access`
    "public_access": "VideoPublicAccessRights",
    "sign_url_access": "VideoSignURLAccessRights",
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[TranscodeVideoMetadata](#yandex.cloud.video.v1.TranscodeVideoMetadata)**

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
|| video_id | **string**

ID of the video. ||
|#

## Video {#yandex.cloud.video.v1.Video}

Main entity representing a video in the platform.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the video. ||
|| channel_id | **string**

Identifier of the channel where the video is created and managed. ||
|| title | **string**

Title of the video displayed to users in interfaces and players. ||
|| description | **string**

Detailed description of the video content and context. ||
|| thumbnail_id | **string**

Identifier of the thumbnail image used to represent the video visually. ||
|| status | enum **VideoStatus**

Current processing status of the video.

- `VIDEO_STATUS_UNSPECIFIED`: The video status is not specified.
- `WAIT_UPLOADING`: The video upload is in progress, waiting for all bytes to be received.
- `UPLOADED`: The video has been fully uploaded and is ready for transcoding.
- `PROCESSING`: The video is currently being processed.
- `READY`: The video has been successfully processed and is ready for watching.
- `ERROR`: An error occurred during video processing. ||
|| error_message | **string**

Error message describing the reason for video processing failure, if any. ||
|| visibility_status | enum **VisibilityStatus**

Current visibility status controlling whether the video is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The video is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The video is available only to administrators. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Total duration of the video.
Optional, may be empty until the transcoding result is ready. ||
|| auto_transcode | enum **AutoTranscode**

Auto-transcoding setting that controls the video processing workflow.
Set ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `AUTO_TRANSCODE_UNSPECIFIED`: The auto-transcoding setting is not specified.
- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| style_preset_id | **string**

Identifier of the style preset applied to the video during processing. ||
|| enable_ad | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls the ability to display advertisements for this video.
Default: true.
Set explicitly to false to disable advertisements for a specific video. ||
|| subtitle_ids[] | **string**

List of identifiers defining the active subtitles available for the video. ||
|| features | **[VideoFeatures](#yandex.cloud.video.v1.VideoFeatures)**

Additional video processing features and their results, such as summarization. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
@see https://tus.io/

Includes only one of the fields `tusd`.

Specifies the video upload source method (one source variant must be chosen). ||
|| public_access | **[VideoPublicAccessRights](#yandex.cloud.video.v1.VideoPublicAccessRights)**

Allows unrestricted public access to the video via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the video access permission settings. ||
|| sign_url_access | **[VideoSignURLAccessRights](#yandex.cloud.video.v1.VideoSignURLAccessRights)**

Restricts video access using URL signatures for secure time-limited access.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the video access permission settings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the video was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the video or its metadata. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per video.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## VideoFeatures {#yandex.cloud.video.v1.VideoFeatures}

Contains additional processing features and their results for the video.

#|
||Field | Description ||
|| summary | **[Summary](#yandex.cloud.video.v1.VideoFeatures.Summary)**

Results of the video content summarization process. ||
|#

## Summary {#yandex.cloud.video.v1.VideoFeatures.Summary}

Contains the results of video summarization.

#|
||Field | Description ||
|| result | enum **FeatureResult**

Current status of the summarization process.

- `FEATURE_RESULT_UNSPECIFIED`: The feature result status is not specified.
- `NOT_REQUESTED`: The feature processing has not been requested.
- `PROCESSING`: The feature is currently being processed.
- `SUCCESS`: The feature processing has completed successfully.
- `FAILED`: The feature processing has failed. ||
|| urls[] | **[SummaryURL](#yandex.cloud.video.v1.VideoFeatures.Summary.SummaryURL)**

List of URLs to summarization results for different audio tracks. ||
|#

## SummaryURL {#yandex.cloud.video.v1.VideoFeatures.Summary.SummaryURL}

Contains a URL to a summarization result for a specific audio track.

#|
||Field | Description ||
|| url | **string**

URL to the summarization result file. ||
|| track_index | **int64**

Input audio track index (one-based) that was summarized. ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T. ||
|#

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

Represents a video upload source using the TUS (Tus Resumable Upload Protocol) protocol.
This is a push-based upload method where the client pushes data to the server.
@see https://tus.io/

#|
||Field | Description ||
|| url | **string**

URL endpoint for uploading the video via the TUS protocol. ||
|| file_size | **int64**

Total size of the uploaded file, in bytes. ||
|#

## VideoPublicAccessRights {#yandex.cloud.video.v1.VideoPublicAccessRights}

Represents public access rights for a video.
When this access type is set, the video is publicly accessible via direct link.

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessRights {#yandex.cloud.video.v1.VideoSignURLAccessRights}

Represents access rights controlled by URL signatures.
When this access type is set, the video is accessible only via properly signed temporary link.

#|
||Field | Description ||
|| Empty | > ||
|#
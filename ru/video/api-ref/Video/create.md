---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel where the video will be created.
          type: string
        title:
          description: |-
            **string**
            Required field. Title of the video to be displayed in interfaces and players.
          type: string
        description:
          description: |-
            **string**
            Detailed description of the video content and context.
            Optional field that can provide additional information about the video.
          type: string
        thumbnailId:
          description: |-
            **string**
            ID of the thumbnail image to be used for the video.
            If not provided, a thumbnail may be automatically generated during transcoding.
          type: string
        autoTranscode:
          description: |-
            **enum** (AutoTranscode)
            Controls whether transcoding starts automatically after upload.
            Set to ENABLE to automatically initiate transcoding after upload,
            or DISABLE for manual initiation via the Transcode() method.
            - `AUTO_TRANSCODE_UNSPECIFIED`: The auto-transcoding setting is not specified.
            - `ENABLE`: Automatically start transcoding after the video upload is complete.
            - `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method.
          type: string
          enum:
            - AUTO_TRANSCODE_UNSPECIFIED
            - ENABLE
            - DISABLE
        stylePresetId:
          description: |-
            **string**
            ID of the style preset to apply to the video during processing.
            Style presets define visual appearance settings for the video player.
          type: string
        autoPublish:
          description: |-
            **boolean**
            Controls whether the video is automatically published after transcoding.
            When set to true, the video's visibility status will be set to PUBLISHED
            once transcoding is complete, making it available for watching.
          type: boolean
        enableAd:
          description: |-
            **boolean**
            Controls the ability to display advertisements for this video.
            Default: true
            Set explicitly to false to disable advertisements for this specific video.
          type: boolean
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom user-defined labels as `key:value` pairs.
            Maximum 64 labels per video.
            Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
            Values can contain alphanumeric characters and various symbols.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        tusd:
          description: |-
            **[VideoTUSDParams](/docs/video/api-ref/Video/create#yandex.cloud.video.v1.VideoTUSDParams)**
            Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
            This is a push-based upload method where the client pushes data to the server.
            Includes only one of the fields `tusd`.
            Specifies the video upload source method (exactly one must be chosen).
          $ref: '#/definitions/VideoTUSDParams'
        publicAccess:
          description: |-
            **object**
            Video is publicly available.
            Includes only one of the fields `publicAccess`, `signUrlAccess`.
            Video access permission settings (exactly one must be chosen).
          $ref: '#/definitions/VideoPublicAccessParams'
        signUrlAccess:
          description: |-
            **object**
            Access to the video is restricted by temporarily signed links.
            Includes only one of the fields `publicAccess`, `signUrlAccess`.
            Video access permission settings (exactly one must be chosen).
          $ref: '#/definitions/VideoSignURLAccessParams'
      required:
        - channelId
        - title
      additionalProperties: false
    definitions:
      VideoTUSDParams:
        type: object
        properties:
          fileSize:
            description: |-
              **string** (int64)
              Total size of the file to be uploaded, in bytes.
            type: string
            format: int64
          fileName:
            description: |-
              **string**
              Original name of the file being uploaded.
              This is used for reference and does not affect the upload process.
            type: string
      VideoPublicAccessParams:
        type: object
        properties: {}
      VideoSignURLAccessParams:
        type: object
        properties: {}
sourcePath: en/_api-ref/video/v1/api-ref/Video/create.md
---

# Video API, REST: Video.Create

Creates a new video in the specified channel.
The video can be created from different sources: TUS upload, direct link, or S3 storage.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos
```

## Body parameters {#yandex.cloud.video.v1.CreateVideoRequest}

```json
{
  "channelId": "string",
  "title": "string",
  "description": "string",
  "thumbnailId": "string",
  "autoTranscode": "string",
  "stylePresetId": "string",
  "autoPublish": "boolean",
  "enableAd": "boolean",
  "labels": "object",
  // Includes only one of the fields `tusd`
  "tusd": {
    "fileSize": "string",
    "fileName": "string"
  },
  // end of the list of possible fields
  // Includes only one of the fields `publicAccess`, `signUrlAccess`
  "publicAccess": "object",
  "signUrlAccess": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel where the video will be created. ||
|| title | **string**

Required field. Title of the video to be displayed in interfaces and players. ||
|| description | **string**

Detailed description of the video content and context.
Optional field that can provide additional information about the video. ||
|| thumbnailId | **string**

ID of the thumbnail image to be used for the video.
If not provided, a thumbnail may be automatically generated during transcoding. ||
|| autoTranscode | **enum** (AutoTranscode)

Controls whether transcoding starts automatically after upload.
Set to ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `AUTO_TRANSCODE_UNSPECIFIED`: The auto-transcoding setting is not specified.
- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| stylePresetId | **string**

ID of the style preset to apply to the video during processing.
Style presets define visual appearance settings for the video player. ||
|| autoPublish | **boolean**

Controls whether the video is automatically published after transcoding.
When set to true, the video's visibility status will be set to PUBLISHED
once transcoding is complete, making it available for watching. ||
|| enableAd | **boolean**

Controls the ability to display advertisements for this video.
Default: true
Set explicitly to false to disable advertisements for this specific video. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per video.
Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
Values can contain alphanumeric characters and various symbols. ||
|| tusd | **[VideoTUSDParams](#yandex.cloud.video.v1.VideoTUSDParams)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
This is a push-based upload method where the client pushes data to the server.

Includes only one of the fields `tusd`.

Specifies the video upload source method (exactly one must be chosen). ||
|| publicAccess | **object**

Video is publicly available.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings (exactly one must be chosen). ||
|| signUrlAccess | **object**

Access to the video is restricted by temporarily signed links.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings (exactly one must be chosen). ||
|#

## VideoTUSDParams {#yandex.cloud.video.v1.VideoTUSDParams}

#|
||Field | Description ||
|| fileSize | **string** (int64)

Total size of the file to be uploaded, in bytes. ||
|| fileName | **string**

Original name of the file being uploaded.
This is used for reference and does not affect the upload process. ||
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
    "stylePresetId": "string",
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
|| metadata | **[CreateVideoMetadata](#yandex.cloud.video.v1.CreateVideoMetadata)**

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

## CreateVideoMetadata {#yandex.cloud.video.v1.CreateVideoMetadata}

#|
||Field | Description ||
|| videoId | **string**

Unique identifier of the video. ||
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

Main entity representing a video in the platform.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the video. ||
|| channelId | **string**

Identifier of the channel where the video is created and managed. ||
|| title | **string**

Title of the video displayed to users in interfaces and players. ||
|| description | **string**

Detailed description of the video content and context. ||
|| thumbnailId | **string**

Identifier of the thumbnail image used to represent the video visually. ||
|| status | **enum** (VideoStatus)

Current processing status of the video.

- `VIDEO_STATUS_UNSPECIFIED`: The video status is not specified.
- `WAIT_UPLOADING`: The video upload is in progress, waiting for all bytes to be received.
- `UPLOADED`: The video has been fully uploaded and is ready for transcoding.
- `PROCESSING`: The video is currently being processed.
- `READY`: The video has been successfully processed and is ready for watching.
- `ERROR`: An error occurred during video processing. ||
|| errorMessage | **string**

Error message describing the reason for video processing failure, if any. ||
|| visibilityStatus | **enum** (VisibilityStatus)

Current visibility status controlling whether the video is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The video is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The video is available only to administrators. ||
|| duration | **string** (duration)

Total duration of the video.
Optional, may be empty until the transcoding result is ready. ||
|| autoTranscode | **enum** (AutoTranscode)

Auto-transcoding setting that controls the video processing workflow.
Set ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `AUTO_TRANSCODE_UNSPECIFIED`: The auto-transcoding setting is not specified.
- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| stylePresetId | **string**

Identifier of the style preset applied to the video during processing. ||
|| enableAd | **boolean**

Controls the ability to display advertisements for this video.
Default: true.
Set explicitly to false to disable advertisements for a specific video. ||
|| subtitleIds[] | **string**

List of identifiers defining the active subtitles available for the video. ||
|| features | **[VideoFeatures](#yandex.cloud.video.v1.VideoFeatures)**

Additional video processing features and their results, such as summarization. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
@see https://tus.io/

Includes only one of the fields `tusd`.

Specifies the video upload source method (one source variant must be chosen). ||
|| publicAccess | **object**

Allows unrestricted public access to the video via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the video access permission settings. ||
|| signUrlAccess | **object**

Restricts video access using URL signatures for secure time-limited access.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the video access permission settings. ||
|| createdAt | **string** (date-time)

Timestamp when the video was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the video or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| result | **enum** (FeatureResult)

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
|| trackIndex | **string** (int64)

Input audio track index (one-based) that was summarized. ||
|| srcLang | **string**

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
|| fileSize | **string** (int64)

Total size of the uploaded file, in bytes. ||
|#
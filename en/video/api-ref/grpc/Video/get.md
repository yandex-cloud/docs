---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/get.md
---

# Video API, gRPC: VideoService.Get

Get the specific video.

## gRPC request

**rpc Get ([GetVideoRequest](#yandex.cloud.video.v1.GetVideoRequest)) returns ([Video](#yandex.cloud.video.v1.Video))**

## GetVideoRequest {#yandex.cloud.video.v1.GetVideoRequest}

```json
{
  "video_id": "string"
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video. ||
|#

## Video {#yandex.cloud.video.v1.Video}

```json
{
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
```

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channel_id | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title displayed to users. ||
|| description | **string**

Detailed description of the video. ||
|| thumbnail_id | **string**

ID of the video's thumbnail image. ||
|| status | enum **VideoStatus**

Video status.

- `VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.
- `WAIT_UPLOADING`: Waiting for all the bytes to be loaded.
- `UPLOADED`: Fully uploaded, ready to be transcoded.
- `PROCESSING`: Video is being processed.
- `READY`: Successfully processed and ready for use.
- `ERROR`: Video processing has failed. ||
|| error_message | **string**

Error message describing the reason for video processing failure, if any. ||
|| visibility_status | enum **VisibilityStatus**

Visibility status of the video.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video published and available for public viewing.
- `UNPUBLISHED`: Video unpublished, available only to administrators. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Video duration. Optional, may be empty until the transcoding result is ready. ||
|| auto_transcode | enum **AutoTranscode**

Auto-transcoding setting.
Set ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `AUTO_TRANSCODE_UNSPECIFIED`: Unspecified auto transcoding value.
- `ENABLE`: Enable auto transcoding.
- `DISABLE`: Disable auto transcoding. ||
|| enable_ad | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable advertisement for this video.
Default: true.
Set explicitly to false to disable advertisements for a specific video. ||
|| subtitle_ids[] | **string**

List of IDs defining the active subtitles for the video. ||
|| features | **[VideoFeatures](#yandex.cloud.video.v1.VideoFeatures)**

Additional video processing features and their results. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Video upload source definition (one source variant must be chosen). ||
|| public_access | **[VideoPublicAccessRights](#yandex.cloud.video.v1.VideoPublicAccessRights)**

Publicly accessible video available for viewing by anyone with the direct link.
No additional authorization or access control is applied.

Includes only one of the fields `public_access`, `sign_url_access`.

Video access permission settings. ||
|| sign_url_access | **[VideoSignURLAccessRights](#yandex.cloud.video.v1.VideoSignURLAccessRights)**

Checking access rights using url's signature.

Includes only one of the fields `public_access`, `sign_url_access`.

Video access permission settings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when video was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last video update. ||
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
|| result | enum **FeatureResult**

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
|| track_index | **int64**

Input audio track index (one-based). ||
|| src_lang | **string**

Source track language (three-letter code according to ISO 639-2/T, ISO 639-2/B, or ISO 639-3).
Either provided in transcoding settings earlier or automatically deduced. ||
|#

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

Video upload source via tus protocol.

#|
||Field | Description ||
|| url | **string**

URL for uploading video via the tus protocol. ||
|| file_size | **int64**

Size of the uploaded file, in bytes. ||
|#

## VideoPublicAccessRights {#yandex.cloud.video.v1.VideoPublicAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessRights {#yandex.cloud.video.v1.VideoSignURLAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#
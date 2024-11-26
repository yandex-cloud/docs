---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/get.md
---

# Video API, gRPC: VideoService.Get

Returns the specific video.

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
  "duration": "google.protobuf.Duration",
  "visibility_status": "VisibilityStatus",
  "auto_transcode": "AutoTranscode",
  "subtitle_ids": [
    "string"
  ],
  // Includes only one of the fields `tusd`
  "tusd": {
    "url": "string"
  },
  // end of the list of possible fields
  // Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`
  "public_access": "VideoPublicAccessRights",
  "auth_system_access": "VideoAuthSystemAccessRights",
  "sign_url_access": "VideoSignURLAccessRights",
  // end of the list of possible fields
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "labels": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channel_id | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title. ||
|| description | **string**

Video description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| status | enum **VideoStatus**

Video status.

- `VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.
- `WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.
- `PROCESSING`: Video processing.
- `READY`: Video is ready, processing is completed.
- `ERROR`: An error occurred during video processing. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Video duration. Optional, may be empty until the transcoding result is ready. ||
|| visibility_status | enum **VisibilityStatus**

Video visibility status.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video is published and available for viewing.
- `UNPUBLISHED`: Video is unpublished, only admin can watch. ||
|| auto_transcode | enum **AutoTranscode**

Auto start transcoding.
If set to ENABLE, transcoding process is initiated automatically after video upload.
If set to DISABLE, manual "Transcode()" call is required instead.

- `AUTO_TRANSCODE_UNSPECIFIED`: Unspecified auto transcoding value.
- `ENABLE`: Enable auto transcoding.
- `DISABLE`: Disable auto transcoding. ||
|| subtitle_ids[] | **string**

IDs of active video subtitles. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Source type. ||
|| public_access | **[VideoPublicAccessRights](#yandex.cloud.video.v1.VideoPublicAccessRights)**

Video is available to everyone.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| auth_system_access | **[VideoAuthSystemAccessRights](#yandex.cloud.video.v1.VideoAuthSystemAccessRights)**

Checking access rights using the authorization system.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| sign_url_access | **[VideoSignURLAccessRights](#yandex.cloud.video.v1.VideoSignURLAccessRights)**

Checking access rights using url's signature.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when video was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last video update. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

#|
||Field | Description ||
|| url | **string**

URL for uploading video via the tus protocol. ||
|#

## VideoPublicAccessRights {#yandex.cloud.video.v1.VideoPublicAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoAuthSystemAccessRights {#yandex.cloud.video.v1.VideoAuthSystemAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessRights {#yandex.cloud.video.v1.VideoSignURLAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#
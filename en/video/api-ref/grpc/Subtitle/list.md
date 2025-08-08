---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/list.md
---

# Video API, gRPC: SubtitleService.List

Lists all subtitles associated with a specific video with pagination support.
Results can be filtered and sorted using the provided parameters.

## gRPC request

**rpc List ([ListSubtitlesRequest](#yandex.cloud.video.v1.ListSubtitlesRequest)) returns ([ListSubtitlesResponse](#yandex.cloud.video.v1.ListSubtitlesResponse))**

## ListSubtitlesRequest {#yandex.cloud.video.v1.ListSubtitlesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  // Includes only one of the fields `video_id`
  "video_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of subtitles to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListSubtitlesResponse. ||
|| video_id | **string**

ID of the video containing the subtitles to list.

Includes only one of the fields `video_id`.

Specifies the parent resource to list subtitles from (exactly one must be chosen). ||
|#

## ListSubtitlesResponse {#yandex.cloud.video.v1.ListSubtitlesResponse}

```json
{
  "subtitles": [
    {
      "id": "string",
      "language": "string",
      "label": "string",
      "status": "SubtitleStatus",
      "source_type": "SubtitleSourceType",
      "filename": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      // Includes only one of the fields `video_id`
      "video_id": "string"
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| subtitles[] | **[Subtitle](#yandex.cloud.video.v1.Subtitle)**

List of subtitles matching the request criteria.
May be empty if no subtitles match the criteria or if the video has no subtitles. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Subtitle {#yandex.cloud.video.v1.Subtitle}

Entity representing a subtitle track that can be associated with a video.
Subtitles provide text versions of the audio content, enabling accessibility
and multilingual support for video content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the subtitle track. ||
|| language | **string**

Language of the subtitle content according to ISO 639-2/T. ||
|| label | **string**

Display label for the subtitle track shown in the video player's subtitle selection menu. ||
|| status | enum **SubtitleStatus**

Current processing status of the subtitle.

- `SUBTITLE_STATUS_UNSPECIFIED`: The subtitle status is not specified.
- `WAIT_UPLOADING`: The subtitle file upload is in progress, waiting for all bytes to be received.
- `UPLOADED`: The subtitle file has been fully uploaded and is ready for use. ||
|| source_type | enum **SubtitleSourceType**

Indicates how the subtitle was created or obtained.

- `SUBTITLE_SOURCE_TYPE_UNSPECIFIED`: The subtitle source type is not specified.
- `MANUAL`: The subtitle was manually created and uploaded by a user.
- `GENERATED`: The subtitle was automatically generated through speech recognition. ||
|| filename | **string**

Original filename of the subtitle file. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the subtitle was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the subtitle or its metadata. ||
|| video_id | **string**

Identifier of the video this subtitle belongs to.

Includes only one of the fields `video_id`.

Specifies the parent content this subtitle is associated with. ||
|#
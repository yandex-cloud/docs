---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the videos to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of videos to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListVideoResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "createdAt desc").
            Default: "id asc".
            Supported fields: ["id", "title", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned videos.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'sample' AND (status='READY' OR visibilityStatus='PUBLISHED')`
            Filterable fields: ["id", "title", "status", "visibilityStatus"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - channelId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Video/list.md
---

# Video API, REST: Video.List

Lists all videos in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos
```

## Query parameters {#yandex.cloud.video.v1.ListVideoRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the videos to list. ||
|| pageSize | **string** (int64)

The maximum number of videos to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListVideoResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned videos.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'sample' AND (status='READY' OR visibilityStatus='PUBLISHED')`

Filterable fields: ["id", "title", "status", "visibilityStatus"].
Both snake_case and camelCase field names are supported. ||
|#

## Response {#yandex.cloud.video.v1.ListVideoResponse}

**HTTP Code: 200 - OK**

```json
{
  "videos": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| videos[] | **[Video](#yandex.cloud.video.v1.Video)**

List of videos matching the request criteria.
May be empty if no videos match the criteria or if the channel is empty. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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
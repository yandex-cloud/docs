---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/batchGet.md
---

# Video API, REST: Video.BatchGet

Batch get video in specific channel.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos:batchGet
```

## Body parameters {#yandex.cloud.video.v1.BatchGetVideosRequest}

```json
{
  "channelId": "string",
  "videoIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| videoIds[] | **string**

List of requested video IDs. ||
|#

## Response {#yandex.cloud.video.v1.BatchGetVideosResponse}

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
      "duration": "string",
      "visibilityStatus": "string",
      "autoTranscode": "string",
      "subtitleIds": [
        "string"
      ],
      // Includes only one of the fields `tusd`
      "tusd": {
        "url": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `publicAccess`, `authSystemAccess`, `signUrlAccess`
      "publicAccess": "object",
      "authSystemAccess": "object",
      "signUrlAccess": "object",
      // end of the list of possible fields
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object"
    }
  ]
}
```

#|
||Field | Description ||
|| videos[] | **[Video](#yandex.cloud.video.v1.Video)**

List of videos for channel. ||
|#

## Video {#yandex.cloud.video.v1.Video}

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channelId | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title. ||
|| description | **string**

Video description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| status | **enum** (VideoStatus)

Video status.

- `VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.
- `WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.
- `PROCESSING`: Video processing.
- `READY`: Video is ready, processing is completed.
- `ERROR`: An error occurred during video processing. ||
|| duration | **string** (duration)

Video duration. Optional, may be empty until the transcoding result is ready. ||
|| visibilityStatus | **enum** (VisibilityStatus)

Video visibility status.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video is published and available for viewing.
- `UNPUBLISHED`: Video is unpublished, only admin can watch. ||
|| autoTranscode | **enum** (AutoTranscode)

Auto start transcoding.
If set to ENABLE, transcoding process is initiated automatically after video upload.
If set to DISABLE, manual "Transcode()" call is required instead.

- `AUTO_TRANSCODE_UNSPECIFIED`: Unspecified auto transcoding value.
- `ENABLE`: Enable auto transcoding.
- `DISABLE`: Disable auto transcoding. ||
|| subtitleIds[] | **string**

IDs of active video subtitles. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Source type. ||
|| publicAccess | **object**

Video is available to everyone.

Includes only one of the fields `publicAccess`, `authSystemAccess`, `signUrlAccess`.

Video access rights. ||
|| authSystemAccess | **object**

Checking access rights using the authorization system.

Includes only one of the fields `publicAccess`, `authSystemAccess`, `signUrlAccess`.

Video access rights. ||
|| signUrlAccess | **object**

Checking access rights using url's signature.

Includes only one of the fields `publicAccess`, `authSystemAccess`, `signUrlAccess`.

Video access rights. ||
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

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

#|
||Field | Description ||
|| url | **string**

URL for uploading video via the tus protocol. ||
|#
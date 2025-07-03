---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/get.md
---

# Video API, REST: Video.Get

Get the specific video.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video. ||
|#

## Response {#yandex.cloud.video.v1.Video}

**HTTP Code: 200 - OK**

```json
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
```

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
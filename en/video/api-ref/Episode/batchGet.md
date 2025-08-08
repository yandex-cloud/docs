---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/episodes:batchGet
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the episodes to retrieve.
          type: string
        episodeIds:
          description: |-
            **string**
            List of episode IDs to retrieve.
          type: array
          items:
            type: string
      required:
        - channelId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Episode/batchGet.md
---

# Video API, REST: Episode.BatchGet

Retrieves multiple episodes by their IDs in a specific channel in a single request.
This is more efficient than making multiple Get requests when retrieving several episodes.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/episodes:batchGet
```

## Body parameters {#yandex.cloud.video.v1.BatchGetEpisodesRequest}

```json
{
  "channelId": "string",
  "episodeIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the episodes to retrieve. ||
|| episodeIds[] | **string**

List of episode IDs to retrieve. ||
|#

## Response {#yandex.cloud.video.v1.BatchGetEpisodesResponse}

**HTTP Code: 200 - OK**

```json
{
  "episodes": [
    {
      "id": "string",
      "streamId": "string",
      "lineId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "startTime": "string",
      "finishTime": "string",
      "dvrSeconds": "string",
      "visibilityStatus": "string",
      "stylePresetId": "string",
      // Includes only one of the fields `publicAccess`, `signUrlAccess`
      "publicAccess": "object",
      "signUrlAccess": "object",
      // end of the list of possible fields
      "createdAt": "string",
      "updatedAt": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| episodes[] | **[Episode](#yandex.cloud.video.v1.Episode)**

List of episodes matching the requested IDs. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

Entity representing a stream fragment that can be accessed independently.
Episodes can be linked to either a stream or a line
and provide a way to reference specific portions of the corresponding content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the episode. ||
|| streamId | **string**

Identifier of the stream this episode is linked to.
Optional, empty if the episode is linked to a line. ||
|| lineId | **string**

Identifier of the line this episode is linked to.
Optional, empty if the episode is linked to a stream. ||
|| title | **string**

Title of the episode displayed in interfaces and players. ||
|| description | **string**

Detailed description of the episode content and context. ||
|| thumbnailId | **string**

Identifier of the thumbnail image used to represent the episode visually. ||
|| startTime | **string** (date-time)

Timestamp marking the beginning of the episode content.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Timestamp marking the end of the episode content.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| dvrSeconds | **string** (int64)

Controls the Digital Video Recording (DVR) functionality for the episode.
Determines how many seconds of the stream are available for time-shifted viewing.

Possible values:
* `0`: Infinite DVR size, the full length of the stream is available for viewing.
* `>0`: Size of DVR window in seconds, the minimum value is 30s. ||
|| visibilityStatus | **enum** (VisibilityStatus)

Current visibility status controlling whether the episode is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The episode is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The episode is available only to administrators. ||
|| stylePresetId | **string**

Identifier of the style preset used in the player during episode playback. ||
|| publicAccess | **object**

Allows unrestricted public access to the episode via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the episode access permission settings. ||
|| signUrlAccess | **object**

Restricts episode access using URL signatures for secure time-limited access.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the episode access permission settings. ||
|| createdAt | **string** (date-time)

Timestamp when the episode was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the episode or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
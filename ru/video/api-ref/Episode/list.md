---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/episodes
    method: get
    path: null
    query:
      type: object
      properties:
        streamId:
          description: |-
            **string**
            ID of the stream containing the episodes to list.
            Includes only one of the fields `streamId`, `lineId`.
            Specifies the parent resource to list episodes from (exactly one must be chosen).
          type: string
        lineId:
          description: |-
            **string**
            ID of the stream line containing the episodes to list.
            Includes only one of the fields `streamId`, `lineId`.
            Specifies the parent resource to list episodes from (exactly one must be chosen).
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of episodes to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListEpisodesResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "createdAt desc").
            Default: "id asc".
            Supported fields: ["id", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned episodes.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'highlight' AND id='episode-1'`
            Filterable fields: ["id", "title"].
            Both snake_case and camelCase field names are supported.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Episode/list.md
---

# Video API, REST: Episode.List

Lists all episodes associated with a specific stream or stream line with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes
```

## Query parameters {#yandex.cloud.video.v1.ListEpisodesRequest}

#|
||Field | Description ||
|| streamId | **string**

ID of the stream containing the episodes to list.

Includes only one of the fields `streamId`, `lineId`.

Specifies the parent resource to list episodes from (exactly one must be chosen). ||
|| lineId | **string**

ID of the stream line containing the episodes to list.

Includes only one of the fields `streamId`, `lineId`.

Specifies the parent resource to list episodes from (exactly one must be chosen). ||
|| pageSize | **string** (int64)

The maximum number of episodes to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListEpisodesResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned episodes.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'highlight' AND id='episode-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
|#

## Response {#yandex.cloud.video.v1.ListEpisodesResponse}

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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| episodes[] | **[Episode](#yandex.cloud.video.v1.Episode)**

List of episodes matching the request criteria.
May be empty if no episodes match the criteria or if the parent resource has no episodes. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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
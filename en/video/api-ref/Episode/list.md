---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/list.md
---

# Video API, REST: Episode.List {#List}

List episodes for stream or line.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes
```

## Query parameters {#yandex.cloud.video.v1.ListEpisodesRequest}

#|
||Field | Description ||
|| streamId | **string**

ID of the stream.

Includes only one of the fields `streamId`, `lineId`. ||
|| lineId | **string**

ID of the line.

Includes only one of the fields `streamId`, `lineId`. ||
|| pageSize | **string** (int64)

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Possible fields: ["id", "createdAt", "updatedAt"]
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
Value in quotes: `'` or `"`
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["title"]
Both snake_case and camelCase are supported for fields. ||
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
      // Includes only one of the fields `publicAccess`, `authSystemAccess`
      "publicAccess": "object",
      "authSystemAccess": "object",
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

List of episodes for specific parent_id. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

#|
||Field | Description ||
|| id | **string**

ID of the episode. ||
|| streamId | **string**

ID of the stream. Optional, empty if the episode is linked to the line ||
|| lineId | **string**

ID of the line. Optional, empty if the episode is linked to the stream ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| startTime | **string** (date-time)

Episode start time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Episode finish time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| dvrSeconds | **string** (int64)

Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available.

possible values:
* `0`: infinite dvr size, the full length of the stream allowed to display
* `>0`: size of dvr window in seconds, the minimum value is 30s ||
|| visibilityStatus | **enum** (VisibilityStatus)

- `VISIBILITY_STATUS_UNSPECIFIED`
- `PUBLISHED`
- `UNPUBLISHED` ||
|| publicAccess | **object**

Episode is available to everyone.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Episode access rights. ||
|| authSystemAccess | **object**

Checking access rights using the authorization system.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Episode access rights. ||
|| createdAt | **string** (date-time)

Time when episode was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last episode update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
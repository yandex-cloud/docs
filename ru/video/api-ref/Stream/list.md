---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streams
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the streams to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of streams to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListStreamsResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "startTime desc").
            Default: "id asc".
            Supported fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned streams.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'live' AND (status='READY' OR status='ONAIR')`
            Filterable fields: ["id", "title", "lineId", "status"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - channelId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Stream/list.md
---

# Video API, REST: Stream.List

Lists all streams in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/streams
```

## Query parameters {#yandex.cloud.video.v1.ListStreamsRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the streams to list. ||
|| pageSize | **string** (int64)

The maximum number of streams to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStreamsResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "startTime desc").
Default: "id asc".
Supported fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned streams.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'live' AND (status='READY' OR status='ONAIR')`

Filterable fields: ["id", "title", "lineId", "status"].
Both snake_case and camelCase field names are supported. ||
|#

## Response {#yandex.cloud.video.v1.ListStreamsResponse}

**HTTP Code: 200 - OK**

```json
{
  "streams": [
    {
      "id": "string",
      "channelId": "string",
      "lineId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "status": "string",
      "startTime": "string",
      "publishTime": "string",
      "finishTime": "string",
      "autoPublish": "boolean",
      // Includes only one of the fields `onDemand`, `schedule`
      "onDemand": "object",
      "schedule": {
        "startTime": "string",
        "finishTime": "string"
      },
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
|| streams[] | **[Stream](#yandex.cloud.video.v1.Stream)**

List of streams matching the request criteria.
May be empty if no streams match the criteria or if the channel has no streams. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

Entity representing a live video stream.
A stream is a real-time video broadcast linked to a specific stream line.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the stream. ||
|| channelId | **string**

Identifier of the channel where the stream is created and managed. ||
|| lineId | **string**

Identifier of the stream line to which this stream is linked. ||
|| title | **string**

Title of the stream displayed in interfaces and players. ||
|| description | **string**

Detailed description of the stream content and context. ||
|| thumbnailId | **string**

Identifier of the thumbnail image used to represent the stream visually. ||
|| status | **enum** (StreamStatus)

Current status of the stream.

- `STREAM_STATUS_UNSPECIFIED`: The stream status is not specified.
- `OFFLINE`: The stream is offline and not broadcasting.
- `PREPARING`: The system is preparing the infrastructure for receiving the video signal.
- `READY`: The infrastructure is ready to launch the stream.
- `ONAIR`: The stream is currently broadcasting live.
- `FINISHED`: The stream has completed and is no longer broadcasting. ||
|| startTime | **string** (date-time)

Timestamp when the stream was initiated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| publishTime | **string** (date-time)

Timestamp when the stream was published (switched to ONAIR status).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Timestamp when the stream was completed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| autoPublish | **boolean**

Controls automatic publishing of the stream when it's ready.
When set to true, automatically switches status from READY to ONAIR. ||
|| onDemand | **object**

On-demand stream starts immediately when a video signal appears.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Scheduled stream starts and finishes at specified time.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type. ||
|| createdAt | **string** (date-time)

Timestamp when the stream was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the stream or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream.
Used for organization, filtering, and metadata purposes.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Represents a scheduled stream type.
This type of stream starts and finishes automatically at specified time.

#|
||Field | Description ||
|| startTime | **string** (date-time)

Scheduled time when the stream should automatically start.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Scheduled time when the stream should automatically finish.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streamLines
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the stream lines to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of stream lines to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListStreamLinesResponse.
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
            Filter expression to narrow down the list of returned stream lines.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'main' AND id='line-1'`
            Filterable fields: ["id", "title"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - channelId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/list.md
---

# Video API, REST: StreamLine.List

Lists all stream lines in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/streamLines
```

## Query parameters {#yandex.cloud.video.v1.ListStreamLinesRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the stream lines to list. ||
|| pageSize | **string** (int64)

The maximum number of stream lines to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStreamLinesResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned stream lines.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'main' AND id='line-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
|#

## Response {#yandex.cloud.video.v1.ListStreamLinesResponse}

**HTTP Code: 200 - OK**

```json
{
  "streamLines": [
    {
      "id": "string",
      "channelId": "string",
      "title": "string",
      // Includes only one of the fields `rtmpPush`, `rtmpPull`
      "rtmpPush": {
        "url": "string"
      },
      "rtmpPull": {
        "url": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `manualLine`, `autoLine`
      "manualLine": "object",
      "autoLine": {
        "status": "string"
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
|| streamLines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of stream lines matching the request criteria.
May be empty if no stream lines match the criteria or if the channel has no stream lines. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity representing the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channelId | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| rtmpPush | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| rtmpPull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| manualLine | **object**

Manual stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| createdAt | **string** (date-time)

Timestamp when the stream line was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the stream line or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream line.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## RTMPPushInput {#yandex.cloud.video.v1.RTMPPushInput}

Settings for an RTMP (Real-Time Messaging Protocol) push input.
Used when the video stream is pushed to an RTMP server.
@see https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol

#|
||Field | Description ||
|| url | **string**

RTMP server url. ||
|#

## RTMPPullInput {#yandex.cloud.video.v1.RTMPPullInput}

Settings for an RTMP pull input.
Used when the service pulls the video stream from an RTMP source.
@see https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol

#|
||Field | Description ||
|| url | **string**

RTMP url for receiving video signal. ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Represents an automatic line type where the stream control is handled automatically.

#|
||Field | Description ||
|| status | **enum** (AutoLineStatus)

The status of the automatic line.

- `AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.
- `DEACTIVATED`: The automatic line is deactivated and not currently active.
- `ACTIVE`: The automatic line is active and operational. ||
|#
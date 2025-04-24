---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/get.md
---

# Video API, REST: StreamLine.Get

Get the specific stream line.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}
```

## Path parameters

#|
||Field | Description ||
|| streamLineId | **string**

Required field. ID of the line. ||
|#

## Response {#yandex.cloud.video.v1.StreamLine}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "channelId": "string",
  "title": "string",
  "thumbnailId": "string",
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
```

Entity that is responsible for the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channelId | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| thumbnailId | **string**

ID of the thumbnail image associated with the stream line.. ||
|| rtmpPush | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input settings.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| rtmpPull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| manualLine | **object**

Manual control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| createdAt | **string** (date-time)

Time when the stream line was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time when the stream line was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
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
---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/batchGet.md
---

# Video API, REST: StreamLine.BatchGet

Batch get lines for channel.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/streamLines:batchGet
```

## Body parameters {#yandex.cloud.video.v1.BatchGetStreamLinesRequest}

```json
{
  "channelId": "string",
  "streamLineIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| streamLineIds[] | **string**

List of requested stream line IDs. ||
|#

## Response {#yandex.cloud.video.v1.BatchGetStreamLinesResponse}

**HTTP Code: 200 - OK**

```json
{
  "streamLines": [
    {
      "id": "string",
      "channelId": "string",
      "title": "string",
      "thumbnailId": "string",
      // Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`
      "rtmpPush": {
        "url": "string"
      },
      "srtPush": {
        "url": "string"
      },
      "rtmpPull": {
        "url": "string"
      },
      "srtPull": {
        "url": "string"
      },
      "tcpPull": {
        "url": "string"
      },
      "rtspPull": {
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
      "labels": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| streamLines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of lines for specific channel. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity that is responsible for the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channelId | **string**

ID of the channel where the line was created. ||
|| title | **string**

Line title. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| rtmpPush | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

RTMP push input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| srtPush | **[SRTPushInput](#yandex.cloud.video.v1.SRTPushInput)**

SRT push input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| rtmpPull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

RTMP pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| srtPull | **[SRTPullInput](#yandex.cloud.video.v1.SRTPullInput)**

SRT pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| tcpPull | **[TCPPullInput](#yandex.cloud.video.v1.TCPPullInput)**

TCP pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| rtspPull | **[RTSPPullInput](#yandex.cloud.video.v1.RTSPPullInput)**

RTSP pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`.

Video signal settings. ||
|| manualLine | **object**

Manual control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| createdAt | **string** (date-time)

Time when line was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last line update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## RTMPPushInput {#yandex.cloud.video.v1.RTMPPushInput}

#|
||Field | Description ||
|| url | **string**

RTMP server url. ||
|#

## SRTPushInput {#yandex.cloud.video.v1.SRTPushInput}

#|
||Field | Description ||
|| url | **string**

SRT server url. ||
|#

## RTMPPullInput {#yandex.cloud.video.v1.RTMPPullInput}

#|
||Field | Description ||
|| url | **string**

RTMP url for receiving video signal. ||
|#

## SRTPullInput {#yandex.cloud.video.v1.SRTPullInput}

#|
||Field | Description ||
|| url | **string**

SRT url for receiving video signal. ||
|#

## TCPPullInput {#yandex.cloud.video.v1.TCPPullInput}

#|
||Field | Description ||
|| url | **string**

TCP url for receiving video signal. ||
|#

## RTSPPullInput {#yandex.cloud.video.v1.RTSPPullInput}

#|
||Field | Description ||
|| url | **string**

RTSP url for receiving video signal. ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Auto line type.

#|
||Field | Description ||
|| status | **enum** (AutoLineStatus)

Status of auto line.

- `AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.
- `DEACTIVATED`: Auto line deactivated.
- `ACTIVE`: Auto line active. ||
|#
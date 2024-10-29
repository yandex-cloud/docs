---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/get.md
---

# Video API, gRPC: StreamLineService.Get {#Get}

Returns the specific stream line.

## gRPC request

**rpc Get ([GetStreamLineRequest](#yandex.cloud.video.v1.GetStreamLineRequest)) returns ([StreamLine](#yandex.cloud.video.v1.StreamLine))**

## GetStreamLineRequest {#yandex.cloud.video.v1.GetStreamLineRequest}

```json
{
  "streamLineId": "string"
}
```

#|
||Field | Description ||
|| streamLineId | **string**

ID of the line. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

```json
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
  "manualLine": "ManualLine",
  "autoLine": {
    "status": "AutoLineStatus"
  },
  // end of the list of possible fields
  "createdAt": "google.protobuf.Timestamp",
  "updatedAt": "google.protobuf.Timestamp",
  "labels": "string"
}
```

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
|| manualLine | **[ManualLine](#yandex.cloud.video.v1.ManualLine)**

Manual control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic control of stream.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when line was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last line update. ||
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

## ManualLine {#yandex.cloud.video.v1.ManualLine}

Manual line type.

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Auto line type.

#|
||Field | Description ||
|| status | enum **AutoLineStatus**

Status of auto line.

- `AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.
- `DEACTIVATED`: Auto line deactivated.
- `ACTIVE`: Auto line active. ||
|#
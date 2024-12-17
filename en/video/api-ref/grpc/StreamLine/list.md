---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/list.md
---

# Video API, gRPC: StreamLineService.List

List lines for channel.

## gRPC request

**rpc List ([ListStreamLinesRequest](#yandex.cloud.video.v1.ListStreamLinesRequest)) returns ([ListStreamLinesResponse](#yandex.cloud.video.v1.ListStreamLinesResponse))**

## ListStreamLinesRequest {#yandex.cloud.video.v1.ListStreamLinesRequest}

```json
{
  "channel_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| page_size | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Possible fields: ["id", "title", "createdAt", "updatedAt"]
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

## ListStreamLinesResponse {#yandex.cloud.video.v1.ListStreamLinesResponse}

```json
{
  "stream_lines": [
    {
      "id": "string",
      "channel_id": "string",
      "title": "string",
      "thumbnail_id": "string",
      // Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`
      "rtmp_push": {
        "url": "string"
      },
      "srt_push": {
        "url": "string"
      },
      "rtmp_pull": {
        "url": "string"
      },
      "srt_pull": {
        "url": "string"
      },
      "tcp_pull": {
        "url": "string"
      },
      "rtsp_pull": {
        "url": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `manual_line`, `auto_line`
      "manual_line": "ManualLine",
      "auto_line": {
        "status": "AutoLineStatus"
      },
      // end of the list of possible fields
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| stream_lines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of lines for channel. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity that is responsible for the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channel_id | **string**

ID of the channel where the line was created. ||
|| title | **string**

Line title. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| rtmp_push | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

RTMP push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| srt_push | **[SRTPushInput](#yandex.cloud.video.v1.SRTPushInput)**

SRT push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| rtmp_pull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

RTMP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| srt_pull | **[SRTPullInput](#yandex.cloud.video.v1.SRTPullInput)**

SRT pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| tcp_pull | **[TCPPullInput](#yandex.cloud.video.v1.TCPPullInput)**

TCP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| rtsp_pull | **[RTSPPullInput](#yandex.cloud.video.v1.RTSPPullInput)**

RTSP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| manual_line | **[ManualLine](#yandex.cloud.video.v1.ManualLine)**

Manual control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Line type. ||
|| auto_line | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Line type. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when line was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last line update. ||
|| labels | **object** (map<**string**, **string**>)

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
---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/create.md
---

# Video API, gRPC: StreamLineService.Create

Create stream line.

## gRPC request

**rpc Create ([CreateStreamLineRequest](#yandex.cloud.video.v1.CreateStreamLineRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateStreamLineRequest {#yandex.cloud.video.v1.CreateStreamLineRequest}

```json
{
  "channel_id": "string",
  "title": "string",
  "thumbnail_id": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`
  "rtmp_push": "RTMPPushParams",
  "srt_push": "SRTPushParams",
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
  "manual_line": "ManualLineParams",
  "auto_line": "AutoLineParams"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| title | **string**

Required field. Line title. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|| rtmp_push | **[RTMPPushParams](#yandex.cloud.video.v1.RTMPPushParams)**

RTMP push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| srt_push | **[SRTPushParams](#yandex.cloud.video.v1.SRTPushParams)**

SRT push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| rtmp_pull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| srt_pull | **[SRTPullParams](#yandex.cloud.video.v1.SRTPullParams)**

SRT pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| tcp_pull | **[TCPPullParams](#yandex.cloud.video.v1.TCPPullParams)**

TCP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| rtsp_pull | **[RTSPPullParams](#yandex.cloud.video.v1.RTSPPullParams)**

RTSP pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull`, `rtsp_pull`.

Video signal settings. ||
|| manual_line | **[ManualLineParams](#yandex.cloud.video.v1.ManualLineParams)**

Manual control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Line type. ||
|| auto_line | **[AutoLineParams](#yandex.cloud.video.v1.AutoLineParams)**

Automatic control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Line type. ||
|#

## RTMPPushParams {#yandex.cloud.video.v1.RTMPPushParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## SRTPushParams {#yandex.cloud.video.v1.SRTPushParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## RTMPPullParams {#yandex.cloud.video.v1.RTMPPullParams}

#|
||Field | Description ||
|| url | **string**

Required field. URL of a RTMP streaming server. ||
|#

## SRTPullParams {#yandex.cloud.video.v1.SRTPullParams}

#|
||Field | Description ||
|| url | **string**

Required field. URL of a SRT streaming server. ||
|#

## TCPPullParams {#yandex.cloud.video.v1.TCPPullParams}

#|
||Field | Description ||
|| url | **string**

Required field. URL of a TCP streaming server. ||
|#

## RTSPPullParams {#yandex.cloud.video.v1.RTSPPullParams}

#|
||Field | Description ||
|| url | **string**

Required field. URL of a RTSP streaming server. ||
|#

## ManualLineParams {#yandex.cloud.video.v1.ManualLineParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoLineParams {#yandex.cloud.video.v1.AutoLineParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "stream_line_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateStreamLineMetadata](#yandex.cloud.video.v1.CreateStreamLineMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateStreamLineMetadata {#yandex.cloud.video.v1.CreateStreamLineMetadata}

#|
||Field | Description ||
|| stream_line_id | **string**

ID of the line. ||
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
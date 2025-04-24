---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/batchGet.md
---

# Video API, gRPC: StreamLineService.BatchGet

Batch get lines for channel.

## gRPC request

**rpc BatchGet ([BatchGetStreamLinesRequest](#yandex.cloud.video.v1.BatchGetStreamLinesRequest)) returns ([BatchGetStreamLinesResponse](#yandex.cloud.video.v1.BatchGetStreamLinesResponse))**

## BatchGetStreamLinesRequest {#yandex.cloud.video.v1.BatchGetStreamLinesRequest}

```json
{
  "channel_id": "string",
  "stream_line_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| stream_line_ids[] | **string**

List of requested stream line IDs. ||
|#

## BatchGetStreamLinesResponse {#yandex.cloud.video.v1.BatchGetStreamLinesResponse}

```json
{
  "stream_lines": [
    {
      "id": "string",
      "channel_id": "string",
      "title": "string",
      "thumbnail_id": "string",
      // Includes only one of the fields `rtmp_push`, `rtmp_pull`
      "rtmp_push": {
        "url": "string"
      },
      "rtmp_pull": {
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
  ]
}
```

#|
||Field | Description ||
|| stream_lines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of lines for specific channel. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity that is responsible for the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channel_id | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| thumbnail_id | **string**

ID of the thumbnail image associated with the stream line.. ||
|| rtmp_push | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input settings.

Includes only one of the fields `rtmp_push`, `rtmp_pull`.

Specifies the input type and settings for the video signal source. ||
|| rtmp_pull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`.

Specifies the input type and settings for the video signal source. ||
|| manual_line | **[ManualLine](#yandex.cloud.video.v1.ManualLine)**

Manual control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Specifies the control type of the stream line. ||
|| auto_line | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic control of stream.

Includes only one of the fields `manual_line`, `auto_line`.

Specifies the control type of the stream line. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the stream line was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the stream line was last updated. ||
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

## ManualLine {#yandex.cloud.video.v1.ManualLine}

Represents a manual line type where the stream control is handled manually.
This means that stream start/stop actions are performed by the user.

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Represents an automatic line type where the stream control is handled automatically.

#|
||Field | Description ||
|| status | enum **AutoLineStatus**

The status of the automatic line.

- `AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.
- `DEACTIVATED`: The automatic line is deactivated and not currently active.
- `ACTIVE`: The automatic line is active and operational. ||
|#
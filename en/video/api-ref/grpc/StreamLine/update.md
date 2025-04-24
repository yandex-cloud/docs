---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/update.md
---

# Video API, gRPC: StreamLineService.Update

Update stream line.

## gRPC request

**rpc Update ([UpdateStreamLineRequest](#yandex.cloud.video.v1.UpdateStreamLineRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStreamLineRequest {#yandex.cloud.video.v1.UpdateStreamLineRequest}

```json
{
  "stream_line_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "thumbnail_id": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `rtmp_push`, `rtmp_pull`
  "rtmp_push": "RTMPPushParams",
  "rtmp_pull": {
    "url": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| stream_line_id | **string**

Required field. ID of the line. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which fields of the line are going to be updated. ||
|| title | **string**

Line title. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|| rtmp_push | **[RTMPPushParams](#yandex.cloud.video.v1.RTMPPushParams)**

RTMP push input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`.

Video signal settings. ||
|| rtmp_pull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`.

Video signal settings. ||
|#

## RTMPPushParams {#yandex.cloud.video.v1.RTMPPushParams}

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
|| metadata | **[UpdateStreamLineMetadata](#yandex.cloud.video.v1.UpdateStreamLineMetadata)**

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

## UpdateStreamLineMetadata {#yandex.cloud.video.v1.UpdateStreamLineMetadata}

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
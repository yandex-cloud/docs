# Video API, gRPC: StreamLineService.Create

Creates a new stream line in the specified channel with the provided configuration.
Stream lines define the technical settings for receiving and processing video signals.

## gRPC request

**rpc Create ([CreateStreamLineRequest](#yandex.cloud.video.v1.CreateStreamLineRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateStreamLineRequest {#yandex.cloud.video.v1.CreateStreamLineRequest}

```json
{
  "channel_id": "string",
  "title": "string",
  // Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`
  "rtmp_push": "RTMPPushParams",
  "rtmp_pull": {
    "url": "string"
  },
  "srt_pull": {
    "url": "string"
  },
  // end of the list of possible fields
  // Includes only one of the fields `manual_line`, `auto_line`
  "manual_line": "ManualLineParams",
  "auto_line": "AutoLineParams",
  // end of the list of possible fields
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel.

The maximum string length in characters is 50. ||
|| title | **string**

Required field. Line title.

The maximum string length in characters is 300. ||
|| rtmp_push | **[RTMPPushParams](#yandex.cloud.video.v1.RTMPPushParams)**

RTMP push input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| rtmp_pull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| srt_pull | **[SRTPullParams](#yandex.cloud.video.v1.SRTPullParams)**

SRT pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| manual_line | **[ManualLineParams](#yandex.cloud.video.v1.ManualLineParams)**

Manual stream control.

Includes only one of the fields `manual_line`, `auto_line`.

Line type.
The line type selection is permanent and cannot be switched between `manual_line`
and `auto_line` after creation. However, the parameters inside
the existing type structure can be modified. ||
|| auto_line | **[AutoLineParams](#yandex.cloud.video.v1.AutoLineParams)**

Automatic stream control.

Includes only one of the fields `manual_line`, `auto_line`.

Line type.
The line type selection is permanent and cannot be switched between `manual_line`
and `auto_line` after creation. However, the parameters inside
the existing type structure can be modified. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as key:value pairs.
Maximum 64 labels per stream line.
Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
Values can contain alphanumeric characters and various symbols.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
|#

## RTMPPushParams {#yandex.cloud.video.v1.RTMPPushParams}

Parameters for creating an RTMP push input type stream line.

#|
||Field | Description ||
|| Empty | > ||
|#

## RTMPPullParams {#yandex.cloud.video.v1.RTMPPullParams}

Parameters for creating an RTMP pull input type stream line.

#|
||Field | Description ||
|| url | **string**

Required field. The RTMP URL from which to pull the video stream.
Must be a valid RTMP URL starting with "rtmp://".

Value must match the regular expression ` rtmp://.* `. ||
|#

## SRTPullParams {#yandex.cloud.video.v1.SRTPullParams}

Parameters for creating an SRT pull input type stream line.

#|
||Field | Description ||
|| url | **string**

Required field. The SRT URL from which to pull the video stream.
Must be a valid SRT URL starting with "srt://".

Value must match the regular expression ` srt://.* `. ||
|#

## ManualLineParams {#yandex.cloud.video.v1.ManualLineParams}

Parameters for manual stream line.

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoLineParams {#yandex.cloud.video.v1.AutoLineParams}

Parameters for auto stream line.

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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
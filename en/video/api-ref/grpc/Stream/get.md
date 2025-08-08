---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/get.md
---

# Video API, gRPC: StreamService.Get

Retrieves detailed information about a specific stream by its ID.
Returns all stream metadata, status, and related information.

## gRPC request

**rpc Get ([GetStreamRequest](#yandex.cloud.video.v1.GetStreamRequest)) returns ([Stream](#yandex.cloud.video.v1.Stream))**

## GetStreamRequest {#yandex.cloud.video.v1.GetStreamRequest}

```json
{
  "stream_id": "string"
}
```

#|
||Field | Description ||
|| stream_id | **string**

Required field. ID of the stream to retrieve. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

```json
{
  "id": "string",
  "channel_id": "string",
  "line_id": "string",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "status": "StreamStatus",
  "start_time": "google.protobuf.Timestamp",
  "publish_time": "google.protobuf.Timestamp",
  "finish_time": "google.protobuf.Timestamp",
  "auto_publish": "google.protobuf.BoolValue",
  // Includes only one of the fields `on_demand`, `schedule`
  "on_demand": "OnDemand",
  "schedule": {
    "start_time": "google.protobuf.Timestamp",
    "finish_time": "google.protobuf.Timestamp"
  },
  // end of the list of possible fields
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

Entity representing a live video stream.
A stream is a real-time video broadcast linked to a specific stream line.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the stream. ||
|| channel_id | **string**

Identifier of the channel where the stream is created and managed. ||
|| line_id | **string**

Identifier of the stream line to which this stream is linked. ||
|| title | **string**

Title of the stream displayed in interfaces and players. ||
|| description | **string**

Detailed description of the stream content and context. ||
|| thumbnail_id | **string**

Identifier of the thumbnail image used to represent the stream visually. ||
|| status | enum **StreamStatus**

Current status of the stream.

- `STREAM_STATUS_UNSPECIFIED`: The stream status is not specified.
- `OFFLINE`: The stream is offline and not broadcasting.
- `PREPARING`: The system is preparing the infrastructure for receiving the video signal.
- `READY`: The infrastructure is ready to launch the stream.
- `ONAIR`: The stream is currently broadcasting live.
- `FINISHED`: The stream has completed and is no longer broadcasting. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was initiated. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was published (switched to ONAIR status). ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was completed. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls automatic publishing of the stream when it's ready.
When set to true, automatically switches status from READY to ONAIR. ||
|| on_demand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On-demand stream starts immediately when a video signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Specifies the stream scheduling type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Scheduled stream starts and finishes at specified time.

Includes only one of the fields `on_demand`, `schedule`.

Specifies the stream scheduling type. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the stream or its metadata. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream.
Used for organization, filtering, and metadata purposes.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## OnDemand {#yandex.cloud.video.v1.OnDemand}

Represents an on-demand stream type.
This type of stream must be started and finished explicitly by the user.
It begins broadcasting immediately when a video signal is detected.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Represents a scheduled stream type.
This type of stream starts and finishes automatically at specified time.

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Scheduled time when the stream should automatically start. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Scheduled time when the stream should automatically finish. ||
|#
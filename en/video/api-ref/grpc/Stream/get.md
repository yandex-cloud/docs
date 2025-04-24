---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/get.md
---

# Video API, gRPC: StreamService.Get

Get the specific stream.

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

Required field. ID of the stream. ||
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

#|
||Field | Description ||
|| id | **string**

ID of the stream. ||
|| channel_id | **string**

ID of the channel where the stream was created. ||
|| line_id | **string**

ID of the line to which stream is linked. ||
|| title | **string**

Stream title. ||
|| description | **string**

Stream description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| status | enum **StreamStatus**

Stream status.

- `STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.
- `OFFLINE`: Stream offline.
- `PREPARING`: Preparing the infrastructure for receiving video signal.
- `READY`: Everything is ready to launch stream.
- `ONAIR`: Stream onair.
- `FINISHED`: Stream finished. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream start time. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream publish time. Time when stream switched to ONAIR status. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream finish time. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Automatically publish stream when ready.
Switches status from READY to ONAIR. ||
|| on_demand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On-demand stream. Starts immediately when a signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Schedule stream. Starts or finished at the specified time.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when stream was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last stream update. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## OnDemand {#yandex.cloud.video.v1.OnDemand}

On-demand stream type.
This type of streams should be started and finished explicitly.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Schedule stream type.
This type of streams start and finish automatically at the specified time.

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#
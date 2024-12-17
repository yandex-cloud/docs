---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/batchGet.md
---

# Video API, gRPC: StreamService.BatchGet

Batch get streams for channel.

## gRPC request

**rpc BatchGet ([BatchGetStreamsRequest](#yandex.cloud.video.v1.BatchGetStreamsRequest)) returns ([BatchGetStreamsResponse](#yandex.cloud.video.v1.BatchGetStreamsResponse))**

## BatchGetStreamsRequest {#yandex.cloud.video.v1.BatchGetStreamsRequest}

```json
{
  "channel_id": "string",
  "stream_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| stream_ids[] | **string**

List of requested stream IDs. ||
|#

## BatchGetStreamsResponse {#yandex.cloud.video.v1.BatchGetStreamsResponse}

```json
{
  "streams": [
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
  ]
}
```

#|
||Field | Description ||
|| streams[] | **[Stream](#yandex.cloud.video.v1.Stream)**

List of streams for specific channel. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

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
|| on_demand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On demand stream. It starts immediately when a signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Schedule stream. Determines when to start receiving the signal or finish time.

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

If "OnDemand" is used, client should start and finish explicitly.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

If "Schedule" is used, stream automatically start and finish at this time.

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#
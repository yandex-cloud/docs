---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/get.md
---

# Video API, gRPC: StreamService.Get {#Get}

Returns the specific stream.

## gRPC request

**rpc Get ([GetStreamRequest](#yandex.cloud.video.v1.GetStreamRequest)) returns ([Stream](#yandex.cloud.video.v1.Stream))**

## GetStreamRequest {#yandex.cloud.video.v1.GetStreamRequest}

```json
{
  "streamId": "string"
}
```

#|
||Field | Description ||
|| streamId | **string**

ID of the stream. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

```json
{
  "id": "string",
  "channelId": "string",
  "lineId": "string",
  "title": "string",
  "description": "string",
  "thumbnailId": "string",
  "status": "StreamStatus",
  "startTime": "google.protobuf.Timestamp",
  "publishTime": "google.protobuf.Timestamp",
  "finishTime": "google.protobuf.Timestamp",
  // Includes only one of the fields `onDemand`, `schedule`
  "onDemand": "OnDemand",
  "schedule": {
    "startTime": "google.protobuf.Timestamp",
    "finishTime": "google.protobuf.Timestamp"
  },
  // end of the list of possible fields
  "createdAt": "google.protobuf.Timestamp",
  "updatedAt": "google.protobuf.Timestamp",
  "labels": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the stream. ||
|| channelId | **string**

ID of the channel where the stream was created. ||
|| lineId | **string**

ID of the line to which stream is linked. ||
|| title | **string**

Stream title. ||
|| description | **string**

Stream description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| status | enum **StreamStatus**

Stream status.

- `STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.
- `OFFLINE`: Stream offline.
- `PREPARING`: Preparing the infrastructure for receiving video signal.
- `READY`: Everything is ready to launch stream.
- `ONAIR`: Stream onair.
- `FINISHED`: Stream finished. ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream start time. ||
|| publishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream publish time. Time when stream switched to ONAIR status. ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream finish time. ||
|| onDemand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On demand stream. It starts immediately when a signal appears.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Schedule stream. Determines when to start receiving the signal or finish time.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when stream was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last stream update. ||
|| labels | **string**

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
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#
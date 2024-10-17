---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/list.md
---

# Video API, gRPC: StreamService.List {#List}

List streams for channel.

## gRPC request

**rpc List ([ListStreamsRequest](#yandex.cloud.video.v1.ListStreamsRequest)) returns ([ListStreamsResponse](#yandex.cloud.video.v1.ListStreamsResponse))**

## ListStreamsRequest {#yandex.cloud.video.v1.ListStreamsRequest}

```json
{
  "channelId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "orderBy": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

ID of the channel. ||
|| pageSize | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Possible fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"]
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
Value in quotes: `'` or `"`
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["title", "lineId", "status"]
Both snake_case and camelCase are supported for fields. ||
|#

## ListStreamsResponse {#yandex.cloud.video.v1.ListStreamsResponse}

```json
{
  "streams": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| streams[] | **[Stream](#yandex.cloud.video.v1.Stream)**

List of streams for channel. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

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
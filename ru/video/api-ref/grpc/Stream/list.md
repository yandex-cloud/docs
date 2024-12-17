---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/list.md
---

# Video API, gRPC: StreamService.List

List streams for channel.

## gRPC request

**rpc List ([ListStreamsRequest](#yandex.cloud.video.v1.ListStreamsRequest)) returns ([ListStreamsResponse](#yandex.cloud.video.v1.ListStreamsResponse))**

## ListStreamsRequest {#yandex.cloud.video.v1.ListStreamsRequest}

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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| streams[] | **[Stream](#yandex.cloud.video.v1.Stream)**

List of streams for channel. ||
|| next_page_token | **string**

Token for getting the next page. ||
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
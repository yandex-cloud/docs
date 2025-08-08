---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/list.md
---

# Video API, gRPC: StreamService.List

Lists all streams in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

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

Required field. ID of the channel containing the streams to list. ||
|| page_size | **int64**

The maximum number of streams to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStreamsResponse. ||
|| order_by | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "startTime desc").
Default: "id asc".
Supported fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned streams.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'live' AND (status='READY' OR status='ONAIR')`

Filterable fields: ["id", "title", "lineId", "status"].
Both snake_case and camelCase field names are supported. ||
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| streams[] | **[Stream](#yandex.cloud.video.v1.Stream)**

List of streams matching the request criteria.
May be empty if no streams match the criteria or if the channel has no streams. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

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
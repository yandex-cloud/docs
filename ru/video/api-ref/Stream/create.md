---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streams
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel where the stream will be created.
          type: string
        lineId:
          description: |-
            **string**
            Required field. ID of the stream line to which this stream will be linked.
            Stream lines define the technical configuration for streaming.
          type: string
        title:
          description: |-
            **string**
            Required field. Title of the stream to be displayed in interfaces and players.
          type: string
        description:
          description: |-
            **string**
            Detailed description of the stream content and context.
            Optional field that can provide additional information about the stream.
          type: string
        thumbnailId:
          description: |-
            **string**
            ID of the thumbnail image to be used for the stream.
          type: string
        autoPublish:
          description: |-
            **boolean**
            Controls whether the stream is automatically published when ready.
            When set to true, the stream's status will automatically change from
            READY to ONAIR when the streaming infrastructure is prepared,
            making it available for viewing without manual intervention.
          type: boolean
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom user-defined labels as `key:value` pairs.
            Maximum 64 labels per stream.
            Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
            Values can contain alphanumeric characters and various symbols.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        onDemand:
          description: |-
            **object**
            On-demand stream that starts immediately when a video signal appears.
            This type of stream has no predetermined start or end time.
            Includes only one of the fields `onDemand`, `schedule`.
            Specifies the stream scheduling type (exactly one must be chosen).
          $ref: '#/definitions/OnDemandParams'
        schedule:
          description: |-
            **[ScheduleParams](/docs/video/api-ref/Stream/create#yandex.cloud.video.v1.ScheduleParams)**
            Scheduled stream that starts and finishes at specified time.
            This type of stream has predetermined start and end time.
            Includes only one of the fields `onDemand`, `schedule`.
            Specifies the stream scheduling type (exactly one must be chosen).
          $ref: '#/definitions/ScheduleParams'
      required:
        - channelId
        - lineId
        - title
      additionalProperties: false
    definitions:
      OnDemandParams:
        type: object
        properties: {}
      ScheduleParams:
        type: object
        properties:
          startTime:
            description: |-
              **string** (date-time)
              Required field. Scheduled time when the stream should automatically start.
              The streaming infrastructure will be prepared at this time
              and will begin accepting the video signal.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          finishTime:
            description: |-
              **string** (date-time)
              Required field. Scheduled time when the stream should automatically finish.
              The streaming infrastructure will be shut down at this time
              and the stream will be marked as FINISHED.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
        required:
          - startTime
          - finishTime
sourcePath: en/_api-ref/video/v1/api-ref/Stream/create.md
---

# Video API, REST: Stream.Create

Creates a new stream in the specified channel.
Streams can be created as on-demand (starting when a signal appears)
or scheduled (starting and finishing at specified time).

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/streams
```

## Body parameters {#yandex.cloud.video.v1.CreateStreamRequest}

```json
{
  "channelId": "string",
  "lineId": "string",
  "title": "string",
  "description": "string",
  "thumbnailId": "string",
  "autoPublish": "boolean",
  "labels": "object",
  // Includes only one of the fields `onDemand`, `schedule`
  "onDemand": "object",
  "schedule": {
    "startTime": "string",
    "finishTime": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel where the stream will be created. ||
|| lineId | **string**

Required field. ID of the stream line to which this stream will be linked.
Stream lines define the technical configuration for streaming. ||
|| title | **string**

Required field. Title of the stream to be displayed in interfaces and players. ||
|| description | **string**

Detailed description of the stream content and context.
Optional field that can provide additional information about the stream. ||
|| thumbnailId | **string**

ID of the thumbnail image to be used for the stream. ||
|| autoPublish | **boolean**

Controls whether the stream is automatically published when ready.
When set to true, the stream's status will automatically change from
READY to ONAIR when the streaming infrastructure is prepared,
making it available for viewing without manual intervention. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream.
Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
Values can contain alphanumeric characters and various symbols. ||
|| onDemand | **object**

On-demand stream that starts immediately when a video signal appears.
This type of stream has no predetermined start or end time.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type (exactly one must be chosen). ||
|| schedule | **[ScheduleParams](#yandex.cloud.video.v1.ScheduleParams)**

Scheduled stream that starts and finishes at specified time.
This type of stream has predetermined start and end time.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type (exactly one must be chosen). ||
|#

## ScheduleParams {#yandex.cloud.video.v1.ScheduleParams}

#|
||Field | Description ||
|| startTime | **string** (date-time)

Required field. Scheduled time when the stream should automatically start.
The streaming infrastructure will be prepared at this time
and will begin accepting the video signal.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Required field. Scheduled time when the stream should automatically finish.
The streaming infrastructure will be shut down at this time
and the stream will be marked as FINISHED.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "streamId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "channelId": "string",
    "lineId": "string",
    "title": "string",
    "description": "string",
    "thumbnailId": "string",
    "status": "string",
    "startTime": "string",
    "publishTime": "string",
    "finishTime": "string",
    "autoPublish": "boolean",
    // Includes only one of the fields `onDemand`, `schedule`
    "onDemand": "object",
    "schedule": {
      "startTime": "string",
      "finishTime": "string"
    },
    // end of the list of possible fields
    "createdAt": "string",
    "updatedAt": "string",
    "labels": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateStreamMetadata](#yandex.cloud.video.v1.CreateStreamMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Stream](#yandex.cloud.video.v1.Stream)**

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

## CreateStreamMetadata {#yandex.cloud.video.v1.CreateStreamMetadata}

#|
||Field | Description ||
|| streamId | **string**

ID of the stream being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

Entity representing a live video stream.
A stream is a real-time video broadcast linked to a specific stream line.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the stream. ||
|| channelId | **string**

Identifier of the channel where the stream is created and managed. ||
|| lineId | **string**

Identifier of the stream line to which this stream is linked. ||
|| title | **string**

Title of the stream displayed in interfaces and players. ||
|| description | **string**

Detailed description of the stream content and context. ||
|| thumbnailId | **string**

Identifier of the thumbnail image used to represent the stream visually. ||
|| status | **enum** (StreamStatus)

Current status of the stream.

- `STREAM_STATUS_UNSPECIFIED`: The stream status is not specified.
- `OFFLINE`: The stream is offline and not broadcasting.
- `PREPARING`: The system is preparing the infrastructure for receiving the video signal.
- `READY`: The infrastructure is ready to launch the stream.
- `ONAIR`: The stream is currently broadcasting live.
- `FINISHED`: The stream has completed and is no longer broadcasting. ||
|| startTime | **string** (date-time)

Timestamp when the stream was initiated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| publishTime | **string** (date-time)

Timestamp when the stream was published (switched to ONAIR status).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Timestamp when the stream was completed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| autoPublish | **boolean**

Controls automatic publishing of the stream when it's ready.
When set to true, automatically switches status from READY to ONAIR. ||
|| onDemand | **object**

On-demand stream starts immediately when a video signal appears.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Scheduled stream starts and finishes at specified time.

Includes only one of the fields `onDemand`, `schedule`.

Specifies the stream scheduling type. ||
|| createdAt | **string** (date-time)

Timestamp when the stream was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the stream or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream.
Used for organization, filtering, and metadata purposes.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Represents a scheduled stream type.
This type of stream starts and finishes automatically at specified time.

#|
||Field | Description ||
|| startTime | **string** (date-time)

Scheduled time when the stream should automatically start.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Scheduled time when the stream should automatically finish.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
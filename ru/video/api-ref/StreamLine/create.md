---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streamLines
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel.
          type: string
        title:
          description: |-
            **string**
            Required field. Line title.
          type: string
        rtmpPush:
          description: |-
            **object**
            RTMP push input type.
            Includes only one of the fields `rtmpPush`, `rtmpPull`.
            Video signal settings.
          $ref: '#/definitions/RTMPPushParams'
        rtmpPull:
          description: |-
            **[RTMPPullParams](/docs/video/api-ref/StreamLine/create#yandex.cloud.video.v1.RTMPPullParams)**
            RTMP pull input type.
            Includes only one of the fields `rtmpPush`, `rtmpPull`.
            Video signal settings.
          $ref: '#/definitions/RTMPPullParams'
        manualLine:
          description: |-
            **object**
            Manual stream control.
            Includes only one of the fields `manualLine`, `autoLine`.
            Line type.
          $ref: '#/definitions/ManualLineParams'
        autoLine:
          description: |-
            **object**
            Automatic stream control.
            Includes only one of the fields `manualLine`, `autoLine`.
            Line type.
          $ref: '#/definitions/AutoLineParams'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom user-defined labels as key:value pairs.
            Maximum 64 labels per stream line.
            Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
            Values can contain alphanumeric characters and various symbols.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
      required:
        - channelId
        - title
      additionalProperties: false
    definitions:
      RTMPPushParams:
        type: object
        properties: {}
      RTMPPullParams:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. The RTMP URL from which to pull the video stream.
              Must be a valid RTMP URL starting with "rtmp://".
            pattern: rtmp://.*
            type: string
        required:
          - url
      ManualLineParams:
        type: object
        properties: {}
      AutoLineParams:
        type: object
        properties: {}
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/create.md
---

# Video API, REST: StreamLine.Create

Creates a new stream line in the specified channel with the provided configuration.
Stream lines define the technical settings for receiving and processing video signals.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/streamLines
```

## Body parameters {#yandex.cloud.video.v1.CreateStreamLineRequest}

```json
{
  "channelId": "string",
  "title": "string",
  // Includes only one of the fields `rtmpPush`, `rtmpPull`
  "rtmpPush": "object",
  "rtmpPull": {
    "url": "string"
  },
  // end of the list of possible fields
  // Includes only one of the fields `manualLine`, `autoLine`
  "manualLine": "object",
  "autoLine": "object",
  // end of the list of possible fields
  "labels": "object"
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| title | **string**

Required field. Line title. ||
|| rtmpPush | **object**

RTMP push input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Video signal settings. ||
|| rtmpPull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Video signal settings. ||
|| manualLine | **object**

Manual stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| autoLine | **object**

Automatic stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Line type. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as key:value pairs.
Maximum 64 labels per stream line.
Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
Values can contain alphanumeric characters and various symbols. ||
|#

## RTMPPullParams {#yandex.cloud.video.v1.RTMPPullParams}

Parameters for creating an RTMP pull input type stream line.

#|
||Field | Description ||
|| url | **string**

Required field. The RTMP URL from which to pull the video stream.
Must be a valid RTMP URL starting with "rtmp://". ||
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
    "streamLineId": "string"
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
    "title": "string",
    // Includes only one of the fields `rtmpPush`, `rtmpPull`
    "rtmpPush": {
      "url": "string"
    },
    "rtmpPull": {
      "url": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `manualLine`, `autoLine`
    "manualLine": "object",
    "autoLine": {
      "status": "string"
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
|| metadata | **[CreateStreamLineMetadata](#yandex.cloud.video.v1.CreateStreamLineMetadata)**

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

## CreateStreamLineMetadata {#yandex.cloud.video.v1.CreateStreamLineMetadata}

#|
||Field | Description ||
|| streamLineId | **string**

ID of the stream line. ||
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

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity representing the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channelId | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| rtmpPush | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| rtmpPull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`.

Specifies the input type and settings for the video signal source. ||
|| manualLine | **object**

Manual stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| createdAt | **string** (date-time)

Timestamp when the stream line was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the stream line or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream line.
Labels can be used for organization, filtering, and metadata purposes. ||
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

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Represents an automatic line type where the stream control is handled automatically.

#|
||Field | Description ||
|| status | **enum** (AutoLineStatus)

The status of the automatic line.

- `AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.
- `DEACTIVATED`: The automatic line is deactivated and not currently active.
- `ACTIVE`: The automatic line is active and operational. ||
|#
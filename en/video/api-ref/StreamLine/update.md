---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}
    method: patch
    path:
      type: object
      properties:
        streamLineId:
          description: |-
            **string**
            Required field. ID of the line.
            The maximum string length in characters is 50.
          type: string
      required:
        - streamLineId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        fieldMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        title:
          description: |-
            **string**
            Line title.
            The maximum string length in characters is 300.
          type: string
        rtmpPush:
          description: |-
            **object**
            RTMP push input type.
            Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.
            Video signal settings.
          $ref: '#/definitions/RTMPPushParams'
        rtmpPull:
          description: |-
            **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**
            RTMP pull input type.
            Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.
            Video signal settings.
          $ref: '#/definitions/RTMPPullParams'
        srtPull:
          description: |-
            **[SRTPullParams](#yandex.cloud.video.v1.SRTPullParams)**
            SRT pull input type.
            Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.
            Video signal settings.
          $ref: '#/definitions/SRTPullParams'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New custom labels for the stream line as `key:value` pairs.
            Maximum 64 labels per stream line.
            If provided, replaces all existing labels.
            The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_.@:/0-9a-zA-Z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
      required:
        - fieldMask
      additionalProperties: false
      oneOf:
        - required:
            - rtmpPush
        - required:
            - rtmpPull
        - required:
            - srtPull
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
              Value must match the regular expression ` rtmp://.* `.
            pattern: rtmp://.*
            type: string
        required:
          - url
      SRTPullParams:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. The SRT URL from which to pull the video stream.
              Must be a valid SRT URL starting with "srt://".
              Value must match the regular expression ` srt://.* `.
            pattern: srt://.*
            type: string
        required:
          - url
---

# Video API, REST: StreamLine.Update

Updates an existing stream line's metadata and configuration.
Only fields specified in the field_mask will be updated.

## HTTP request

```
PATCH https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}
```

## Path parameters

#|
||Field | Description ||
|| streamLineId | **string**

Required field. ID of the line.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.video.v1.UpdateStreamLineRequest}

```json
{
  "fieldMask": "string",
  "title": "string",
  // Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`
  "rtmpPush": "object",
  "rtmpPull": {
    "url": "string"
  },
  "srtPull": {
    "url": "string"
  },
  // end of the list of possible fields
  "labels": "object"
}
```

#|
||Field | Description ||
|| fieldMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| title | **string**

Line title.

The maximum string length in characters is 300. ||
|| rtmpPush | **object**

RTMP push input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.

Video signal settings. ||
|| rtmpPull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.

Video signal settings. ||
|| srtPull | **[SRTPullParams](#yandex.cloud.video.v1.SRTPullParams)**

SRT pull input type.

Includes only one of the fields `rtmpPush`, `rtmpPull`, `srtPull`.

Video signal settings. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the stream line as `key:value` pairs.
Maximum 64 labels per stream line.
If provided, replaces all existing labels.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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
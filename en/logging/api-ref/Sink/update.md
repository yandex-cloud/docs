---
editable: false
apiPlayground:
  - url: https://logging.{{ api-host }}/logging/v1/sinks/{sinkId}
    method: patch
    path:
      type: object
      properties:
        sinkId:
          description: |-
            **string**
            Required field. ID of the sink to update.
            To get a sink ID make a [SinkService.List](/docs/logging/api-ref/Sink/list#List) request.
          type: string
      required:
        - sinkId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name of the sink.
            The name must be unique within the folder.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            New Description of the sink.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New sink labels as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        serviceAccountId:
          description: |-
            **string**
            new service account to use for logs writing to the sink.
          type: string
        yds:
          description: |-
            **[Yds](#yandex.cloud.logging.v1.Sink.Yds)**
            Yandex data stream
            Includes only one of the fields `yds`, `s3`.
            New logs destination
          $ref: '#/definitions/Yds'
        s3:
          description: |-
            **[S3](#yandex.cloud.logging.v1.Sink.S3)**
            Object storage
            Includes only one of the fields `yds`, `s3`.
            New logs destination
          $ref: '#/definitions/S3'
      additionalProperties: false
      oneOf:
        - required:
            - yds
        - required:
            - s3
    definitions:
      Yds:
        type: object
        properties:
          streamName:
            description: |-
              **string**
              Fully qualified name of data stream
            type: string
      S3:
        type: object
        properties:
          bucket:
            description: |-
              **string**
              Object storage bucket
            pattern: '[a-zA-Z0-9][-a-zA-Z0-9.]{2,62}'
            type: string
          prefix:
            description: |-
              **string**
              Prefix to use for saved log object names
            type: string
sourcePath: en/_api-ref/logging/v1/api-ref/Sink/update.md
---

# Cloud Logging Service, REST: Sink.Update

Updates the specified sink.

## HTTP request

```
PATCH https://logging.{{ api-host }}/logging/v1/sinks/{sinkId}
```

## Path parameters

#|
||Field | Description ||
|| sinkId | **string**

Required field. ID of the sink to update.

To get a sink ID make a [SinkService.List](/docs/logging/api-ref/Sink/list#List) request. ||
|#

## Body parameters {#yandex.cloud.logging.v1.UpdateSinkRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "serviceAccountId": "string",
  // Includes only one of the fields `yds`, `s3`
  "yds": {
    "streamName": "string"
  },
  "s3": {
    "bucket": "string",
    "prefix": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the sink.
The name must be unique within the folder. ||
|| description | **string**

New Description of the sink. ||
|| labels | **object** (map<**string**, **string**>)

New sink labels as `key:value` pairs. ||
|| serviceAccountId | **string**

new service account to use for logs writing to the sink. ||
|| yds | **[Yds](#yandex.cloud.logging.v1.Sink.Yds)**

Yandex data stream

Includes only one of the fields `yds`, `s3`.

New logs destination ||
|| s3 | **[S3](#yandex.cloud.logging.v1.Sink.S3)**

Object storage

Includes only one of the fields `yds`, `s3`.

New logs destination ||
|#

## Yds {#yandex.cloud.logging.v1.Sink.Yds}

#|
||Field | Description ||
|| streamName | **string**

Fully qualified name of data stream ||
|#

## S3 {#yandex.cloud.logging.v1.Sink.S3}

#|
||Field | Description ||
|| bucket | **string**

Object storage bucket ||
|| prefix | **string**

Prefix to use for saved log object names ||
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
    "sinkId": "string"
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
    "folderId": "string",
    "cloudId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "serviceAccountId": "string",
    // Includes only one of the fields `yds`, `s3`
    "yds": {
      "streamName": "string"
    },
    "s3": {
      "bucket": "string",
      "prefix": "string"
    }
    // end of the list of possible fields
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
|| metadata | **[UpdateSinkMetadata](#yandex.cloud.logging.v1.UpdateSinkMetadata)**

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
|| response | **[Sink](#yandex.cloud.logging.v1.Sink)**

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

## UpdateSinkMetadata {#yandex.cloud.logging.v1.UpdateSinkMetadata}

#|
||Field | Description ||
|| sinkId | **string**

ID of the sink being updated. ||
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

## Sink {#yandex.cloud.logging.v1.Sink}

#|
||Field | Description ||
|| id | **string**

Sink ID. ||
|| folderId | **string**

Sink folder ID. ||
|| cloudId | **string**

Sink cloud ID. ||
|| createdAt | **string** (date-time)

Sink creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Sink name. ||
|| description | **string**

Sink description. ||
|| labels | **object** (map<**string**, **string**>)

Sink labels. ||
|| serviceAccountId | **string**

Logs will be written to the sink on behalf of this service account ||
|| yds | **[Yds](#yandex.cloud.logging.v1.Sink.Yds2)**

Yandex data stream

Includes only one of the fields `yds`, `s3`.

Logs destination ||
|| s3 | **[S3](#yandex.cloud.logging.v1.Sink.S32)**

Object storage

Includes only one of the fields `yds`, `s3`.

Logs destination ||
|#

## Yds {#yandex.cloud.logging.v1.Sink.Yds2}

#|
||Field | Description ||
|| streamName | **string**

Fully qualified name of data stream ||
|#

## S3 {#yandex.cloud.logging.v1.Sink.S32}

#|
||Field | Description ||
|| bucket | **string**

Object storage bucket ||
|| prefix | **string**

Prefix to use for saved log object names ||
|#
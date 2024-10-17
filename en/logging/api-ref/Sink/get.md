---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Sink/get.md
---

# Cloud Logging Service, REST: Sink.Get {#Get}

Returns the specified sink.

To get the list of all available sinks, make a [List](/docs/logging/api-ref/Sink/list#List) request.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/sinks/{sinkId}
```

## Path parameters

#|
||Field | Description ||
|| sinkId | **string**

Required field. ID of the sink to return.

To get a sink ID make a [SinkService.List](/docs/logging/api-ref/Sink/list#List) request. ||
|#

## Response {#yandex.cloud.logging.v1.Sink}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
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
|| labels | **string**

Sink labels. ||
|| serviceAccountId | **string**

Logs will be written to the sink on behalf of this service account ||
|| yds | **[Yds](#yandex.cloud.logging.v1.Sink.Yds)**

Yandex data stream

Includes only one of the fields `yds`, `s3`.

Logs destination ||
|| s3 | **[S3](#yandex.cloud.logging.v1.Sink.S3)**

Object storage

Includes only one of the fields `yds`, `s3`.

Logs destination ||
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
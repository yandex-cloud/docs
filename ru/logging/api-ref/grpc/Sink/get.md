---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/Sink/get.md
---

# Cloud Logging Service, gRPC: SinkService.Get

Returns the specified sink.

To get the list of all available sinks, make a [List](/docs/logging/api-ref/grpc/Sink/list#List) request.

## gRPC request

**rpc Get ([GetSinkRequest](#yandex.cloud.logging.v1.GetSinkRequest)) returns ([Sink](#yandex.cloud.logging.v1.Sink))**

## GetSinkRequest {#yandex.cloud.logging.v1.GetSinkRequest}

```json
{
  "sink_id": "string"
}
```

#|
||Field | Description ||
|| sink_id | **string**

Required field. ID of the sink to return.

To get a sink ID make a [SinkService.List](/docs/logging/api-ref/grpc/Sink/list#List) request. ||
|#

## Sink {#yandex.cloud.logging.v1.Sink}

```json
{
  "id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "service_account_id": "string",
  // Includes only one of the fields `yds`, `s3`
  "yds": {
    "stream_name": "string"
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
|| folder_id | **string**

Sink folder ID. ||
|| cloud_id | **string**

Sink cloud ID. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Sink creation time. ||
|| name | **string**

Sink name. ||
|| description | **string**

Sink description. ||
|| labels | **object** (map<**string**, **string**>)

Sink labels. ||
|| service_account_id | **string**

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
|| stream_name | **string**

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
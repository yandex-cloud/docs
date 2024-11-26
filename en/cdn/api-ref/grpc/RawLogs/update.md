---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/RawLogs/update.md
---

# Cloud CDN API, gRPC: RawLogsService.Update

## gRPC request

**rpc Update ([UpdateRawLogsRequest](#yandex.cloud.cdn.v1.UpdateRawLogsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateRawLogsRequest {#yandex.cloud.cdn.v1.UpdateRawLogsRequest}

```json
{
  "resource_id": "string",
  "settings": {
    "bucket_name": "string",
    "bucket_region": "string",
    "file_prefix": "string"
  }
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of CDN resource. ||
|| settings | **[RawLogsSettings](#yandex.cloud.cdn.v1.RawLogsSettings)**

Raw logs settings. ||
|#

## RawLogsSettings {#yandex.cloud.cdn.v1.RawLogsSettings}

User settings for Raw logs.

#|
||Field | Description ||
|| bucket_name | **string**

Required field. Destination S3 bucket name, note that the suer should be owner of the bucket. ||
|| bucket_region | **string**

Bucket region, unused for now, could be blank. ||
|| file_prefix | **string**

file_prefix: prefix each log object name with specified prefix.

The prefix makes it simpler for you to locate the log objects.
For example, if you specify the prefix value logs/, each log object that
S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders
could be setup. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "resource_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "status": "RawLogsStatus",
    "settings": {
      "bucket_name": "string",
      "bucket_region": "string",
      "file_prefix": "string"
    }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRawLogsMetadata](#yandex.cloud.cdn.v1.UpdateRawLogsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[UpdateRawLogsResponse](#yandex.cloud.cdn.v1.UpdateRawLogsResponse)**

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

## UpdateRawLogsMetadata {#yandex.cloud.cdn.v1.UpdateRawLogsMetadata}

#|
||Field | Description ||
|| resource_id | **string**

ID of CDN resource. ||
|#

## UpdateRawLogsResponse {#yandex.cloud.cdn.v1.UpdateRawLogsResponse}

#|
||Field | Description ||
|| status | enum **RawLogsStatus**

Raw logs status.

- `RAW_LOGS_STATUS_UNSPECIFIED`
- `RAW_LOGS_STATUS_NOT_ACTIVATED`: Raw logs wasn't activated.
- `RAW_LOGS_STATUS_OK`: Raw logs was activated, and logs storing process works as expected.
- `RAW_LOGS_STATUS_FAILED`: Raw logs was activated, but CDN provider has been failed to store logs.
- `RAW_LOGS_STATUS_PENDING`: Raw logs was activated, but logs storing process is expected. ||
|| settings | **[RawLogsSettings](#yandex.cloud.cdn.v1.RawLogsSettings2)**

Raw logs settings. ||
|#

## RawLogsSettings {#yandex.cloud.cdn.v1.RawLogsSettings2}

User settings for Raw logs.

#|
||Field | Description ||
|| bucket_name | **string**

Required field. Destination S3 bucket name, note that the suer should be owner of the bucket. ||
|| bucket_region | **string**

Bucket region, unused for now, could be blank. ||
|| file_prefix | **string**

file_prefix: prefix each log object name with specified prefix.

The prefix makes it simpler for you to locate the log objects.
For example, if you specify the prefix value logs/, each log object that
S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders
could be setup. ||
|#
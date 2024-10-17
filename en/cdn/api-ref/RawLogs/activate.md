---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/RawLogs/activate.md
---

# Cloud CDN API, REST: RawLogs.Activate {#Activate}

## HTTP request

```
POST https://cdn.{{ api-host }}/cdn/v1/rawLogs:activate
```

## Body parameters {#yandex.cloud.cdn.v1.ActivateRawLogsRequest}

```json
{
  "resourceId": "string",
  "settings": {
    "bucketName": "string",
    "bucketRegion": "string",
    "filePrefix": "string"
  }
}
```

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of CDN resource to switch logs storage for.. ||
|| settings | **[RawLogsSettings](#yandex.cloud.cdn.v1.RawLogsSettings)**

Raw logs settings. ||
|#

## RawLogsSettings {#yandex.cloud.cdn.v1.RawLogsSettings}

User settings for Raw logs.

#|
||Field | Description ||
|| bucketName | **string**

Required field. Destination S3 bucket name, note that the suer should be owner of the bucket. ||
|| bucketRegion | **string**

Bucket region, unused for now, could be blank. ||
|| filePrefix | **string**

file_prefix: prefix each log object name with specified prefix.

The prefix makes it simpler for you to locate the log objects.
For example, if you specify the prefix value logs/, each log object that
S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders
could be setup. ||
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
    "resourceId": "string"
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
    "status": "string",
    "settings": {
      "bucketName": "string",
      "bucketRegion": "string",
      "filePrefix": "string"
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
|| metadata | **[ActivateRawLogsMetadata](#yandex.cloud.cdn.v1.ActivateRawLogsMetadata)**

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
|| response | **[ActivateRawLogsResponse](#yandex.cloud.cdn.v1.ActivateRawLogsResponse)**

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

## ActivateRawLogsMetadata {#yandex.cloud.cdn.v1.ActivateRawLogsMetadata}

#|
||Field | Description ||
|| resourceId | **string**

ID of resource with activated raw logs. ||
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

## ActivateRawLogsResponse {#yandex.cloud.cdn.v1.ActivateRawLogsResponse}

#|
||Field | Description ||
|| status | **enum** (RawLogsStatus)

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
|| bucketName | **string**

Required field. Destination S3 bucket name, note that the suer should be owner of the bucket. ||
|| bucketRegion | **string**

Bucket region, unused for now, could be blank. ||
|| filePrefix | **string**

file_prefix: prefix each log object name with specified prefix.

The prefix makes it simpler for you to locate the log objects.
For example, if you specify the prefix value logs/, each log object that
S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders
could be setup. ||
|#
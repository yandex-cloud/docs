---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/RawLogs/get.md
---

# Cloud CDN API, REST: RawLogs.Get {#Get}

## HTTP request

```
GET https://cdn.{{ api-host }}/cdn/v1/rawLogs/{resourceId}
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of CDN resource to request status and settings. ||
|#

## Response {#yandex.cloud.cdn.v1.GetRawLogsResponse}

**HTTP Code: 200 - OK**

```json
{
  "status": "string",
  "settings": {
    "bucketName": "string",
    "bucketRegion": "string",
    "filePrefix": "string"
  }
}
```

#|
||Field | Description ||
|| status | **enum** (RawLogsStatus)

Raw logs status.

- `RAW_LOGS_STATUS_UNSPECIFIED`
- `RAW_LOGS_STATUS_NOT_ACTIVATED`: Raw logs wasn't activated.
- `RAW_LOGS_STATUS_OK`: Raw logs was activated, and logs storing process works as expected.
- `RAW_LOGS_STATUS_FAILED`: Raw logs was activated, but CDN provider has been failed to store logs.
- `RAW_LOGS_STATUS_PENDING`: Raw logs was activated, but logs storing process is expected. ||
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
---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/readLogs.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.ReadLogs {#ReadLogs}

Returns stream of job logs.

## gRPC request

**rpc ReadLogs ([ReadProjectJobLogsRequest](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsRequest)) returns (stream [ReadProjectJobLogsResponse](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsResponse))**

## ReadProjectJobLogsRequest {#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsRequest}

```json
{
  "jobId": "string",
  "offset": "int64"
}
```

#|
||Field | Description ||
|| jobId | **string**

ID of the job. ||
|| offset | **int64**

Log offset. ||
|#

## ReadProjectJobLogsResponse {#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsResponse}

```json
{
  "logs": [
    {
      "content": "bytes",
      "createdAt": "google.protobuf.Timestamp",
      // Includes only one of the fields `standardStream`, `filePath`
      "standardStream": "StandardStream",
      "filePath": "string"
      // end of the list of possible fields
    }
  ],
  "offset": "int64"
}
```

#|
||Field | Description ||
|| logs[] | **[LogMessage](#yandex.cloud.datasphere.v2.jobs.LogMessage)** ||
|| offset | **int64**

Log offset. ||
|#

## LogMessage {#yandex.cloud.datasphere.v2.jobs.LogMessage}

#|
||Field | Description ||
|| content | **bytes**

Log message contents. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log message creation timestamp. ||
|| standardStream | enum **StandardStream**

Program standard streams.

Includes only one of the fields `standardStream`, `filePath`.

- `STANDARD_STREAM_UNSPECIFIED`
- `OUT`: Stdout.
- `ERR`: Stderr. ||
|| filePath | **string**

System debug log files.

Includes only one of the fields `standardStream`, `filePath`. ||
|#
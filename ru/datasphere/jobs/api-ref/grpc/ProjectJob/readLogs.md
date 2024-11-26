---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/readLogs.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.ReadLogs

Returns stream of job logs.

## gRPC request

**rpc ReadLogs ([ReadProjectJobLogsRequest](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsRequest)) returns (stream [ReadProjectJobLogsResponse](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsResponse))**

## ReadProjectJobLogsRequest {#yandex.cloud.datasphere.v2.jobs.ReadProjectJobLogsRequest}

```json
{
  "job_id": "string",
  "offset": "int64"
}
```

#|
||Field | Description ||
|| job_id | **string**

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
      "created_at": "google.protobuf.Timestamp",
      // Includes only one of the fields `standard_stream`, `file_path`
      "standard_stream": "StandardStream",
      "file_path": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log message creation timestamp. ||
|| standard_stream | enum **StandardStream**

Program standard streams.

Includes only one of the fields `standard_stream`, `file_path`.

- `STANDARD_STREAM_UNSPECIFIED`
- `OUT`: Stdout.
- `ERR`: Stderr. ||
|| file_path | **string**

System debug log files.

Includes only one of the fields `standard_stream`, `file_path`. ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/readStdLogs.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.ReadStdLogs

Returns stream of job logs.

## gRPC request

**rpc ReadStdLogs ([ReadProjectJobStdLogsRequest](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobStdLogsRequest)) returns (stream [ReadProjectJobStdLogsResponse](#yandex.cloud.datasphere.v2.jobs.ReadProjectJobStdLogsResponse))**

## ReadProjectJobStdLogsRequest {#yandex.cloud.datasphere.v2.jobs.ReadProjectJobStdLogsRequest}

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

## ReadProjectJobStdLogsResponse {#yandex.cloud.datasphere.v2.jobs.ReadProjectJobStdLogsResponse}

```json
{
  "logs": [
    {
      "content": "bytes",
      "type": "Type"
    }
  ],
  "offset": "int64"
}
```

#|
||Field | Description ||
|| logs[] | **[StdLog](#yandex.cloud.datasphere.v2.jobs.StdLog)** ||
|| offset | **int64**

Log offset. ||
|#

## StdLog {#yandex.cloud.datasphere.v2.jobs.StdLog}

#|
||Field | Description ||
|| content | **bytes**

Log contents. ||
|| type | enum **Type**

Log type.

- `TYPE_UNSPECIFIED`
- `OUT`: stdout.
- `ERR`: stderr. ||
|#
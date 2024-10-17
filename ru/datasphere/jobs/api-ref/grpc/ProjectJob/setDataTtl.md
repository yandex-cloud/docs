---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/setDataTtl.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.SetDataTtl {#SetDataTtl}

Update job data ttl.

## gRPC request

**rpc SetDataTtl ([SetProjectJobDataTtlRequest](#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlRequest)) returns ([SetProjectJobDataTtlResponse](#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlResponse))**

## SetProjectJobDataTtlRequest {#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlRequest}

```json
{
  "jobId": "string",
  "ttl": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| jobId | **string** ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|#

## SetProjectJobDataTtlResponse {#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#
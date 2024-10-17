---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/cancel.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.Cancel {#Cancel}

Cancels running job.

## gRPC request

**rpc Cancel ([CancelProjectJobRequest](#yandex.cloud.datasphere.v2.jobs.CancelProjectJobRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## CancelProjectJobRequest {#yandex.cloud.datasphere.v2.jobs.CancelProjectJobRequest}

```json
{
  "jobId": "string",
  "reason": "string",
  "graceful": "bool"
}
```

#|
||Field | Description ||
|| jobId | **string**

ID of the job. ||
|| reason | **string**

Optional cancellation reason. ||
|| graceful | **bool**

If the job is launched with graceful shutdown support, the shutdown will be performed gracefully ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/describe.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.Describe

## gRPC request

**rpc Describe ([DescribeTuningRequest](#yandex.cloud.ai.tuning.v1.DescribeTuningRequest)) returns ([DescribeTuningResponse](#yandex.cloud.ai.tuning.v1.DescribeTuningResponse))**

## DescribeTuningRequest {#yandex.cloud.ai.tuning.v1.DescribeTuningRequest}

```json
{
  "tuning_task_id": "string"
}
```

#|
||Field | Description ||
|| tuning_task_id | **string**

Required field.  ||
|#

## DescribeTuningResponse {#yandex.cloud.ai.tuning.v1.DescribeTuningResponse}

```json
{
  "tuning_task": {
    "task_id": "string",
    "operation_id": "string",
    "status": "Status",
    "folder_id": "string",
    "created_by": "string",
    "created_at": "google.protobuf.Timestamp",
    "started_at": "google.protobuf.Timestamp",
    "finished_at": "google.protobuf.Timestamp",
    "source_model_uri": "string",
    "target_model_uri": "string"
  }
}
```

#|
||Field | Description ||
|| tuning_task | **[TuningTask](#yandex.cloud.ai.tuning.v1.TuningTask)** ||
|#

## TuningTask {#yandex.cloud.ai.tuning.v1.TuningTask}

#|
||Field | Description ||
|| task_id | **string** ||
|| operation_id | **string** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| folder_id | **string** ||
|| created_by | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| source_model_uri | **string** ||
|| target_model_uri | **string** ||
|#
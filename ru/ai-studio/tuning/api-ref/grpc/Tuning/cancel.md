---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/cancel.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.Cancel

## gRPC request

**rpc Cancel ([CancelTuningRequest](#yandex.cloud.ai.tuning.v1.CancelTuningRequest)) returns ([CancelTuningResponse](#yandex.cloud.ai.tuning.v1.CancelTuningResponse))**

## CancelTuningRequest {#yandex.cloud.ai.tuning.v1.CancelTuningRequest}

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

## CancelTuningResponse {#yandex.cloud.ai.tuning.v1.CancelTuningResponse}

```json
{
  "tuning_task_id": "string"
}
```

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|#
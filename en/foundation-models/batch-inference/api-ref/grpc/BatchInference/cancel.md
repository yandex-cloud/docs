---
editable: false
sourcePath: en/_api-ref-grpc/ai/batch_inference/v1/batch-inference/api-ref/grpc/BatchInference/cancel.md
---

# Batch Inference Service API, gRPC: BatchInferenceService.Cancel

Cancels a concrete task

## gRPC request

**rpc Cancel ([CancelBatchInferenceRequest](#yandex.cloud.ai.batch_inference.v1.CancelBatchInferenceRequest)) returns ([CancelBatchInferenceResponse](#yandex.cloud.ai.batch_inference.v1.CancelBatchInferenceResponse))**

## CancelBatchInferenceRequest {#yandex.cloud.ai.batch_inference.v1.CancelBatchInferenceRequest}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string**

Required field. Task ID that should be canceled. ||
|#

## CancelBatchInferenceResponse {#yandex.cloud.ai.batch_inference.v1.CancelBatchInferenceResponse}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string** ||
|#
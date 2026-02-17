---
editable: false
---

# Batch Inference Service API, gRPC: BatchInferenceService.Delete

Deletes a concrete task

## gRPC request

**rpc Delete ([DeleteBatchInferenceRequest](#yandex.cloud.ai.batch_inference.v1.DeleteBatchInferenceRequest)) returns ([DeleteBatchInferenceResponse](#yandex.cloud.ai.batch_inference.v1.DeleteBatchInferenceResponse))**

## DeleteBatchInferenceRequest {#yandex.cloud.ai.batch_inference.v1.DeleteBatchInferenceRequest}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string**

Required field. Task ID that should be deleted. ||
|#

## DeleteBatchInferenceResponse {#yandex.cloud.ai.batch_inference.v1.DeleteBatchInferenceResponse}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string** ||
|#
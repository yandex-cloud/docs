---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/getMetricsUrl.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.GetMetricsUrl

## gRPC request

**rpc GetMetricsUrl ([GetMetricsUrlRequest](#yandex.cloud.ai.tuning.v1.GetMetricsUrlRequest)) returns ([GetMetricsUrlResponse](#yandex.cloud.ai.tuning.v1.GetMetricsUrlResponse))**

## GetMetricsUrlRequest {#yandex.cloud.ai.tuning.v1.GetMetricsUrlRequest}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string**

Required field.  ||
|#

## GetMetricsUrlResponse {#yandex.cloud.ai.tuning.v1.GetMetricsUrlResponse}

```json
{
  "load_url": "string"
}
```

#|
||Field | Description ||
|| load_url | **string** ||
|#
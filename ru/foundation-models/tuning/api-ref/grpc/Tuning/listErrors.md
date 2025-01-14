---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/listErrors.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.ListErrors

## gRPC request

**rpc ListErrors ([ListErrorsRequest](#yandex.cloud.ai.tuning.v1.ListErrorsRequest)) returns ([ListErrorsResponse](#yandex.cloud.ai.tuning.v1.ListErrorsResponse))**

## ListErrorsRequest {#yandex.cloud.ai.tuning.v1.ListErrorsRequest}

```json
{
  "tuning_task_id": "string"
}
```

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|#

## ListErrorsResponse {#yandex.cloud.ai.tuning.v1.ListErrorsResponse}

```json
{
  "tuning_error": [
    {
      "tuning_task_id": "string",
      "message": "string",
      "type": "Type"
    }
  ]
}
```

#|
||Field | Description ||
|| tuning_error[] | **[TuningError](#yandex.cloud.ai.tuning.v1.TuningError)** ||
|#

## TuningError {#yandex.cloud.ai.tuning.v1.TuningError}

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|| message | **string** ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `PUBLIC`
- `INTERNAL` ||
|#
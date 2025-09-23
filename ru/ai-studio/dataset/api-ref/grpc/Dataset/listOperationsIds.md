---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/listOperationsIds.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.ListOperationsIds

## gRPC request

**rpc ListOperationsIds ([ListOperationsIdsRequest](#yandex.cloud.ai.dataset.v1.ListOperationsIdsRequest)) returns ([ListOperationsIdsResponse](#yandex.cloud.ai.dataset.v1.ListOperationsIdsResponse))**

## ListOperationsIdsRequest {#yandex.cloud.ai.dataset.v1.ListOperationsIdsRequest}

```json
{
  "dataset_id": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| dataset_id[] | **string** ||
|#

## ListOperationsIdsResponse {#yandex.cloud.ai.dataset.v1.ListOperationsIdsResponse}

```json
{
  "dataset_id_to_operation_id": "map<string, string>"
}
```

#|
||Field | Description ||
|| dataset_id_to_operation_id | **object** (map<**string**, **string**>) ||
|#
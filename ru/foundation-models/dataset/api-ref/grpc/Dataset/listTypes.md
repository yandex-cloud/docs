---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/listTypes.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.ListTypes

Returns a list of dataset types

## gRPC request

**rpc ListTypes ([ListTypesRequest](#yandex.cloud.ai.dataset.v1.ListTypesRequest)) returns ([ListTypesResponse](#yandex.cloud.ai.dataset.v1.ListTypesResponse))**

## ListTypesRequest {#yandex.cloud.ai.dataset.v1.ListTypesRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Folder to search task types (if empty only public types will be returned) ||
|#

## ListTypesResponse {#yandex.cloud.ai.dataset.v1.ListTypesResponse}

```json
{
  "types": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| types[] | **string**

List of dataset type ||
|#
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
{}
```

#|
||Field | Description ||
|| Empty | > ||
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
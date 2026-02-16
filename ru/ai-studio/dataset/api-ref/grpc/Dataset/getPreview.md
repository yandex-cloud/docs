---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/getPreview.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.GetPreview

Returns a preview of dataset types

## gRPC request

**rpc GetPreview ([GetDatasetPreviewRequest](#yandex.cloud.ai.dataset.v1.GetDatasetPreviewRequest)) returns ([GetDatasetPreviewResponse](#yandex.cloud.ai.dataset.v1.GetDatasetPreviewResponse))**

## GetDatasetPreviewRequest {#yandex.cloud.ai.dataset.v1.GetDatasetPreviewRequest}

```json
{
  "dataset_id": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset. ||
|#

## GetDatasetPreviewResponse {#yandex.cloud.ai.dataset.v1.GetDatasetPreviewResponse}

```json
{
  "dataset_id": "string",
  "preview_lines": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| preview_lines[] | **string**

List of dataset preview lines ||
|#
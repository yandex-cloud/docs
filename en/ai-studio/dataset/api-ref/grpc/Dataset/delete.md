---
editable: false
---

# Foundation Models Dataset Service API, gRPC: DatasetService.Delete

Deletes dataset.

## gRPC request

**rpc Delete ([DeleteDatasetRequest](#yandex.cloud.ai.dataset.v1.DeleteDatasetRequest)) returns ([DeleteDatasetResponse](#yandex.cloud.ai.dataset.v1.DeleteDatasetResponse))**

## DeleteDatasetRequest {#yandex.cloud.ai.dataset.v1.DeleteDatasetRequest}

```json
{
  "dataset_id": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset to delete. ||
|#

## DeleteDatasetResponse {#yandex.cloud.ai.dataset.v1.DeleteDatasetResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#
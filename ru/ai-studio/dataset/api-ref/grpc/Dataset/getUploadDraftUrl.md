---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/getUploadDraftUrl.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.GetUploadDraftUrl

Returns an S3 presigned URL for dataset upload.
This method only applicable if the dataset size does not exceed 5GB.

## gRPC request

**rpc GetUploadDraftUrl ([GetUploadDraftUrlRequest](#yandex.cloud.ai.dataset.v1.GetUploadDraftUrlRequest)) returns ([GetUploadDraftUrlResponse](#yandex.cloud.ai.dataset.v1.GetUploadDraftUrlResponse))**

## GetUploadDraftUrlRequest {#yandex.cloud.ai.dataset.v1.GetUploadDraftUrlRequest}

```json
{
  "dataset_id": "string",
  "size_bytes": "int64"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset to upload. ||
|| size_bytes | **int64**

Size in bytes of the dataset to upload. ||
|#

## GetUploadDraftUrlResponse {#yandex.cloud.ai.dataset.v1.GetUploadDraftUrlResponse}

```json
{
  "dataset_id": "string",
  "upload_url": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| upload_url | **string**

S3 presigned URL for upload. ||
|#
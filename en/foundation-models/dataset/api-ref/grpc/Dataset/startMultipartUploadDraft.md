---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/startMultipartUploadDraft.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.StartMultipartUploadDraft

Returns a list of S3 presigned URLs for multipart upload of dataset.

## gRPC request

**rpc StartMultipartUploadDraft ([StartMultipartUploadDraftRequest](#yandex.cloud.ai.dataset.v1.StartMultipartUploadDraftRequest)) returns ([StartMultipartUploadDraftResponse](#yandex.cloud.ai.dataset.v1.StartMultipartUploadDraftResponse))**

## StartMultipartUploadDraftRequest {#yandex.cloud.ai.dataset.v1.StartMultipartUploadDraftRequest}

```json
{
  "dataset_id": "string",
  "size_bytes": "int64",
  "parts": "int64"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset to multipart upload. ||
|| size_bytes | **int64**

Size in bytes of the dataset to upload. ||
|| parts | **int64**

Number of parts in multipart upload. Optional.
Dataset's part size should be between 5MB and 5GB.
If not specified will be configured automatically. ||
|#

## StartMultipartUploadDraftResponse {#yandex.cloud.ai.dataset.v1.StartMultipartUploadDraftResponse}

```json
{
  "dataset_id": "string",
  "multipart_upload_urls": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| multipart_upload_urls[] | **string**

List of S3 presigned URLs for multipart upload. ||
|#
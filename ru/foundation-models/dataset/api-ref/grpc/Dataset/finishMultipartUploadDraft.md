---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/finishMultipartUploadDraft.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.FinishMultipartUploadDraft

Finishes multipart upload of the dataset.

## gRPC request

**rpc FinishMultipartUploadDraft ([FinishMultipartUploadDraftRequest](#yandex.cloud.ai.dataset.v1.FinishMultipartUploadDraftRequest)) returns ([FinishMultipartUploadDraftResponse](#yandex.cloud.ai.dataset.v1.FinishMultipartUploadDraftResponse))**

## FinishMultipartUploadDraftRequest {#yandex.cloud.ai.dataset.v1.FinishMultipartUploadDraftRequest}

```json
{
  "dataset_id": "string",
  "uploaded_parts": [
    {
      "part_num": "int64",
      "etag": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset. ||
|| uploaded_parts[] | **[UploadedPartInfo](#yandex.cloud.ai.dataset.v1.UploadedPartInfo)**

Information about uploaded parts from S3 API. ||
|#

## UploadedPartInfo {#yandex.cloud.ai.dataset.v1.UploadedPartInfo}

#|
||Field | Description ||
|| part_num | **int64**

Sequence number of the uploaded part. ||
|| etag | **string**

Required field. Etag of the uploaded part. ||
|#

## FinishMultipartUploadDraftResponse {#yandex.cloud.ai.dataset.v1.FinishMultipartUploadDraftResponse}

```json
{
  "dataset_id": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|#
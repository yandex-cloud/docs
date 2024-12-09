---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/listUploadFormats.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.ListUploadFormats

Lists supported upload formats for the specified dataset task type.

## gRPC request

**rpc ListUploadFormats ([ListUploadFormatsRequest](#yandex.cloud.ai.dataset.v1.ListUploadFormatsRequest)) returns ([ListUploadFormatsResponse](#yandex.cloud.ai.dataset.v1.ListUploadFormatsResponse))**

## ListUploadFormatsRequest {#yandex.cloud.ai.dataset.v1.ListUploadFormatsRequest}

```json
{
  "task_type": "string"
}
```

#|
||Field | Description ||
|| task_type | **string**

Required field. Dataset task type to list upload formats. ||
|#

## ListUploadFormatsResponse {#yandex.cloud.ai.dataset.v1.ListUploadFormatsResponse}

```json
{
  "formats": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| formats[] | **string**

List of upload formats for the specified dataset task type. ||
|#
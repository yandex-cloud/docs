---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/listUploadSchemas.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.ListUploadSchemas

Lists supported dataset upload formats types and schemas for the specified dataset task type.

## gRPC request

**rpc ListUploadSchemas ([ListUploadSchemasRequest](#yandex.cloud.ai.dataset.v1.ListUploadSchemasRequest)) returns ([ListUploadSchemasResponse](#yandex.cloud.ai.dataset.v1.ListUploadSchemasResponse))**

## ListUploadSchemasRequest {#yandex.cloud.ai.dataset.v1.ListUploadSchemasRequest}

```json
{
  "task_type": "string"
}
```

#|
||Field | Description ||
|| task_type | **string**

Required field. Dataset task type to list schemas. ||
|#

## ListUploadSchemasResponse {#yandex.cloud.ai.dataset.v1.ListUploadSchemasResponse}

```json
{
  "schemas": [
    {
      "task_type": "string",
      "upload_format": "string",
      "schema": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| schemas[] | **[DatasetUploadSchema](#yandex.cloud.ai.dataset.v1.DatasetUploadSchema)**

List of dataset schemas for the specified dataset task type. ||
|#

## DatasetUploadSchema {#yandex.cloud.ai.dataset.v1.DatasetUploadSchema}

#|
||Field | Description ||
|| task_type | **string** ||
|| upload_format | **string** ||
|| schema | **string** ||
|#
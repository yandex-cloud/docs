---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/create.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.Create

Creates dataset.

## gRPC request

**rpc Create ([CreateDatasetRequest](#yandex.cloud.ai.dataset.v1.CreateDatasetRequest)) returns ([CreateDatasetResponse](#yandex.cloud.ai.dataset.v1.CreateDatasetResponse))**

## CreateDatasetRequest {#yandex.cloud.ai.dataset.v1.CreateDatasetRequest}

```json
{
  "name": "string",
  "folder_id": "string",
  "description": "string",
  "metadata": "string",
  "task_type": "string",
  "labels": "map<string, string>",
  "upload_format": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the dataset. ||
|| folder_id | **string**

Required field. Folder ID of the dataset. ||
|| description | **string**

Description of the dataset. Optional. ||
|| metadata | **string**

Metadata of the dataset. Optional. ||
|| task_type | **string**

Required field. Task type of the dataset. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the dataset. Optional. ||
|| upload_format | **string**

Required field. Upload format of the dataset.
The list of supported upload formats can be retrieved via ListUploadFormats method. ||
|#

## CreateDatasetResponse {#yandex.cloud.ai.dataset.v1.CreateDatasetResponse}

```json
{
  "dataset_id": "string",
  "dataset": {
    "dataset_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "metadata": "string",
    "status": "Status",
    "task_type": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "rows": "int64",
    "size_bytes": "int64",
    "created_by_id": "string",
    "labels": "map<string, string>",
    "created_by": "string",
    "updated_by": "string",
    "validation_error": [
      {
        "error": "string",
        "error_description": "string",
        "row_numbers": [
          "int64"
        ]
      }
    ]
  }
}
```

#|
||Field | Description ||
|| dataset_id | **string**

ID of the created dataset. ||
|| dataset | **[DatasetInfo](#yandex.cloud.ai.dataset.v1.DatasetInfo)**

Information about the dataset. ||
|#

## DatasetInfo {#yandex.cloud.ai.dataset.v1.DatasetInfo}

Information about the dataset.

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| folder_id | **string**

Folder ID of the dataset. ||
|| name | **string**

Name of the dataset. ||
|| description | **string**

Description of the dataset. ||
|| metadata | **string**

Metadata of the dataset. ||
|| status | enum **Status**

Status of the dataset.

- `STATUS_UNSPECIFIED`
- `DRAFT`
- `VALIDATING`
- `READY`
- `INVALID`
- `DELETING` ||
|| task_type | **string**

Task type of the dataset. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Create dataset timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update dataset timestamp. ||
|| rows | **int64**

Number of rows in the dataset. ||
|| size_bytes | **int64**

Size of the dataset. ||
|| created_by_id | **string**

Deprecated. Use created_by instead ||
|| labels | **object** (map<**string**, **string**>)

Labels of the dataset ||
|| created_by | **string**

User ID of the dataset's creator. ||
|| updated_by | **string**

User ID of the dataset's last updater. ||
|| validation_error[] | **[ValidationError](#yandex.cloud.ai.dataset.v1.ValidationError)** ||
|#

## ValidationError {#yandex.cloud.ai.dataset.v1.ValidationError}

Information about dataset validation error.

#|
||Field | Description ||
|| error | **string**

Name of the validation error. ||
|| error_description | **string**

Description of the validation error. ||
|| row_numbers[] | **int64**

Row numbers in which the error occurred. ||
|#
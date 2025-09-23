---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/validate.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.Validate

Starts dataset validation process.

## gRPC request

**rpc Validate ([ValidateDatasetRequest](#yandex.cloud.ai.dataset.v1.ValidateDatasetRequest)) returns ([yandex.cloud.operation.Operation](#yandex.cloud.operation.Operation))**

## ValidateDatasetRequest {#yandex.cloud.ai.dataset.v1.ValidateDatasetRequest}

```json
{
  "dataset_id": "string"
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. ID of the dataset to validate. ||
|#

## yandex.cloud.operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "dataset_id": "string",
    "valid_rows": "int64",
    "processed_rows": "int64",
    "total_rows": "int64"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "dataset_id": "string",
    "is_valid": "bool",
    "errors": [
      {
        "error": "string",
        "error_description": "string",
        "row_numbers": [
          "int64"
        ]
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ValidateDatasetMetadata](#yandex.cloud.ai.dataset.v1.ValidateDatasetMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[ValidateDatasetResponse](#yandex.cloud.ai.dataset.v1.ValidateDatasetResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## ValidateDatasetMetadata {#yandex.cloud.ai.dataset.v1.ValidateDatasetMetadata}

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| valid_rows | **int64**

Count of valid rows among currently processed rows in the dataset. ||
|| processed_rows | **int64**

Count of currently processed rows in the dataset. ||
|| total_rows | **int64**

Total count of rows in the dataset ||
|#

## ValidateDatasetResponse {#yandex.cloud.ai.dataset.v1.ValidateDatasetResponse}

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| is_valid | **bool**

Validity marker. ||
|| errors[] | **[ValidationError](#yandex.cloud.ai.dataset.v1.ValidationError)**

A list of the dataset validation errors. ||
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
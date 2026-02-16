---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Project/create.md
---

# Talk Analytics API, gRPC: ProjectService.Create

rpc for creating speechsense project

## gRPC request

**rpc Create ([CreateProjectRequest](#yandex.cloud.speechsense.v1.CreateProjectRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateProjectRequest {#yandex.cloud.speechsense.v1.CreateProjectRequest}

```json
{
  "name": "string",
  "connection_id": "string",
  "description": "string",
  "filters": [
    {
      "key": "string",
      "field_value": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| name | **string**

project name ||
|| connection_id | **string**

id of connection the project should belong too ||
|| description | **string**

project description ||
|| filters[] | **[FieldFilter](#yandex.cloud.speechsense.v1.FieldFilter)**

project filters ||
|#

## FieldFilter {#yandex.cloud.speechsense.v1.FieldFilter}

simple filters to match talks based on their connection metadata

#|
||Field | Description ||
|| key | **string**

connection metadata field key ||
|| field_value | **string**

connection metadata field value ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "connection_id": "string",
    "description": "string",
    "created_by": "string",
    "created_at": "google.protobuf.Timestamp",
    "modified_by": "string",
    "modified_at": "google.protobuf.Timestamp",
    "filters": [
      {
        "key": "string",
        "field_value": "string"
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
|| metadata | **[CreateProjectMetadata](#yandex.cloud.speechsense.v1.CreateProjectMetadata)**

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
|| response | **[Project](#yandex.cloud.speechsense.v1.Project)**

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

## CreateProjectMetadata {#yandex.cloud.speechsense.v1.CreateProjectMetadata}

#|
||Field | Description ||
|| id | **string** ||
|#

## Project {#yandex.cloud.speechsense.v1.Project}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|| connection_id | **string** ||
|| description | **string** ||
|| created_by | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| modified_by | **string** ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| filters[] | **[FieldFilter](#yandex.cloud.speechsense.v1.FieldFilter2)** ||
|#

## FieldFilter {#yandex.cloud.speechsense.v1.FieldFilter2}

simple filters to match talks based on their connection metadata

#|
||Field | Description ||
|| key | **string**

connection metadata field key ||
|| field_value | **string**

connection metadata field value ||
|#
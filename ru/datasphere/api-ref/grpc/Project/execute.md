---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/execute.md
---

# DataSphere API v2, gRPC: ProjectService.Execute

Executes code of the specified notebook using configuration defined in the project settings. If the default project configuration is not specified, `c1.4` is used.

## gRPC request

**rpc Execute ([ProjectExecutionRequest](#yandex.cloud.datasphere.v2.ProjectExecutionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ProjectExecutionRequest {#yandex.cloud.datasphere.v2.ProjectExecutionRequest}

```json
{
  "project_id": "string",
  // Includes only one of the fields `notebook_id`, `cell_id`
  "notebook_id": "string",
  "cell_id": "string",
  // end of the list of possible fields
  "input_variables": "google.protobuf.Struct",
  "output_variable_names": [
    "string"
  ],
  "spec": "string",
  "spark_connector_id": "string"
}
```

#|
||Field | Description ||
|| project_id | **string**

Required field. ID of the project to execute notebook/cell in. ||
|| notebook_id | **string**

The path to the executable notebook in the project storage. The maximum string length is 200 characters.

To get the path, right-click on the notebook in JupyterLab and select `Copy path`.

Includes only one of the fields `notebook_id`, `cell_id`. ||
|| cell_id | **string**

ID of the cell to execute.
Deprecated

Includes only one of the fields `notebook_id`, `cell_id`. ||
|| input_variables | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Values of input variables. Input variables will be available in the project as environment variables. ||
|| output_variable_names[] | **string**

Names of output variables. ||
|| spec | **string**

Specification of the VM ||
|| spark_connector_id | **string**

ID of the Spark Connector ||
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
    "project_id": "string",
    // Includes only one of the fields `notebook_id`, `cell_id`
    "notebook_id": "string",
    "cell_id": "string"
    // end of the list of possible fields
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "execution_status": "ExecutionStatus"
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
|| metadata | **[ProjectExecutionMetadata](#yandex.cloud.datasphere.v2.ProjectExecutionMetadata)**

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
|| response | **[ProjectExecutionResponse](#yandex.cloud.datasphere.v2.ProjectExecutionResponse)**

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

## ProjectExecutionMetadata {#yandex.cloud.datasphere.v2.ProjectExecutionMetadata}

#|
||Field | Description ||
|| project_id | **string**

ID of the project in which notebook is being executed. ||
|| notebook_id | **string**

ID of the notebook that is being executed

Includes only one of the fields `notebook_id`, `cell_id`. ||
|| cell_id | **string**

ID of the cell that is being executed

Includes only one of the fields `notebook_id`, `cell_id`. ||
|#

## ProjectExecutionResponse {#yandex.cloud.datasphere.v2.ProjectExecutionResponse}

#|
||Field | Description ||
|| execution_status | enum **ExecutionStatus**

Execution final status.

- `EXECUTION_STATUS_UNSPECIFIED`
- `OK`: Execution finished successfully.
- `ERROR`: Execution ended with error.
- `ABORTED`: Execution was aborted. ||
|#
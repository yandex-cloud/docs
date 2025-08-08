---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:execute
    method: post
    path:
      type: object
      properties:
        projectId:
          description: |-
            **string**
            Required field. ID of the project to execute notebook/cell in.
          type: string
      required:
        - projectId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        notebookId:
          description: |-
            **string**
            The path to the executable notebook in the project storage. The maximum string length is 200 characters.
            To get the path, right-click on the notebook in JupyterLab and select `Copy path`.
            Includes only one of the fields `notebookId`, `cellId`.
          type: string
        cellId:
          description: |-
            **string**
            ID of the cell to execute.
            Deprecated
            Includes only one of the fields `notebookId`, `cellId`.
          deprecated: true
          type: string
        inputVariables:
          description: |-
            **object**
            Values of input variables. Input variables will be available in the project as environment variables.
          type: object
        outputVariableNames:
          description: |-
            **string**
            Names of output variables.
          type: array
          items:
            type: string
        spec:
          description: |-
            **string**
            Specification of the VM
          type: string
        sparkConnectorId:
          description: |-
            **string**
            ID of the Spark Connector
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/execute.md
---

# DataSphere API v2, REST: Project.Execute

Executes code of the specified notebook using configuration defined in the project settings. If the default project configuration is not specified, `c1.4` is used.

## HTTP request

```
POST https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:execute
```

## Path parameters

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the project to execute notebook/cell in. ||
|#

## Body parameters {#yandex.cloud.datasphere.v2.ProjectExecutionRequest}

```json
{
  // Includes only one of the fields `notebookId`, `cellId`
  "notebookId": "string",
  "cellId": "string",
  // end of the list of possible fields
  "inputVariables": "object",
  "outputVariableNames": [
    "string"
  ],
  "spec": "string",
  "sparkConnectorId": "string"
}
```

#|
||Field | Description ||
|| notebookId | **string**

The path to the executable notebook in the project storage. The maximum string length is 200 characters.

To get the path, right-click on the notebook in JupyterLab and select `Copy path`.

Includes only one of the fields `notebookId`, `cellId`. ||
|| cellId | **string**

ID of the cell to execute.
Deprecated

Includes only one of the fields `notebookId`, `cellId`. ||
|| inputVariables | **object**

Values of input variables. Input variables will be available in the project as environment variables. ||
|| outputVariableNames[] | **string**

Names of output variables. ||
|| spec | **string**

Specification of the VM ||
|| sparkConnectorId | **string**

ID of the Spark Connector ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "projectId": "string",
    // Includes only one of the fields `notebookId`, `cellId`
    "notebookId": "string",
    "cellId": "string"
    // end of the list of possible fields
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "executionStatus": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ProjectExecutionMetadata](#yandex.cloud.datasphere.v2.ProjectExecutionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| projectId | **string**

ID of the project in which notebook is being executed. ||
|| notebookId | **string**

ID of the notebook that is being executed

Includes only one of the fields `notebookId`, `cellId`. ||
|| cellId | **string**

ID of the cell that is being executed

Includes only one of the fields `notebookId`, `cellId`. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## ProjectExecutionResponse {#yandex.cloud.datasphere.v2.ProjectExecutionResponse}

#|
||Field | Description ||
|| executionStatus | **enum** (ExecutionStatus)

Execution final status.

- `EXECUTION_STATUS_UNSPECIFIED`
- `OK`: Execution finished successfully.
- `ERROR`: Execution ended with error.
- `ABORTED`: Execution was aborted. ||
|#
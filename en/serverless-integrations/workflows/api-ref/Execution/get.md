---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/get.md
---

# Workflows Service, REST: Execution.Get

Retrieves specified Workflow execution.

## HTTP request

```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}
```

## Path parameters

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.GetExecutionResponse}

**HTTP Code: 200 - OK**

```json
{
  "execution": {
    "id": "string",
    "workflowId": "string",
    "input": {
      // Includes only one of the fields `inputJson`
      "inputJson": "string"
      // end of the list of possible fields
    },
    "result": {
      // Includes only one of the fields `resultJson`
      "resultJson": "string"
      // end of the list of possible fields
    },
    "error": {
      "message": "string",
      "errorCode": "string"
    },
    "status": "string",
    "startedAt": "string",
    "duration": "string"
  }
}
```

#|
||Field | Description ||
|| execution | **[Execution](#yandex.cloud.serverless.workflows.v1.Execution)**

Workflow execution details. ||
|#

## Execution {#yandex.cloud.serverless.workflows.v1.Execution}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow execution. Generated at creation time. ||
|| workflowId | **string**

ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input data for the Workflow execution. ||
|| result | **[ExecutionResult](#yandex.cloud.serverless.workflows.v1.ExecutionResult)**

Result of the Workflow execution. ||
|| error | **[ExecutionError](#yandex.cloud.serverless.workflows.v1.ExecutionError)**

Error details, in case Workflow execution failed. ||
|| status | **enum** (Status)

Status of the Workflow execution

- `STATUS_UNSPECIFIED`
- `QUEUED`: Workflow execution is being queued.
- `RUNNING`: Workflow execution is running.
- `PAUSED`: Workflow execution is being paused.
- `STOPPED`: Workflow execution is stopped.
- `FAILED`: Workflow execution is failed.
- `FINISHED`: Workflow execution is finished. ||
|| startedAt | **string** (date-time)

Start timestamp for the Workflow execution.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| duration | **string** (duration)

Duration of the Workflow execution. ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`. ||
|#

## ExecutionResult {#yandex.cloud.serverless.workflows.v1.ExecutionResult}

#|
||Field | Description ||
|| resultJson | **string**

JSON result of the Workflow execution.

Includes only one of the fields `resultJson`. ||
|#

## ExecutionError {#yandex.cloud.serverless.workflows.v1.ExecutionError}

#|
||Field | Description ||
|| message | **string**

Error message of the Workflow execution. ||
|| errorCode | **string**

Error code of the Workflow execution. ||
|#
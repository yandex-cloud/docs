---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/getHistory.md
---

# Workflows Service, REST: Execution.GetHistory {#GetHistory}

Retrieves detailed history of specified Workflow execution.

## HTTP request

```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}/history
```

## Path parameters

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.GetExecutionHistoryResponse}

**HTTP Code: 200 - OK**

```json
{
  "execution": {
    "id": "string",
    "workflowId": "string",
    "status": "string",
    "startedAt": "string",
    "duration": "string"
  },
  "entries": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "startedAt": "string",
      "duration": "string",
      "input": {
        // Includes only one of the fields `inputJson`
        "inputJson": "string"
        // end of the list of possible fields
      },
      "output": {
        // Includes only one of the fields `outputJson`
        "outputJson": "string"
        // end of the list of possible fields
      },
      "error": {
        "message": "string",
        "errorCode": "string"
      },
      "status": "string",
      "type": "string",
      "attempts": "string",
      "lastError": {
        "message": "string",
        "errorCode": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| execution | **[ExecutionPreview](#yandex.cloud.serverless.workflows.v1.ExecutionPreview)**

Workflow execution details. ||
|| entries[] | **[HistoryEntry](#yandex.cloud.serverless.workflows.v1.HistoryEntry)**

Workflow execution detailed history items. ||
|#

## ExecutionPreview {#yandex.cloud.serverless.workflows.v1.ExecutionPreview}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow execution. Generated at creation time. ||
|| workflowId | **string**

ID of the Workflow. ||
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

## HistoryEntry {#yandex.cloud.serverless.workflows.v1.HistoryEntry}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow step. ||
|| title | **string**

Title of the Workflow step. ||
|| description | **string**

Description of the Workflow step. ||
|| startedAt | **string** (date-time)

Start timestamp for the Workflow step.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| duration | **string** (duration)

Duration of the Workflow step. ||
|| input | **[HistoryEntryInput](#yandex.cloud.serverless.workflows.v1.HistoryEntryInput)**

Input data for the Workflow step. ||
|| output | **[HistoryEntryOutput](#yandex.cloud.serverless.workflows.v1.HistoryEntryOutput)**

Result of the Workflow step. ||
|| error | **[HistoryEntryError](#yandex.cloud.serverless.workflows.v1.HistoryEntryError)**

Error details, in case Workflow step failed. ||
|| status | **enum** (Status)

Status of the Workflow step.

- `STATUS_UNSPECIFIED`
- `SCHEDULED`: Step execution is being scheduled.
- `STARTED`: Step execution is started.
- `COMPLETED`: Step execution is completed.
- `FAILED`: Step execution is failed.
- `CANCEL_REQUESTED`: Step execution is requested to be cancelled.
- `CANCELLED`: Step execution is canceled. ||
|| type | **string**

Type of the Workflow step (for example, FunctionCall or HttpCall). ||
|| attempts | **string** (int64)

Number of attempts (including all retries of unsuccessful attempts). Value "1" means there were no retries. ||
|| lastError | **[HistoryEntryError](#yandex.cloud.serverless.workflows.v1.HistoryEntryError)**

Last received error details in case of retries. ||
|#

## HistoryEntryInput {#yandex.cloud.serverless.workflows.v1.HistoryEntryInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow step.

Includes only one of the fields `inputJson`. ||
|#

## HistoryEntryOutput {#yandex.cloud.serverless.workflows.v1.HistoryEntryOutput}

#|
||Field | Description ||
|| outputJson | **string**

JSON result for the Workflow step.

Includes only one of the fields `outputJson`. ||
|#

## HistoryEntryError {#yandex.cloud.serverless.workflows.v1.HistoryEntryError}

#|
||Field | Description ||
|| message | **string**

Error message of the Workflow step. ||
|| errorCode | **string**

Error code of the Workflow step. ||
|#
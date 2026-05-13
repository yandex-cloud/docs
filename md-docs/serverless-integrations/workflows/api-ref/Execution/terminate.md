# Workflows Service, REST: Execution.Terminate

Terminates specified Workflow execution.

## HTTP request

```
POST https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/{executionId}/terminate
```

## Path parameters

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.TerminateExecutionResponse}

**HTTP Code: 200 - OK**

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

ID of the Workflow execution. ||
|#
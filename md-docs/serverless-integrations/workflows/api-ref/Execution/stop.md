# Workflows Service, REST: Execution.Stop

Stops specified Workflow execution.

## HTTP request

```
POST https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/{executionId}/stop
```

## Path parameters

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.StopExecutionResponse}

**HTTP Code: 200 - OK**

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#
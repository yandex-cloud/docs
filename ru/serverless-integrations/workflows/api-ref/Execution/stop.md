---
editable: false
apiPlayground:
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}/stop
    method: post
    path:
      type: object
      properties:
        executionId:
          description: |-
            **string**
            Required field. ID of the Workflow execution.
          type: string
      required:
        - executionId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/stop.md
---

# Workflows Service, REST: Execution.Stop

Stops specified Workflow execution.

## HTTP request

```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}/stop
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

ID of the Workflow execution. ||
|#
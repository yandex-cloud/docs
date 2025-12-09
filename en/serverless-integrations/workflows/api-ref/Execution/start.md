---
editable: false
apiPlayground:
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/start
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
        input:
          description: |-
            **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**
            Input for the Workflow execution
          $ref: '#/definitions/ExecutionInput'
      required:
        - workflowId
      additionalProperties: false
    definitions:
      ExecutionInput:
        type: object
        properties:
          inputJson:
            description: |-
              **string**
              JSON input data for the Workflow execution.
              Includes only one of the fields `inputJson`.
            type: string
        oneOf:
          - required:
              - inputJson
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{workflowId}/start
    method: post
    path:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
      required:
        - workflowId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        input:
          description: |-
            **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**
            Input for the Workflow execution
          $ref: '#/definitions/ExecutionInput'
      additionalProperties: false
    definitions:
      ExecutionInput:
        type: object
        properties:
          inputJson:
            description: |-
              **string**
              JSON input data for the Workflow execution.
              Includes only one of the fields `inputJson`.
            type: string
        oneOf:
          - required:
              - inputJson
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/start.md
---

# Workflows Service, REST: Execution.Start

Starts new Workflow execution.

## HTTP request

```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/start
```

## Body parameters {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest}

```json
{
  "workflowId": "string",
  "input": {
    // Includes only one of the fields `inputJson`
    "inputJson": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse}

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

## HTTP request

```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{workflowId}/start
```

## Path parameters

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|#

## Body parameters {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest2}

```json
{
  "input": {
    // Includes only one of the fields `inputJson`
    "inputJson": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput2)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput2}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`. ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse2}

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
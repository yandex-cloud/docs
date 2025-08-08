---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/assistants/v1/runs/submit
    method: patch
    path: null
    query: null
    body:
      type: object
      properties:
        runId:
          description: |-
            **string**
            Required field. ID of the run to submit to.
          type: string
        toolResultList:
          description: |-
            **[ToolResultList](/docs/assistants/api-ref/Run/submit#yandex.cloud.ai.assistants.v1.ToolResultList)**
            A list of tool results to submit to the run, such as the output of a function call.
            Includes only one of the fields `toolResultList`.
            Event to submit to the run.
          $ref: '#/definitions/ToolResultList'
      required:
        - runId
      additionalProperties: false
    definitions:
      ToolResultList:
        type: object
        properties:
          toolResults:
            description: |-
              **[ToolResult](/docs/assistants/api-ref/Run/submit#yandex.cloud.ai.assistants.v1.ToolResult)**
              A list of tool results.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    functionResult:
                      description: |-
                        **[FunctionResult](/docs/assistants/api-ref/Run/submit#yandex.cloud.ai.assistants.v1.FunctionResult)**
                        Represents the result of a function call.
                        Includes only one of the fields `functionResult`.
                      oneOf:
                        - type: object
                          properties:
                            content:
                              description: |-
                                **string**
                                The result of the function call, represented as a string.
                                This field can be used to store the output of the function.
                                Includes only one of the fields `content`.
                              type: string
sourcePath: en/_api-ref/ai/assistants/v1/runs/api-ref/Run/submit.md
---

# Runs, REST: Run.Submit

Submit event to run
For example, submit function call results when the run is waiting for user input.

## HTTP request

```
PATCH https://rest-assistant.{{ api-host }}/assistants/v1/runs/submit
```

## Body parameters {#yandex.cloud.ai.assistants.v1.runs.SubmitToRunRequest}

```json
{
  "runId": "string",
  // Includes only one of the fields `toolResultList`
  "toolResultList": {
    "toolResults": [
      {
        // Includes only one of the fields `functionResult`
        "functionResult": {
          "name": "string",
          // Includes only one of the fields `content`
          "content": "string"
          // end of the list of possible fields
        }
        // end of the list of possible fields
      }
    ]
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| runId | **string**

Required field. ID of the run to submit to. ||
|| toolResultList | **[ToolResultList](#yandex.cloud.ai.assistants.v1.ToolResultList)**

A list of tool results to submit to the run, such as the output of a function call.

Includes only one of the fields `toolResultList`.

Event to submit to the run. ||
|#

## ToolResultList {#yandex.cloud.ai.assistants.v1.ToolResultList}

Represents a list of tool results.

#|
||Field | Description ||
|| toolResults[] | **[ToolResult](#yandex.cloud.ai.assistants.v1.ToolResult)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.assistants.v1.ToolResult}

Represents the result of a tool call.

#|
||Field | Description ||
|| functionResult | **[FunctionResult](#yandex.cloud.ai.assistants.v1.FunctionResult)**

Represents the result of a function call.

Includes only one of the fields `functionResult`. ||
|#

## FunctionResult {#yandex.cloud.ai.assistants.v1.FunctionResult}

Represents the result of a function call.

#|
||Field | Description ||
|| name | **string**

The name of the function that was executed. ||
|| content | **string**

The result of the function call, represented as a string.
This field can be used to store the output of the function.

Includes only one of the fields `content`. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.runs.SubmitToRunResponse}

**HTTP Code: 200 - OK**
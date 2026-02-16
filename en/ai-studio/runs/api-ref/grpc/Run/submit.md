---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/runs/api-ref/grpc/Run/submit.md
---

# Runs, gRPC: RunService.Submit

Submit event to run
For example, submit function call results when the run is waiting for user input.

## gRPC request

**rpc Submit ([SubmitToRunRequest](#yandex.cloud.ai.assistants.v1.runs.SubmitToRunRequest)) returns ([SubmitToRunResponse](#yandex.cloud.ai.assistants.v1.runs.SubmitToRunResponse))**

## SubmitToRunRequest {#yandex.cloud.ai.assistants.v1.runs.SubmitToRunRequest}

```json
{
  "run_id": "string",
  // Includes only one of the fields `tool_result_list`
  "tool_result_list": {
    "tool_results": [
      {
        // Includes only one of the fields `function_result`
        "function_result": {
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
|| run_id | **string**

Required field. ID of the run to submit to. ||
|| tool_result_list | **[ToolResultList](#yandex.cloud.ai.assistants.v1.ToolResultList)**

A list of tool results to submit to the run, such as the output of a function call.

Includes only one of the fields `tool_result_list`.

Event to submit to the run. ||
|#

## ToolResultList {#yandex.cloud.ai.assistants.v1.ToolResultList}

Represents a list of tool results.

#|
||Field | Description ||
|| tool_results[] | **[ToolResult](#yandex.cloud.ai.assistants.v1.ToolResult)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.assistants.v1.ToolResult}

Represents the result of a tool call.

#|
||Field | Description ||
|| function_result | **[FunctionResult](#yandex.cloud.ai.assistants.v1.FunctionResult)**

Represents the result of a function call.

Includes only one of the fields `function_result`. ||
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

## SubmitToRunResponse {#yandex.cloud.ai.assistants.v1.runs.SubmitToRunResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#
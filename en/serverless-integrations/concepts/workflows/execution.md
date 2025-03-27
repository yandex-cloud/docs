---
title: Launching a workflow in {{ sw-full-name }}
description: A workflow launch in {{ sw-name }} contains all information about a specific workflow execution.
keywords:
  - workflows
  - workflow
  - WF
  - Workflow
---

# Launching a workflow

A launch contains all information about a specific execution of a workflow. You can view a list of all launches, as well as detailed information about them, on the **Launches** tab in the management console. Possible launch statuses include: `In queue`, `In progress`, `Paused`, `Canceled`, `Error`, and `Executed`. Learn more about [possible error codes](#errors).

You can launch a workflow using the [management console](#console), [API](#api), or [{{ er-name }}](#eventrouter).

## Management console {#console}

You can launch a workflow by:
* Clicking ![image](../../../_assets/console-icons/ellipsis.svg) → **Launch** in the line with the workflow.
* Selecting a workflow and clicking **Launch** on the **Overview** page.

## API {#api}

You can launch a workflow using the [start](../../workflows/api-ref/Execution/start.md) REST API method for the [Execution](../../workflows/api-ref/Execution/index.md) resource or the [ExecutionService/Start](../../workflows/api-ref/grpc/Execution/start.md) gRPC API call.

## {{ er-name }} {#eventrouter}

You can launch a workflow by specifying it as a target in a rule. The rule defines the events that should trigger a workflow. The event body is provided to the launch as an input parameter.

## Possible error codes {#errors}

Error | Description
--- | ---
`ALL` | Error you can specify in a retry policy for the policy to apply to any error type other than `STEP_INTERNAL`.
`STEP_DATA_LIMIT_EXCEEDED` | Input or output data limit exceeded. For more information, see [{#T}](../limits.md).
`STEP_NO_CHOICE_MATCHED` | There is no suitable execution path in `choices`. For more information, see [{#T}](yawl/management/switch.md).
`STEP_PERMISSION_DENIED` | No access to resource.
`STEP_TIMEOUT` | Step timeout exceeded. For more information, see [{#T}](../limits.md).
`STEP_INVALID_OUTPUT` | Invalid output data.
`STEP_INTERNAL` | Internal error. If a step terminates with this error, you cannot apply the retry policy, and the launch immediately switches to the `Error` status.
`STEP_INVALID_TEMPLATE_EXPRESSION` | Invalid jq expression in template.
`STEP_FAIL` | The launch ended with an error at the `Fail` step. For more information, see [{#T}](yawl/management/fail.md).
`STEP_FAILED_PRECONDITION` | The resource state is invalid to complete the step, e.g., an email address is unverified or blocked.
`STEP_INVALID_ARGUMENT` | Invalid step parameters.
`STEP_QUOTA_EXCEEDED` | The resource request limit is reached.
`HTTP_CALL_400`<br/>`HTTP_CALL_401`<br/>`HTTP_CALL_402`<br/>`HTTP_CALL_403`<br/>`HTTP_CALL_404`<br/>`HTTP_CALL_405`<br/>`HTTP_CALL_406`<br/>`HTTP_CALL_407`<br/>`HTTP_CALL_408`<br/>`HTTP_CALL_409`<br/>`HTTP_CALL_410`<br/>`HTTP_CALL_411`<br/>`HTTP_CALL_412`<br/>`HTTP_CALL_413`<br/>`HTTP_CALL_414`<br/>`HTTP_CALL_415`<br/>`HTTP_CALL_416`<br/>`HTTP_CALL_417`<br/>`HTTP_CALL_418`<br/>`HTTP_CALL_419`<br/>`HTTP_CALL_420`<br/>`HTTP_CALL_421`<br/>`HTTP_CALL_422`<br/>`HTTP_CALL_423`<br/>`HTTP_CALL_424`<br/>`HTTP_CALL_425`<br/>`HTTP_CALL_426`<br/>`HTTP_CALL_427`<br/>`HTTP_CALL_428`<br/>`HTTP_CALL_429`<br/>`HTTP_CALL_431`<br/>`HTTP_CALL_449`<br/>`HTTP_CALL_451`<br/>`HTTP_CALL_499`<br/>`HTTP_CALL_500`<br/>`HTTP_CALL_501`<br/>`HTTP_CALL_505`<br/>`HTTP_CALL_502`<br/>`HTTP_CALL_503`<br/>`HTTP_CALL_504`<br/>`HTTP_CALL_506`<br/>`HTTP_CALL_507`<br/>`HTTP_CALL_508`<br/>`HTTP_CALL_509`<br/>`HTTP_CALL_510`<br/>`HTTP_CALL_511`<br/>`HTTP_CALL_520`<br/>`HTTP_CALL_521`<br/>`HTTP_CALL_522`<br/>`HTTP_CALL_523`<br/>`HTTP_CALL_524`<br/>`HTTP_CALL_525`<br/>`HTTP_CALL_526` | HTTP response state codes. For more information, see [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses).
`GRPC_CALL_CANCELLED`<br/>`GRPC_CALL_DEADLINE_EXCEEDED`<br/>`GRPC_CALL_UNIMPLEMENTED`<br/>`GRPC_CALL_UNAVAILABLE`<br/>`GRPC_CALL_UNKNOWN`<br/>`GRPC_CALL_INTERNAL`<br/>`GRPC_CALL_RESOURCE_EXHAUSTED`<br/>`GRPC_CALL_UNAUTHENTICATED` | gRPC statuses. For more information, see the [gRPC documentation](https://grpc.github.io/grpc/core/md_doc_statuscodes.html).
`GRPC_CALL_INVALID_OPTIONS` | Invalid gRPC call parameters.
`GRPC_CALL_INVALID_REFLECTION_SERVER_RESPONSE` | Unexpected response from gRPC server.
`FUNCTION_CALL_INVALID_RESPONSE` | Invalid function code or format of returned JSON response. For more information, see [{#T}](../../../functions/concepts/function-invoke.md#http-state).
`CONTAINER_CALL_400`<br/>`CONTAINER_CALL_401`<br/>`CONTAINER_CALL_402`<br/>`CONTAINER_CALL_403`<br/>`CONTAINER_CALL_404`<br/>`CONTAINER_CALL_405`<br/>`CONTAINER_CALL_406`<br/>`CONTAINER_CALL_407`<br/>`CONTAINER_CALL_408`<br/>`CONTAINER_CALL_409`<br/>`CONTAINER_CALL_410`<br/>`CONTAINER_CALL_411`<br/>`CONTAINER_CALL_412`<br/>`CONTAINER_CALL_413`<br/>`CONTAINER_CALL_414`<br/>`CONTAINER_CALL_415`<br/>`CONTAINER_CALL_416`<br/>`CONTAINER_CALL_417`<br/>`CONTAINER_CALL_418`<br/>`CONTAINER_CALL_419`<br/>`CONTAINER_CALL_420`<br/>`CONTAINER_CALL_421`<br/>`CONTAINER_CALL_422`<br/>`CONTAINER_CALL_423`<br/>`CONTAINER_CALL_424`<br/>`CONTAINER_CALL_425`<br/>`CONTAINER_CALL_426`<br/>`CONTAINER_CALL_427`<br/>`CONTAINER_CALL_428`<br/>`CONTAINER_CALL_429`<br/>`CONTAINER_CALL_431`<br/>`CONTAINER_CALL_449`<br/>`CONTAINER_CALL_451`<br/>`CONTAINER_CALL_499`<br/>`CONTAINER_CALL_500`<br/>`CONTAINER_CALL_501`<br/>`CONTAINER_CALL_505`<br/>`CONTAINER_CALL_502`<br/>`CONTAINER_CALL_503`<br/>`CONTAINER_CALL_504`<br/>`CONTAINER_CALL_506`<br/>`CONTAINER_CALL_507`<br/>`CONTAINER_CALL_508`<br/>`CONTAINER_CALL_509`<br/>`CONTAINER_CALL_510`<br/>`CONTAINER_CALL_511`<br/>`CONTAINER_CALL_520`<br/>`CONTAINER_CALL_521`<br/>`CONTAINER_CALL_522`<br/>`CONTAINER_CALL_523`<br/>`CONTAINER_CALL_524`<br/>`CONTAINER_CALL_525`<br/>`CONTAINER_CALL_526` | HTTP response state codes. For more information, see [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses).
`YDB_CALL_SERVICE_UNAVAILABLE` | Temporary failure on the server side.

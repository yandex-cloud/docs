The `name` label is for the metric name.

## {{ mcp-hub-name }} metrics {#mcp-hub}

Labels shared by all metrics of the {{ ai-studio-name }} [{{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index) feature:

Label | Value
----|----
service | Service ID: `serverless-mcp-gateway`
mcp_gateway_id | [MCP server]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index#servers) ID


Service metrics:

#|
|| **Name**
**Type, units** |
**Description**
**Labels**
||
|| `requests_completed_per_second`
`DGAUGE`, requests per second |
Number of completed requests to the MCP server per second.
Labels:
* _request_text_: Type of your request.
* _error_code_: Error, if any. ||
|| `requests_received_per_second`
`DGAUGE`, requests per second |
Number of requests to the MCP server per second.
Label:
* _request_text_: Type of your request. ||
|| `sessions_active_count`
`DGAUGE`, count |
Number of open sessions with the MCP server. ||
|| `sessions_closed_per_second`
`DGAUGE`, requests per second |
Number of session closures with the MCP server per second. ||
|| `sessions_duration_milliseconds`
`IGAUGE`, milliseconds |
Session duration with the MCP server.
Label:
* _bin_: Histogram buckets. ||
|| `sessions_init_requests_per_second`
`DGAUGE`, requests per second |
Number of session initialization requests to the MCP server per second.
Label:
* _error_code_: Error, if any. ||
|| `tool_call_duration_milliseconds`
`IGAUGE`, milliseconds |
Execution duration of a request to the MCP server's tool.
Label:
* _bin_: Histogram buckets. ||
|#

## {{ sw-full-name }} metrics {#workflows}

All {{ sw-name }} metrics share the `workflow` label, which is the workflow ID.

Metric name<br>Type, units | Description<br>Labels
--- | ---
`step_completed_per_second`<br>`DGAUGE`, steps per second | Number of completed steps per second.<br>This metric features the `step` label containing the step name.
`step_failed_per_second`<br>`DGAUGE`, steps per second | Number of failed steps per second.<br>Labels:<ul><li>`step`: Step name</li><li>`error_code`: Error code.</li></ul>
`step_inflight_count`<br>`DGAUGE`, steps | Number of steps currently in progress.<br>This metric features the `step` label containing the step name.
`step_started_per_second`<br>`DGAUGE`, steps/s | Number of started steps per second.<br>This metric features the `step` label containing the step name.
`step_time_milliseconds`<br>`DGAUGE`, milliseconds | Step execution time.<br>Labels:<ul><li>`bin`: Histogram buckets.</li><li>`step`: Step name</li></ul>
`step_time_milliseconds_count`<br>`DGAUGE`, number of steps | Total number of step time measurements.<br>This metric features the `step` label containing the step name.
`step_time_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total execution time for all steps.<br>This metric features the `step` label containing the step name.
`workflow_completed_per_second`<br>`DGAUGE`, workflows per second | Number of completed workflows per second.
`workflow_failed_per_second`<br>`DGAUGE`, workflows per second | Number of failed workflows per second.<br>This metric features the `error_code` label containing the error code.
`workflow_inflight_count`<br>`DGAUGE`, workflows | Number of workflows currently in progress.
`workflow_scheduled_per_second`<br>`DGAUGE`, workflows per second | Number of scheduled workflows per second.
`workflow_started_per_second`<br>`DGAUGE`, workflows per second | Number of started workflows per second.
`workflow_time_milliseconds`<br>`DGAUGE`, milliseconds | Execution time per workflow.<br>This metric features the `bin` label containing histogram buckets.
`workflow_time_milliseconds_count`<br>`DGAUGE`, count | Total number of workflow time measurements.
`workflow_time_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total execution time for all workflows.

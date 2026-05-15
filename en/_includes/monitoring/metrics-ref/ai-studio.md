The `name` label is for the metric name.

Labels shared by all metrics of the {{ ai-studio-name }} [{{ mcp-hub-name }}]({{ link-docs-ai }}/ai-studio/concepts/mcp-hub/index) feature:

Label | Value
----|----
service | Service ID: `serverless-mcp-gateway`
mcp_gateway_id | [MCP server]({{ link-docs-ai }}/ai-studio/concepts/mcp-hub/index#servers) ID


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
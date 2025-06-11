The `name` label is for the metric name.


## {{ sw-full-name }} metrics {#workflows}

All {{ sw-name }} metrics share the `workflow` label, which is the workflow ID.

Metric name<br>Type, units | Description<br>Labels
--- | ---
`step_completed_per_second`<br>`DGAUGE`, steps per second | Number of completed steps per second.<br>This metric features the `step` label containing the step name.
`step_failed_per_second`<br>`DGAUGE`, steps per second | Number of failed steps per second.<br>Labels:<ul><li>`step`: Step name</li><li>`error_code`: Error code.</li></ul>
`step_inflight_count`<br>`DGAUGE`, steps | Number of steps currently in progress.<br>This metric features the `step` label containing the step name.
`step_started_per_second`<br>`DGAUGE`, steps per second | Number of started steps per second.<br>This metric features the `step` label containing the step name.
`step_time_milliseconds`<br>`DGAUGE`, milliseconds | Step execution time.<br>Labels:<ul><li>`bin`: Histogram buckets.</li><li>`step`: Step name</li></ul>
`step_time_milliseconds_count`<br>`DGAUGE`, number of steps | Total number of step time measurements.<br>This metric features the `step` label containing the step name.
`step_time_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total execution time for all steps.<br>This metric features the `step` label containing the step name.
`workflow_completed_per_second`<br>`DGAUGE`, workflows per second | Number of completed workflows per second
`workflow_failed_per_second`<br>`DGAUGE`, workflows per second | Number of failed workflows per second.<br>This metric features the `error_code` label containing the error code.
`workflow_inflight_count`<br>`DGAUGE`, workflows | Number of workflows currently in progress
`workflow_scheduled_per_second`<br>`DGAUGE`, workflows per second | Number of scheduled workflows per second
`workflow_started_per_second`<br>`DGAUGE`, workflows per second | Number of started workflows per second
`workflow_time_milliseconds`<br>`DGAUGE`, milliseconds | Execution time per workflow.<br>This metric features the `bin` label containing histogram buckets.
`workflow_time_milliseconds_count`<br>`DGAUGE`, count | Total number of workflow time measurements.
`workflow_time_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total execution time for all workflows.


## {{ er-full-name }} metrics {#eventrouter}

All {{ er-name }} metrics share the `bus` label, which is the [bus](../../../serverless-integrations/concepts/eventrouter/bus.md) ID.


### Bus metrics {#er-buses}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`serverless_eventrouter_bus_put_event_per_second`<br>`DGAUGE`, messages per second | Frequency of messages sent using the [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call.
`serverless_eventrouter_bus_sent_error_per_second`<br>`DGAUGE`, errors per second | Frequency of bus errors.<br>Labels:<ul><li>`code`: Error code. The possible values are:<ul><li>`EVENTROUTER_BUS_SEND_ERROR`</li><li>`EVENTROUTER_EVENT_SIZE_EXCEEDED`</li></ul></li><li>`source`: Source</li></ul>
`serverless_eventrouter_put_event_latency_milliseconds`<br>`DGAUGE`, milliseconds | Time from receiving a message sent using the [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call until it is written to the bus.


### Connector metrics {#er-connectors}

All [connector](../../../serverless-integrations/concepts/eventrouter/connector.md) metrics share the `connector` label, which is the connector ID.


Metric name<br>Type, units | Description
--- | ---
`serverless_eventrouter_connector_access_error_per_second`<br>`DGAUGE`, errors per second | Frequency of connector resource access errors
`serverless_eventrouter_connector_error_per_second`<br>`DGAUGE`, errors per second | Frequency of connector errors
`serverless_eventrouter_connector_event_per_second`<br>`DGAUGE`, events per second | Connector's event read rate
`serverless_eventrouter_connector_event_size_exceeded_per_second`<br>`DGAUGE`, errors per second | Frequency of maximum size exceeded errors in messages received by the connector


### Rule metrics {#er-rules}

All [rule](../../../serverless-integrations/concepts/eventrouter/rule.md) metrics share the following labels:

Label | Value
--- | ---
matched | Matching the [filter](../../../serverless-integrations/concepts/eventrouter/rule.md#filter) conditions
rule | Rule ID

Metric name<br>Type, units | Description
--- | ---
`serverless_eventrouter_rule_event_per_second`<br>`DGAUGE`, events per second | Rule processing rate


### Target metrics {#er-targets}

All [target](../../../serverless-integrations/concepts/eventrouter/rule.md#target) metrics share the following labels:

Label | Value
--- | ---
rule | Rule ID
type | Target type

Metric name<br>Type, units | Description
--- | ---
`serverless_eventrouter_event_delivery_time_milliseconds`<br>`DGAUGE`, milliseconds | Time from event receipt by the connector to its delivery to the target
`serverless_eventrouter_target_access_error_per_second`<br>`DGAUGE`, errors per second | Frequency of access errors in the target
`serverless_eventrouter_target_error_per_second`<br>`DGAUGE`, errors per second | Frequency of target errors
`serverless_eventrouter_target_event_size_exceeded_per_second`<br>`DGAUGE`, errors per second | Frequency of maximum size exceeded errors in messages received by the target
`serverless_eventrouter_target_execution_time_milliseconds`<br>`DGAUGE`, milliseconds | Message processing time
`serverless_eventrouter_target_inflight`<br>`DGAUGE`, count | Number of targets that are currently busy
`serverless_eventrouter_target_retry_per_second`<br>`DGAUGE`, sends per second | Frequency of retry attempts to send messages to the target
`serverless_eventrouter_target_throttled_per_second`<br>`DGAUGE`, messages per second | Frequency of messages not processed due to exceeding a [quota or limit](../../../serverless-integrations/concepts/limits.md#event-router)
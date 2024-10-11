# Node metric reference

This section describes metrics delivered to [{{ monitoring-name }}](../../../monitoring/). In addition to the metrics described, nodes can supply metrics to {{ monitoring-name }} specified by the user at the node creation stage.

The described metrics reflect the resource state of services deployed in {{ ml-platform-name }} [nodes](./index.md#node).

The name of the metric is written in the `name` label.

All {{ ml-platform-name }} metrics share the `service=datasphere` label.


## System metrics {#system}

System metrics are supplied with the {{ yandex-cloud }} proxy and describe requests to {{ monitoring-name }}.

All system metrics have the `node_path` label: node endpoint.


### Node system metrics {#node}

All node system metrics have the `node_id` label: node ID.

Metric name<br/>Type, units | Description<br/>Labels
--- | ---
`node_requests`<br/>`RATE`, requests/s | Frequency of requests to the node.
`node_grpc_codes`<br/>`RATE`, requests/s | Frequency of requests to the node by gRPC response codes.<br/>`code` label: gRPC response code.
`node_http_codes`<br/>`RATE`, requests/s | Frequency of requests to the node by HTTP response codes.<br/>`code` label: HTTP response code.
`node_request_durations`<br/>`RATE`, seconds | Response time distribution histogram for requests to the node.


### System metrics of aliases {#alias}

All alias system metrics are labeled `alias_name`: [alias](./index.md#alias) name.

Metric name<br/>Type, units | Description<br/>Labels
--- | ---
`alias_requests`<br/>`RATE`, requests/s | Frequency of requests to the node.
`alias_grpc_codes`<br/>`RATE`, requests/s | Frequency of requests to an alias by gRPC response codes.<br/>`code` label: gRPC response code.
`alias_http_codes`<br/>`RATE`, requests/s | Frequency of requests to an alias by HTTP response codes.<br/>`code` label: HTTP response code.
`alias_request_durations`<br/>`RATE`, seconds | Response time distribution histogram.


## Triton metrics {#triton}

For more information on Triton metrics, see the manufacturer [documentation](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/user_guide/metrics.html).


### Inference metrics {#inference}

Common labels for all inference metrics:

Label | Data
--- | ---
model | Model name.
version | Model version.

Metric name<br/>Type, units | Description
--- | ---
`nv_inference_request_success`<br/>`RATE`, requests/s | Frequency of successful inference requests.
`nv_inference_request_failure`<br/>`RATE`, requests/s | Frequency of failed inference requests.
`nv_inference_count`<br/>`RATE`, requests/s | Frequency of inferencing.
`nv_inference_exec_count`<br/>`RATE`, requests/s | Frequency of calculations for inferences.
`nv_inference_pending_request_count`<br/>`DGAUGE`, requests | Number of pending inference requests.


### Latency metrics {#latencies}

Common labels for all latency metrics:

Label | Data
--- | ---
model | Model name.
version | Model version.

Metric name<br/>Type, units | Description
--- | ---
`nv_inference_request_duration_us`<br/>`RATE`, ms | Average duration of an inference request.
`nv_inference_queue_duration_us`<br/>`RATE`, ms | Average waiting time in a queue to perform inference.
`nv_inference_compute_input_duration_us`<br/>`RATE`, ms | Average processing time of input data for an inference.
`nv_inference_compute_infer_duration_us`<br/>`RATE`, ms | Average duration of computation for an inference.
`nv_inference_compute_output_duration_us`<br/>`RATE`, ms | Average processing time of output data for an inference.


### Summary metrics {#summaries}

Metric name<br/>Type, units | Description<br/>Labels
--- | ---
`nv_inference_request_summary_us`<br/>`RATE`, microseconds | Total time to process inference requests from beginning to end (including cached requests).
`nv_inference_queue_summary_us`<br/>`RATE`, microseconds | Total time requests spent in the execution queue (includes cached requests).
`nv_inference_compute_input_summary_us`<br/>`RATE`, microseconds | Total time to process input data for inference requests (in the framework backend, does not include cached requests).
`nv_inference_compute_infer_summary_us`<br/>`RATE`, microseconds | Total runtime of inference model for requests (in the framework backend, does not include cached requests).
`nv_inference_compute_output_summary_us`<br/>`RATE`, microseconds | Total time to process output data for inference requests (in the framework backend, does not include cached requests).


### GPU metrics {#gpu}

Metric name<br/>Type, units | Description<br/>Labels
--- | ---
`nv_gpu_power_usage`<br/>`DGAUGE`, watts | Instant GPU power consumption.
`nv_gpu_power_limit`<br/>`DGAUGE`, watts | Maximum GPU power limit.
`nv_energy_consumption`<br/>`DGAUGE`, joules | GPU power consumption since Triton launch.
`nv_gpu_utilization`<br/>`DGAUGE` | GPU usage level (`[0.0 - 1.0]`).
`nv_gpu_memory_total_bytes`<br/>`DGAUGE`, bytes | Total GPU memory size.
`nv_gpu_memory_used_bytes`<br/>`DGAUGE`, bytes | Used GPU memory size.


### CPU metrics {#cpu}

Metric name<br/>Type, units | Description
--- | ---
`nv_cpu_utilization`<br/>`DGAUGE` | CPU load level (`[0.0 - 1.0]`).
`nv_cpu_memory_total_bytes`<br/>`DGAUGE`, bytes | Total CPU memory size.
`nv_cpu_memory_used_bytes`<br/>`DGAUGE`, bytes | CPU memory size in use.


### Pinned memory metrics {#pinned-memory}

Metric name<br/>Type, units | Description<br/>Labels
--- | ---
`nv_pinned_memory_pool_total_bytes`<br/>`DGAUGE`, bytes | Total pinned memory size for all models.
`nv_pinned_memory_pool_used_bytes`<br/>`DGAUGE`, bytes | Used pinned memory size for all models.


### Response cache metrics {#response-cache}

Metric name<br/>Type, units | Description
--- | ---
`nv_cache_num_hits_per_model`<br/>`COUNTER`, number | Number of cached responses for each model.
`nv_cache_num_misses_per_model`<br/>`COUNTER`, number | Number of missed responses in cache for each model.
`nv_cache_hit_duration_per_model`<br/>`GAUGE`, microseconds | Total time spent to get a cached response from cache for each model.
`nv_cache_miss_duration_per_model`<br/>`GAUGE`, microseconds | Total time spent searching and inserting responses into cache on cache failure for each model.

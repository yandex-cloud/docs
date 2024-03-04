# Health checks and monitoring

You can enable health checks for your [node instances](index.md#node): the [balancer](../../../application-load-balancer/concepts/application-load-balancer.md) will send check requests to endpoints at certain intervals and wait for a response for a certain period of time.

Checks can be implemented using HTTP or gRPC. The protocol must match the check implementation inside the node container.

The following health check settings are supported:

* Timeout: Response waiting time.
* Interval: Time interval between health check requests.
* Resource health indicators: Successful or failed result thresholds. If a threshold is exceeded, the check passed or failed, respectively.
* HTTP health check settings:
   * Path in the URI of request to the endpoint.
* Settings of gRPC health checks:
   * Name of the service checked.

## Monitoring {#monitoring}

Nodes supply monitoring metrics to the [{{ monitoring-full-name }}](../../../monitoring/) service directory specified in the node settings. By default, the platform collects the following metrics:

* For nodes:

   * `node_requests`: Frequency of requests to node, requests per second.
   * `node_grpc_codes`: Frequency of response codes for gRPC endpoints, codes per second for each code.
   * `node_http_codes`: Frequency of response codes for HTTP endpoints, codes per second for each code.
   * `node_requests_durations`: Request execution time histogram, in milliseconds.

* For [aliases](index.md#alias):

   * `alias_requests`: Frequency of requests to an alias, requests per second.
   * `alias_grpc_codes`: Frequency of response codes for gRPC endpoints, codes per second for each code.
   * `alias_http_codes`: Frequency of response codes for HTTP endpoints, codes per second for each code.
   * `alias_requests_durations`: Request execution time histogram, in milliseconds.

Node and alias metrics contain additional labels:

* `node_id`: Node ID
* `node_path`: Path in the URI of request to the endpoint
* `alias_name`: Alias name

You can get standard metrics using requests in {{ monitoring-name }} or from the {{ ml-platform-name }} service dashboards on the node and alias pages.

Additionally, for nodes, you can enable export of any metrics to {{ monitoring-name }}. The platform will poll all node instances over HTTP and collect custom metrics every now and then. The charts will also be available in the {{ monitoring-name }} directory specified in the node settings.

The following settings are supported for collecting monitoring metrics:

* Format: [Prometheus](https://prometheus.io/docs/instrumenting/exposition_formats/#text-based-format) text format or {{ monitoring-name }} format
* HTTP path: GET request path
* Port: Container port for HTTP requests

The following labels are automatically added to all metrics:

* `node_id`: Node ID
* `instance_id`: Node instance ID

# Monitoring charts

{% note info %}

For **{{ ui-key.yacloud.alb.label_listener-type-stream }}** listeners, the system does not collect statistics on individual HTTP requests.

{% endnote %}

Monitoring charts give the real-time status of your [load balancer](./application-load-balancer.md) and related metrics. Use them for anomaly detection and performance analysis. Load balancer statistics are automatically logged in the [{{ monitoring-full-name }}](../../monitoring/) metrics. For a full list of metrics delivered to {{ monitoring-full-name }}, see the [reference](../metrics.md).

## HTTP statistics {#http-stats}

HTTP charts show traffic intensity, [backend](./backend-group.md) response stability, and request processing times. Use them to identify load anomalies, rising error rates, and performance degradation.

### RPS {#rps}

RPS (Requests Per Second): Number of HTTP requests to the load balancer per second. The chart reflects the intensity of incoming traffic. Review the chart at regular intervals to understand the load balancer's average workload at different days and times. The average value will help you detect anomalies early.

  * A spike in RPS may indicate increased user activity or a DDoS attack. Compare this with the 4xx or 5xx error charts: if there are no errors, the traffic is more likely legitimate than not. However, if there are errors, your backends may be overwhelmed or under a DDoS attack.
  * A sharp drop in RPS during normally active periods could mean your load balancer has become unreachable. Check its condition, availability zones, and DNS records.

### 5xx {#5xx}

5xx (Server Errors): Number of 5xx responses returned by backends through the load balancer. This is the key indicator of your server side stability.

  * A spike in 5xx errors may indicate that backends are overwhelmed due to infrastructure issues. To track down the issue, inspect backend logs.
  * A gradual increase in 5xx errors may indicate memory leaks or resource degradation on backends. Health-check your infrastructure and consider restarting your instances.

### 4xx {#4xx}

4xx (Client Errors): Number of 4xx responses. 

  * 4xx errors typically rise due to user errors, invalid API calls, or authentication issues. Look up request logs, check whether your access tokens are current.

### Latency {#latency}

Latency: Time from when the load balancer receives the first byte of the request to when it sends the last byte of the response. The chart displays values from the 50th to the 99th percentile.

  * Correlate latency with RPS, 5xx errors, and backend resource metrics to find out why latency increases.

### Request size {#request-size}

Request size: Total volume of load balancer requests per second. Use it to assess network load and the impact of large requests.

  * A spike in request size at the same RPS will increase _bytes per second_. Check your network bandwidth and compression settings.

### Response size {#response-size}

Response size: Total volume of load balancer responses per second.

  * Growing response size impacts latency and increases network load. Review your compression and caching settings or change response format.

## Scaling statistics {#scaling-stats}

Scaling charts illustrate the behavior of connections and the volume of processed data. Use them to configure [autoscaling](./application-load-balancer.md#lcu-scaling) and analyze [resource unit](./application-load-balancer.md#lcu-scaling) utilization.

### Active connections {#active-connections}

Active connections: Number of active connections.

  * A spike may indicate more user sessions, long-lived connections, or issues with termination of connections. Compare with _requests per second_: many active connections at low RPS suggests stalled connections.

### Connections per second {#connections-ps}

Connections per second: Number of new connections per second.

  * A high value at stable RPS means clients are not reusing connections or are frequently reconnecting. Peak _connections per second_ rates strain the infrastructure and may require additional resource units.

### Requests per second {#requests-ps}

Requests per second: Number of requests to the load balancer per second.

  * Use this metric to calculate required resource units and set up autoscaling thresholds.

### Bytes per second {#bytes-ps}

Bytes per second: Total volume of requests and responses processed by the load balancer per second.

  * A rise in _bytes per second_ at the same RPS indicates that the average size of requests or responses is increasing. Keep an eye on this metric for network capacity planning.

{% note tip %}

To detect infrastructure failures early, create a dashboard that consolidates your most critical metrics: RPS, 99th-percentile latency, and 5xx error rate.

{% endnote %}

#### See also {#see-also}

* [{#T}](./monitoring.md)
* [{#T}](../operations/application-load-balancer-manage-alerts.md)
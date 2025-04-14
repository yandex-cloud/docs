# Collecting and exporting metrics

#### How do I add a VM RAM metric? {#add-metrics-ram}

{{ compute-full-name }} cannot measure the guest operating system vRAM consumption. In fact, the service sees the VM memory consumption as a constant: the amount of RAM allocated to it at start up.

You can configure the collection of custom metrics [via the API](../../monitoring/operations/metric/add.md) or using a [system metrics delivery agent](../../monitoring/operations/unified-agent/linux_metrics.md) for Linux operating systems. The latter allows you to collect statistics for CPU, RAM, network, and disk usage.

#### How do I add a VM disk space metric? {#add-metrics-space}

There is no such metric because {{ monitoring-name }} cannot access guest operating systems.

You can configure the collection of custom metrics [via the API](../../monitoring/operations/metric/add.md) or using a [system metrics delivery agent](../../monitoring/operations/unified-agent/linux_metrics.md). The latter allows you to collect statistics for CPU, RAM, network, and disk usage.

#### How do I collect custom metrics from my app? {#collect-1st-party}

[{{ unified-agent-full-name }}](../../monitoring/operations/unified-agent/pull_prometheus.md) supports metric collection in the {{ prometheus-name }} format and metric conversion to the {{ monitoring-name }} format. That means you can use {{ unified-agent-short-name }} to collect metrics from any application supporting {{ prometheus-name }} format.

Use a [client library](https://prometheus.io/docs/instrumenting/clientlibs/) for your application programming language to send metrics to {{ monitoring-name }}.

{% list tabs group=programming_language %}

- Go {#go}

  [Prometheus client library for Go](https://github.com/prometheus/client_golang).

- Python {#python}

  [Prometheus client library for Python](https://github.com/prometheus/client_python).

- PHP {#php}

  [Prometheus client library for PHP](https://github.com/promphp/prometheus_client_php).

- Java {#java}

  [Prometheus client library for Java](https://github.com/prometheus/client_java).

- Node.js {#node}

  [Prometheus client library for Node.js](https://github.com/siimon/prom-client).

- C++ {#cpp}

  [Prometheus client library for C++](https://github.com/jupp0r/prometheus-cpp).

{% endlist %}

You can see examples in the following sections of our guides:
* [{#T}](../../monitoring/operations/unified-agent/pull_prometheus.md)
* [{#T}](../../monitoring/operations/unified-agent/haproxy.md)

#### Can I deliver {{ managed-k8s-full-name }} cluster metrics to {{ monitoring-name }}? {#collect-k8s}

Yes, you can by using [Metrics Provider](/marketplace/products/yc/metric-provider). To install it, [follow this guide](../../managed-kubernetes/operations/applications/metrics-provider.md).

#### How do I deliver third-party app metrics to {{ monitoring-name }}? {#collect-3rd-party}

To deliver metrics from third-party applications to {{ monitoring-name }}, use {{ unified-agent-short-name }} with the `metrics_pull` input configured. {{ unified-agent-short-name }} periodically polls the third-party application directly (if the application supports metrics in the {{ prometheus-name }} format) or polls a special export application that manages the integration with {{ prometheus-name }}.

You can find an example of how to configure HAProxy metrics delivery in [{#T}](../../monitoring/operations/unified-agent/haproxy.md).

#### How do I deliver metrics from hosts outside {{ yandex-cloud }}? {#collect-external}

Configure [service account authorized keys](../../monitoring/operations/unified-agent/non-yc.md) to deliver metrics to {{ monitoring-name }} through {{ unified-agent-short-name }}.

You can also use this method to send metrics from {{ yandex-cloud }} VMs without a linked service account.

#### How can I see a list of metrics? {#metrics-list}

To do this, open **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** and select the service you need.

To get a complete list of metrics for a specific cloud and folder, follow [this API request guide](../../monitoring/operations/metric/list.md).

#### Can I export metrics in {{ prometheus-name }} format? {#export-prometheus}

To export metrics in {{ prometheus-name }} format, use the [prometheusMetrics](../../monitoring/api-ref/MetricsData/prometheusMetrics.md) method.

See a metric export setup example [here](../../monitoring/operations/metric/prometheusExport.md).
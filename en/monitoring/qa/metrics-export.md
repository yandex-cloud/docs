# Metric collection and export

#### How do I add a VM's RAM metric? {#add-metrics-ram}

{{ compute-full-name }} can't measure vRAM consumption inside the guest operating system because for the service, memory consumption by the VM is always the same: whatever's allocated the moment it's started.

You can configure collecting custom metrics yourself [via the API](../operations/metric/add.md), and for Linux-compatible operating systems using the [agent for delivering system metrics](../operations/unified-agent/linux_metrics.md). The agent lets you collect statistics on the use of most system resources: CPU, RAM, network, and disk.

#### How do I add a VM's disk space metric? {#add-metrics-space}

{{ monitoring-name }} can't access guest operating systems, so there is no such metric.

You can configure collecting custom metrics yourself [via the API](../operations/metric/add.md), and for Linux-compatible operating systems using the [Agent for delivering system metrics](../operations/unified-agent/linux_metrics.md). The agent lets you collect statistics on the use of most system resources: CPU, RAM, network, and disk.

#### I want to collect custom metrics from my app {#collect-1st-party}

[{{ unified-agent-full-name }}](../operations/unified-agent/pull_prometheus.md) supports collecting metrics in {{ prometheus-name }} format and their conversion to {{ monitoring-name }} format. That means you can use {{unified-agent-short-name}} to collect metrics from any application that provides them in the {{ prometheus-name }} format.

Use a [client library](https://prometheus.io/docs/instrumenting/clientlibs/) for the programming language your application is written in and deliver metrics to {{ monitoring-name }} in {{ prometheus-name }} format.

{% list tabs %}

- Go

  [Prometheus client library for Go](https://github.com/prometheus/client_golang)

- Python

  [Prometheus client library for Python](https://github.com/prometheus/client_python)

- PHP

  [Prometheus client library for PHP](https://github.com/promphp/prometheus_client_php)

- Java

  [Prometheus client library for Java](https://github.com/prometheus/client_java)

- Node.js

  [Prometheus client library for Node.js](https://github.com/siimon/prom-client)

- C++

  [Prometheus client library for C++](https://github.com/jupp0r/prometheus-cpp)

{% endlist %}

See examples in the following sections of the documentation:
* [Delivering custom application metrics](../operations/unified-agent/pull_prometheus.md).
* [Delivering metrics from HAProxy](../operations/unified-agent/haproxy.md).

#### How do I deliver third-party app metrics to {{ monitoring-name }}? {#collect-3rd-party}

To deliver metrics from third-party applications to {{ monitoring-name }}, use {{ unified-agent-full-name }} with the `metrics_pull` input configured. That input periodically polls the third-party application directly (if the application supports metrics in the {{ prometheus-name }} format) or polls a special export application that integrates with {{ prometheus-name }}.

You can find an example for how to configure delivery of HAProxy metrics in [{#T}](../operations/unified-agent/haproxy.md).

#### Delivering metrics from hosts outside {{ yandex-cloud }} {#collect-external}

Configure [authorized keys of service accounts](../operations/unified-agent/non-yc.md) to deliver metrics to {{ monitoring-name }} through {{ unified-agent-full-name }}.

You can also use this method to send metrics from {{ yandex-cloud }} VMs without a linked service account.

#### How do I view a list of metrics? {#metrics-list}

To do this, open **Metric Explorer** and select the desired service.

To get a complete list of metrics belonging to a specific cloud and folder, follow the [instructions on how to make API requests](../operations/metric/list.md).

#### Can I export metrics in {{ prometheus-name }} format? {#export-prometheus}

To export metrics in {{ prometheus-name }} format, use the [prometheusMetrics](../api-ref/MetricsData/prometheusMetrics.md) method.

See an example of how to set up metric export in the [documentation](../operations/metric/prometheusExport.md).
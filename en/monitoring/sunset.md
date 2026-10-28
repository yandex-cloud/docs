---
title: Discontinuation of {{ monitoring-full-name }}
description: '{{ monitoring-name }} has been discontinued. Learn how to continue working with metrics in {{ monium-name }} and use the features of a unified observability platform.'
---

# Discontinuation of {{ monitoring-full-name }}

{% note warning %}

{{ monitoring-full-name }} has been discontinued. All its features and metrics are available in [{{ monium-name }}]({{ link-monium }}).

{% endnote %}

## Accessing your metrics {#data}

{{ yandex-cloud }} resource metrics and custom metrics uploaded to {{ monitoring-name }} via the API are available in {{ monium-name }}. You do not need to migrate them manually.

{{ yandex-cloud }} resource metrics are sent automatically. To work with them, follow [{#T}](../monium/metrics/quickstart.md). To upload custom metrics, follow [{#T}](../monium/metrics/quickstart-app.md).

## Continuing your work in {{ monium-name }} {#migration}

To find your metrics:

1. Open [{{ monium-name }}]({{ link-monium }}).
1. Select the project of the folder containing your resources or custom metrics.
1. Find metrics by their labels in the [metrics explorer](../monium/metrics/metric-explorer.md). [Service dashboards](../monium/visualization/index.md#service-dashboards) are also available for resource metrics.

## New features {#features}

[{{ monium-full-name }}](../monium/) brings metrics, logs, and traces together in a unified observability platform to diagnose failures and investigate incidents. It offers the following features:

* [Logs](../monium/logs/logs-explorer.md): Search and analyze events and [calculate log-based metrics](../monium/logs/aggregates.md).
* [Traces](../monium/traces/index.md): Analyze request paths and operation durations in distributed applications and [navigate to related logs](../monium/traces/operations/traces-logs.md).
* [SLO](../monium/slo/index.md): Track the target service quality level.
* [Telemetry collection with OpenTelemetry](../monium/collector/opentelemetry.md): Send metrics, logs, and traces from your applications and infrastructure.

For more information, see [{#T}](../monium/overview.md).

## Further questions {#support}

If you need assistance, contact [support]({{ link-console-support }}) or your account manager.

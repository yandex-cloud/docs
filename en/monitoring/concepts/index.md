---
title: '{{ monitoring-full-name }}. Overview'
description: The {{ monitoring-full-name }} service lets you collect and store metrics and display them as charts on dashboards. {{ monitoring-full-name }} automatically collects data on the status of your resources in {{ yandex-cloud }} and displays it on service dashboards. You can use the API to upload custom metrics.
---

# {{ monitoring-name }} overview

{{ monitoring-name }} lets you collect and store metrics and display them as charts on dashboards.

{{ monitoring-name }} automatically collects data on the status of your resources in {{ yandex-cloud }} and displays them on service dashboards. You can use the API to upload custom metrics.

Use {{ monitoring-name }} to:
* Track the status of your services in {{ yandex-cloud }} on service dashboards. This lets you monitor the current resource load and plan to increase [quotas]({{ link-console-quotas }}).
* Upload your own metrics using the API. You can place the metrics of your application and the metrics of {{ yandex-cloud }} resources it uses on a single dashboard.
* Download resource metrics and custom metrics using the API.
* Create dashboards and charts to display metrics that's convenient for you.

## How the service works {#how-it-works}

The {{ monitoring-name }} service collects and stores metrics as [time series](https://en.wikipedia.org/wiki/Time_series). The service uses labels to identify and describe the time series characteristics. Labels indicate the resource that the metric belongs to, describe the meaning of metric, and so forth. For more information, see [{#T}](data-model.md).

{{ monitoring-name }} displays metrics on charts. You can place a large number of interrelated charts on dashboards. For more information, see [{#T}](visualization/index.md).


## Delivering {{ managed-k8s-full-name }} cluster metrics {#metrics-provider}

{{ monitoring-name }} enables you to export [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) object metrics. The provider converts a request to get external metrics from a {{ managed-k8s-name }} cluster object to the format required by {{ monitoring-name }} and also performs the reverse conversion: from {{ monitoring-name }} to a cluster object.

{% include [metrics-k8s-tools](../../_includes/managed-kubernetes/metrics-k8s-tools.md) %}

The metrics are described in the [Reference](../metrics-ref/index.md#managed-kubernetes).


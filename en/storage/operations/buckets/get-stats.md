---
title: Viewing bucket metrics in {{ objstorage-full-name }}
description: Follow this guide to view bucket metrics in {{ objstorage-name }}.
---

# Viewing bucket metrics

{{ objstorage-name }} automatically delivers bucket performance metrics to [{{ monitoring-full-name }}](../../../monitoring).

You can view overall performance statistics on the [bucket page](#storage-ui), with detailed metrics available from the [{{ monitoring-name }} interface](#monitoring).

For a full list of metrics, see the [reference](../../metrics.md).

## View overall statistics on the bucket page {#storage-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket whose statistics you want to view.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. Select the time period to view the statistics for: 1 hour, 3 hours, 1 day, 1 week, 1 month. 

      {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}

{% endlist %}

## View detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. In the left-hand panel, select ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. In the query string, select the parameters:
      1. **{{ objstorage-name }}** service.
      1. Metric values you want to visualize.
      1. Label for the metric.

{% endlist %}
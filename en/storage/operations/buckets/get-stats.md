---
title: Viewing bucket metrics in {{ objstorage-full-name }}
description: Follow this guide to view bucket metrics in {{ objstorage-name }}.
---

# Viewing bucket metrics

{{ objstorage-name }} automatically delivers bucket performance metrics to [{{ monitoring-full-name }}](../../../monitoring).

You can view overall performance statistics on the [bucket page](#storage-ui). For more detailed information, use the [{{ monitoring-name }} interface](#monitoring).

To view a full list of metrics, see [this reference](../../metrics.md).

## Viewing overall statistics on the bucket page {#storage-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the bucket you want to get the statistics for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. Select the statistics time interval: 1 hour, 3 hours, 1 day, 1 week, or 1 month. 

      {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}

{% endlist %}

## View detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. In the left-hand panel, select ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. In the query, specify the following:
      1. **{{ objstorage-name }}**.
      1. Metric you want to visualize.
      1. Metric label.

{% endlist %}
---
title: "Viewing Cloud DNS metrics"
description: "Follow this guide to view zone and request metrics."
---

# Viewing zone metrics

{{ dns-name }} automatically sends zone and request metrics to [{{ monitoring-full-name }}](../../monitoring).

You can view the general operational statistics on the [zone page](#storage-ui) or detailed statistics in the [{{ monitoring-name }} interface](#monitoring).

For a full list of metrics, see the [reference](../metrics.md).

## Viewing zone request statistics on the zone page {#zone-ui}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder in which the zone resides.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Select the zone you want to get statistics for.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Select the time period for the statistics: one hour, three hours, one day, one week, or one month.

      The **Zone requests** dashboard will appear on the tab, showing the number of incoming requests over the selected time period for the zone.

{% endlist %}

## View detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder in which the zone was created.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. In the left-hand panel, select ![image](../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
   1. In the query string, select the parameters:
      1. **{{ dns-name }}** service.
      1. Metric values you want to visualize.
      1. Label for the metric.

{% endlist %}
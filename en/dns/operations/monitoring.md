---
title: Cloud DNS metric monitoring
description: In this tutorial, you will learn how to view DNS zone and query metrics.
---

# Viewing zone metrics

{{ dns-name }} automatically sends zone and query metrics to [{{ monitoring-full-name }}](../../monitoring).

You can view the general operational statistics on the [zone page](#storage-ui) or the detailed statistics in the [{{ monitoring-name }} interface](#monitoring).

For a full list of metrics, see [this reference](../metrics.md).

## Viewing zone query statistics on the zone page {#zone-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your zone resides.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone whose statistics you want to view.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. Select the statistics time interval: 1 hour, 3 hours, 1 day, 1 week, or 1 month. 

      You will see the **Zone requests** dashboard showing the number of incoming requests for the selected zone and time interval.

{% endlist %}

## View detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your zone.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. In the left-hand panel, select ![image](../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. In the query, specify the following: 
      1. **{{ dns-name }}**.
      1. Metric you want to visualize.
      1. Metric label.

{% endlist %}
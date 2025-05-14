---
title: How to visualize metrics in {{ monitoring-name }}
description: Follow this guide to read and visualize {{ prometheus-name }} metrics in {{ monitoring-name }}.
---

# Reading and visualizing metrics in {{ monitoring-name }}

In {{ monitoring-full-name }}, you can work with data collected by {{ managed-prometheus-name }}. With {{ prometheus-name }} metrics, you can build charts in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section and add them to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.

Previously, {{ prometheus-name }} metrics-based charts were in **{{ prometheus-name }}** → <Workspace> → **Metrics**.

Alert configuration with the help of {{ prometheus-name }} metrics remains in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** section. For more information, see [{#T}](../alerting-rules.md).


## Adding charts in {{ monitoring-name }} {#prometheus-metrics}

{% list tabs group=instructions %}

- Management console {#console}

  1. If not using {{ managed-prometheus-name }} yet, set up [metric writes](../ingestion/index.md).
  1. Open the [service home page]({{ link-monitoring }}).
  1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** on the left.
  1. In the **Data source** list at the top, select **{{ prometheus-name }}**.
  1. Select a workspace. If there is only one workspace, it will be selected by default.
  1. In the query string, enter the metrics display parameters in [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. For the chart to display several lines, click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and enter a new query.
  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** or press **Cmd/Ctrl + Enter**.

  {% note info %}

  For {{ prometheus-name }} metrics, all features described in [{#T}](../../metric/metric-explorer.md) are available except for adding parameters. Therefore, you cannot break your charts down by parameter.

  {% endnote %}

{% endlist %}

## Adding charts to the dashboard {#prometheus-dashboard}

You can add charts to the dashboard from **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** or in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.

Adding a chart from **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Build a chart](#prometheus-metrics) based on {{ prometheus-name }} metrics.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
  1. Enter a name for your chart.
  1. Select a cloud and folder.
  1. Select an existing dashboard or create a new one.
  1. Select a chart adding option:
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}**: Stay in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}**: Go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. The chart will not be saved in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

{% endlist %}

Adding a chart under **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [service home page]({{ link-monitoring }}).
  1. Go to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** section.
  1. Select an existing dashboard or [create a new one](../../dashboard/create.md).
  1. At the top right, click ![image](../../../../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
  1. In the **Data source** list at the top, select **{{ prometheus-name }}**.
  1. Select a workspace. If there is only one workspace, it will be selected by default.
  1. In the query string, enter the metrics display parameters in [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Click ![image](../../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right. This will add the chart to your dashboard.

{% endlist %}


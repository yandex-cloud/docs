{% list tabs group=instructions %}

- Management console {#console}

  1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. In the **Data source** list at the top, select **{{ prometheus-name }}**.
  1. Select a workspace.
  1. Enter a query in [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. For the chart to display several lines, click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and enter a new query.
  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** to build a chart.

      You can [add](#add-to-dashboard) the chart to the [dashboard](../../monitoring/concepts/visualization/dashboard.md) as a [widget](../../monitoring/concepts/visualization/widget.md).

{% endlist %}
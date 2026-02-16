# Getting started with {{ monitoring-full-name }}

In this tutorial, you will create a dashboard with widgets displaying the {{ yandex-cloud }} resource status.

{% note info %}

{{ monitoring-full-name }} automatically creates service dashboards with widgets displaying the status of your cloud resources.

If you do not have any resources, create a {{ CH }} VM and cluster for this example.

{% endnote %}



## Create a new dashboard {#create-dashboard}

1. On the [homepage]({{ link-monitoring }}), click **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. At the top right, click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. In the text field that appears, specify `Cross-service dashboard`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   
   Headings allow you to separate dashboard sections.
1. Save the dashboard:
   1. At the top right, click ![image](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   1. Specify the dashboard title.


## Add a {{ compute-full-name }} widget {#add-compute-widget}

1. At the top right, click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart showing CPU load of all VMs in the folder, using {{ compute-full-name }} `cpu_usage` metric. To do this, select the following labels in the query constructor:
    - `service=Compute Cloud`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. The chart will appear on the page.
1. At the top, next to the dashboard name, specify the widget name, e.g., `CPU on all hosts`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}** at the top right.
1. Return to the dashboard editing page by clicking the dashboard title (you specified earlier) at the top.

## Add a {{ mch-full-name }} widget {#add-clickhouse-widget}

1. Click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart showing the amount of free space on {{ mch-full-name }} cluster VMs, using `disk.free_bytes` metric. To do this, select the following labels in the query constructor:
    - `service=Managed Service for ClickHouse`
    - `name=disk.free_bytes`
    - `host=*`
    - `resource_id=*`
    - `resource_type=cluster`

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
1. Specify your widget name, e.g., `Free space on ClickHouse hosts`.
1. Apply the changes and return to the dashboard editing page. 

## Save the new dashboard {#save-dashboard}

1. Change the widget size and arrange them according to your preferences.
1. Click ![image](../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

In the end, you created a dashboard with widgets displaying the resource status for different {{ yandex-cloud }} services.

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}

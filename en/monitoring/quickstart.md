# Getting started with {{ monitoring-full-name }}

This guide explains how to create a dashboard and add widgets that display the status of {{ yandex-cloud }} resources.

{% note info %}

{{ monitoring-full-name }} automatically creates service dashboards with a set of widgets that display the status of your cloud resources.

If you do not have any resources, create them (for example, a {{ CH }} VM and cluster) to get started with the service.

{% endnote %}



## Create a new dashboard {#create-dashboard}

1. On the [homepage]({{ link-monitoring }}), click **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. At the top right, click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. In the text field, enter `Cross-service dashboard`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   
   The heading allows you to separate one dashboard section from another.
1. Save the dashboard:
   1. At the top right, click ![image](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   1. Enter the dashboard heading.


## Add a widget of {{ compute-full-name }} {#add-compute-widget}

1. At the top right, click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart representing CPU loads of all the VMs in the folder by specifying {{ compute-full-name }}'s `cpu_usage` metric in the query. To do this, select the following labels in the query constructor:
    - `service=Compute Cloud`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. The chart will be displayed on the page.
1. At the top, next to the dashboard name, enter the widget name, e.g., `CPU on all hosts`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}** at the top right.
1. Return to the dashboard editing page by clicking the dashboard heading you specified earlier at the top.

## Add a widget of {{ mch-full-name }} {#add-clickhouse-widget}

1. Click ![image](../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart representing the amount of free space on {{ mch-full-name }} cluster VMs by specifying the `disk.free_bytes` metric in the query. To do this, select the following labels in the query constructor:
    - `service=Managed Service for ClickHouse`
    - `name=disk.free_bytes`
    - `host=*`
    - `resource_id=*`
    - `resource_type=cluster`

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
1. Enter a name for the widget, e.g., `Free space on ClickHouse hosts`.
1. Apply the changes and return to the dashboard editing page. 

## Save the created dashboard {#save-dashboard}

1. If you need to, change the size of widgets and arrange them on the dashboard in a random order.
1. Click ![image](../_assets/console-icons/floppy-disk-blue.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

As a result, you created a dashboard with widgets that display the status of resources from different {{ yandex-cloud }} services.

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}

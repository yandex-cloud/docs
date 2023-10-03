# Getting started with {{ monitoring-full-name }}

This guide explains how to create a dashboard and add widgets that display the status of {{ yandex-cloud }} resources.

{% note info %}

{{ monitoring-full-name }} automatically creates service dashboards with a set of widgets that display the status of your cloud resources.

If you do not have any resources, create them (for example, a {{ CH }} VM and cluster) to get started with the service.

{% endnote %}


## Create a new dashboard {#create-dashboard}

1. On the [home page]({{ link-monitoring }}), click **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. Click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. In the text field, enter `Cross-service dashboard`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
1. Drag the created widget to the appropriate place on the dashboard.


## Add a widget of {{ compute-full-name }} {#add-compute-widget}

1. On the dashboard editing page, click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart that shows CPU load on all the VMs in the folder by specifying the `cpu_usage` metric of the {{ compute-full-name }} service in the query. To do this, select the following labels in the query constructor:
   - `service=Compute Cloud`
   - `name=cpu_usage`
   - `resource_id=*`
   - `resource_type=vm`
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**. The widget will be displayed on the dashboard.
1. Click ![gear](../_assets/monitoring/gear.svg) to open the widget configuration modal window.
1. In the **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.title }}** parameter, enter a name for the widget. For example, `CPU on all hosts`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**. The widget name appears at the top of the widget.
1. Drag the created widget to the appropriate place on the dashboard.

## Add a widget of {{ mch-full-name }} {#add-clickhouse-widget}

1. On the dashboard editing page, click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart that shows the amount of free space on {{ mch-full-name }} cluster VMs by specifying the `disk.free_bytes` metric in the query. To do this, select the following labels in the query constructor:
   - `service=Managed Service for ClickHouse`
   - `name=disk.free_bytes`
   - `host=*`
   - `resource_id=*`
   - `resource_type=cluster`

1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**. The widget will be displayed on the dashboard.
1. Click ![gear](../_assets/monitoring/gear.svg) to open the widget configuration modal window.
1. In the **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.title }}** parameter, enter a name for the widget. For example, `Free space on ClickHouse hosts`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**. The widget name appears at the top of the widget.
1. Drag the created widget to the appropriate place on the dashboard.

## Save the created dashboard {#save-dashboard}

1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}** in the upper-right corner of the menu.
1. Enter a name for the dashboard and click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

As a result, you created a dashboard with widgets that display the status of resources from different {{ yandex-cloud }} services.

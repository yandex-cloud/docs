# Getting started with {{ monitoring-full-name }}

This guide explains how to create a dashboard and add widgets that display the status of {{ yandex-cloud }} resources.

{% note info %}

{{ monitoring-full-name }} automatically creates service dashboards with a set of widgets that display the status of your cloud resources.

If you don't have any resources, create them (for example, a {{ CH }} VM and cluster) to get started with the service.

{% endnote %}


## Create a new dashboard {#create-dashboard}

1. On the service [homepage]({{ link-monitoring }}), click **Create dashboard**.
1. Click **Add** in the upper-right corner of the menu and select **Heading**.
1. In the text field, enter **Cross-service dashboard**.
1. Click **Add**.
1. Drag the created widget to the appropriate place on the dashboard.


## Add a widget of {{ compute-full-name }} {#add-compute-widget}

1. On the dashboard editing page, click **Add** in the upper-right part of the menu and select **New chart**.
1. Configure a new chart that shows CPU load on all the VMs in the folder by specifying the `cpu_usage` metric of the {{ compute-full-name }} service in the query. To do this, select the following labels in the query constructor:
   - `service=Compute Cloud`
   - `name=cpu_usage`
   - `resource_id=*`
   - `resource_type=vm`
1. Click **Save**. The widget is displayed on the dashboard.
1. Click ![gear](../_assets/monitoring/gear.svg) to open the widget configuration modal window.
1. In the **Heading** parameter, enter a name for the widget. For example, CPU on all hosts.
1. Click **Save**. The widget name appears at the top of the widget.
1. Drag the created widget to the appropriate place on the dashboard.

## Add a widget of {{ mch-full-name }} {#add-clickhouse-widget}

1. On the dashboard editing page, click **Add** in the upper-right part of the menu and select **New chart**.
1. Configure a new chart that shows the amount of free space on {{ mch-full-name }} cluster VMs by specifying the `disk.free_bytes` metric in the query. To do this, select the following labels in the query constructor:
   - `service=Managed Service for ClickHouse`
   - `name=disk.free_bytes`
   - `host=*`
   - `resource_id=*`
   - `resource_type=cluster`

1. Click **Save**. The widget is displayed on the dashboard.
1. Click ![gear](../_assets/monitoring/gear.svg) to open the widget configuration modal window.
1. In the **Heading** parameter, enter a name for the widget. For example, Free space on ClickHouse hosts.
1. Click **Save**. The widget name appears at the top of the widget.
1. Drag the created widget to the appropriate place on the dashboard.

## Save the created dashboard {#save-dashboard}

1. Click **Save** in the upper-right corner of the menu.
1. Enter a name for the dashboard and click **Save**.

As a result, you created a dashboard with widgets that display the status of resources from different {{ yandex-cloud }} services.

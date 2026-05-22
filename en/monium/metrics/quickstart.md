# Getting started with {{ yandex-cloud }} resource metrics

{{ monium-name }} allows you to work with the metrics of {{ yandex-cloud }} services as well as any other metrics uploaded to {{ monium-name }}, e.g., from your applications, infrastructure, or other clouds.

Follow this guide to create a dashboard and widgets displaying the state of your {{ yandex-cloud }} resources.

{% note info %}

The {{ yandex-cloud }} resource metrics are sent to {{ monium-name }} automatically. Many services also provide dashboards with ready-made widgets showing the status of your cloud resources.

If you do not have any resources to test {{ monium-name }}, create a [VM](../../compute/operations/vm-create/create-linux-vm.md).

{% endnote %}

## Create a new dashboard {#create-dashboard}

1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **Dashboards** on the left.
1. In the top-left corner, select the folder project containing the resource in question.
1. At the top right, click **Create**.
1. At the top right, click ![image](../../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. In the text field that appears, specify `Cross-service dashboard`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   
   Headings allow you to separate dashboard sections.
1. Save the dashboard:
   1. At the top right, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   1. Specify the dashboard title.


## Add a {{ compute-full-name }} widget {#add-compute-widget}

1. At the top right, click ![image](../../_assets/console-icons/plus.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure a new chart showing CPU load of all VMs in the folder, using {{ compute-full-name }} `cpu_usage` metric. To do this, select the following labels in the query constructor:
    - `cluster`=`default`
    - `service=__compute__`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** and the page will present a chart.
1. At the top, next to the dashboard name, specify the widget name, e.g., `CPU on all hosts`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}** at the top right.
1. Return to the dashboard editing page by clicking the dashboard title (you specified earlier) at the top.

## Add a section widget {#add-section}

1. Click ![image](../../_assets/console-icons/plus.svg) and select **Section**.
1. Drag the title and chart to the section you created.
1. Next to the section name, click the settings and enter a section title, e.g., `Virtual machines`.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**. 

## Save the new dashboard {#save-dashboard}

1. Change the widget size and arrange them according to your preferences.
1. Click ![image](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

In the end, you created a dashboard with widgets displaying the resource status for different {{ yandex-cloud }} services.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

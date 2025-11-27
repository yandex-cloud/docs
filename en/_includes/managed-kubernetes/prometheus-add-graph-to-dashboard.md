{% list tabs group=instructions %}

- Management console {#console}

   1. [Build a chart](#add-graph).
   1. At the top right, click **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
   1. Enter a name for your chart.
   1. Select a cloud and folder.
   1. Select an existing dashboard or create a new one.
   1. Select a chart adding option:
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}**: To add the chart to the dashboard and stay in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section.
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}**: To add the chart to the dashboard and go to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** section. The chart will not be saved in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

{% endlist %}

{% note tip %}

You can [create](../../monitoring/operations/dashboard/create.md) an empty dashboard and then add the charts to it.

{% endnote %}



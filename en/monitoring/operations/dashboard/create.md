---
title: Creating a dashboard in {{ monitoring-full-name }}
description: To create a dashboard in {{ monitoring-full-name }}, open the service home page and click **Create dashboard**. Add a widget to your dashboard. Click **Title** under **Add widget** or click **Add** in the dashboard title and then select **Title**. Enter text in the input field. Select the title size. Click **Add**. You will now see the titled widget on the dashboard. Click **Save** in the top-right corner. Enter a name for your dashboard and click **Save**.
sourcePath: en/monitoring_includes/operations/dashboard/create.md
---

# Creating and managing a dashboard in {{ monitoring-name }}



Dashboards are visual panels that allow you to quickly assess the status and performance of your cloud resources. You can use ready-made dashboards offered by various services or create one of your own.

For more convenient operations with dashboards, use [labels](#labels). They help filter the dashboards and find the data you need faster.


## Creating a dashboard {#create}

To create a [dashboard](../../concepts/visualization/dashboard.md):

1. On the home page, click **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. Add a [widget](../../concepts/visualization/widget.md) to your dashboard. For example, the **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}** widget.
    1. Click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
    1. Enter text in the input field.
    1. Select the title size.
    1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**. You will now see the titled widget on the dashboard.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}** in the top-right corner.
1. Name your dashboard and click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Setting up a dashboard {#settings}

1. Open the [service home page]({{ link-monitoring }}).
1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** in the left pane of the window.
1. Select the dashboard you need.
1. At the top right, click ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}** and select one of the following options:
   * **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.general }}**. In this window, you can set:
     * **Title**: It is displayed at the top of the dashboard.
     * **Name**: It is used in the dashboard URL. If the name is not specified, the dashboard title will be used instead.
     * **Description**: Additional dashboard information.
     * **{{ ui-key.yacloud_monitoring.dashboard.settings.general.labels.title }}**: [Labels](#labels) for more flexible dashboard search.
   * **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.json }}**: Editing the dashboard in JSON format.
   * **{{ ui-key.yacloud_monitoring.component.parametrizer.parameters }}**: In this window, you can add [parameters](add-parameters.md) for interactive dashboards.
   * **{{ ui-key.yacloud_monitoring.wizard.tab.links-key-value }}**: Here you can add a link to an external resource or another dashboard.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.dashboard.dash.save }}** at the top right.

## Configuring dashboard labels {#labels}

To configure dashboard labels:

1. Open the [service home page]({{ link-monitoring }}).
1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** in the left pane of the window.
1. Select the dashboard you need.
1. At the top right, click ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}** and select **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.general }}**.
1. In the window that opens, enter the label values in `key=value` format under **{{ ui-key.yacloud_monitoring.dashboard.settings.general.labels.title }}**.
1. Click **{{ ui-key.yacloud_monitoring.navigation.dialogs.button_save }}**.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.dashboard.dash.save }}** at the top right.


## Searching for dashboards {#search}

You can search for dashboards in the list by their main parameters: **ID**, **Title**, **Name**, **Description**, and **Labels**.

To search for dashboards:

1. Open the [service home page]({{ link-monitoring }}).
1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** in the left pane of the window.
1. In the **{{ ui-key.yacloud_monitoring.component.entities-list.common-filter-placeholder }}** field, enter the label key or value, title, name, or description.

#### What's next {#what-is-next}
- [{#T}](add-widget.md)
- [Dashboard concepts](../../concepts/visualization/dashboard.md)

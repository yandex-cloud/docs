---
title: How to manage dashboard elements in {{ monitoring-full-name }}
description: In this guide, you will learn how to manage dashboard elements in {{ monitoring-name }}.
---

# Managing widgets

You can manage widgets on the dashboard: duplicate, copy to another dashboard, share a link to a widget, etc. Available actions are widget type-specific.

## Chart {#graph}

1. On the home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** and open a dashboard or [create a new one](../dashboard/create.md). 
1. [Add](../dashboard/add-widget.md#graph) and configure a chart. 
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of your widget. 
1. In the menu that opens, select one of these options:

    * **{{ ui-key.yacloud_monitoring.actions.common.edit }}**: Edit query, chart type, or other parameters.
    * **{{ ui-key.yacloud_monitoring.actions.common.duplicate }}**: Create a copy of the widget on the current dashboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}**: Create a copy of the widget on a selected dashboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.addToSelection }}**: Add the widget to a selection. With several widgets selected, you can copy them to the clipboard and paste onto a dashboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.share }}**: Share the chart using one of the following options:
      * **Publication**: Link to the dashboard in {{ monitoring-name }}.
      * **Export**: Save as `CSV` or `JSON`.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.share-screenshot-key-value }}**:
      * **Copy screenshot**: Save a screenshot of the chart to the clipboard in `PNG` format.
      * **Copy link to screenshot**: Save a screenshot of the chart in `PNG` format to the {{ monitoring-name }} storage and copy a link to that screenshot to the clipboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.fix-time }}**: Set a fixed time scale for the chart: `1 hour`, `1 day`, `1 week`, or `1 month`.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.display-legend }}**: Display the chart legend.
    * **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**: Create an alert for the chart query.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.delete-key-value }}**: Delete the widget.

## Alert {#alert}

1. Open a dashboard or [create a new one](../dashboard/create.md). 
1. [Add](../dashboard/add-widget.md#alert) and configure an alert.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of your widget. 
1. In the menu that opens, select one of these options:

    * **{{ ui-key.yacloud_monitoring.dashboard.dash.setup }}**: Open the alert editing menu.
    * **{{ ui-key.yacloud_monitoring.actions.common.duplicate }}**: Create a copy of the widget on the current dashboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}**: Create a copy of the widget on a selected dashboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.addToSelection }}**: Add the widget to a selection.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.share-screenshot-key-value }}**:
      * **Copy screenshot**: Save a screenshot of the widget in `PNG` format to the clipboard.
      * **Copy link to screenshot**: Save a screenshot of the widget in `PNG` format to the {{ monitoring-name }} storage and copy a link to that screenshot to the clipboard.
    * **{{ ui-key.yacloud_monitoring.dashboard.widget.delete-key-value }}**: Delete the widget.

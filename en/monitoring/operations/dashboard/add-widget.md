---
title: How to add a widget to a dashboard in {{ monitoring-full-name }}
description: In this guide, you will learn how to add a widget to a dashboard in {{ monitoring-name }}.
---

# Adding a widget to a dashboard

Dashboards are visual panels that allow you to quickly assess the status and performance of your cloud resources. You can use ready-made dashboards offered by various services or create your own one.

A dashboard consists of widgets that allow displaying various types of information: a [chart](#graph), [alert](#alert), or [escalation](#escalation). There are also widgets that help you organize information on a dashboard, i.e., a [title](#heading), [text](#text), and [section](#group).

Adding a widget to a dashboard involves the following steps:

1. Open a dashboard or [create a new one](create.md).
1. At the top right, click ![image](../../../_assets/console-icons/plus.svg) and select the widget you want to add.
1. Specify the widget settings.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

You can move widgets around the dashboard and resize them.

## Chart {#graph}

A chart allows you to visualize metric changes over time. You can configure charts on the dashboard or add them from the [Metrics](../metric/metric-explorer.md#add-to-dashboard) section.

1. Click ![image](../../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure the chart by specifying [queries](../../concepts/querying.md) and visualization of metrics.
1. Optionally, add [parameters](add-parameters.md) and configure [chart repetition](add-parameters.md#repeated-graphs).
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

### Chart parameters {#chart-parameters}

The steps you take to configure charts on the dashboard or in the [Metrics](../metric/metric-explorer.md#add-graph) section are the same.

To configure a chart:

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) near the chart and select **{{ ui-key.yacloud_monitoring.dashboard.dash.edit }}**.
1. At the top right of the chart panel, click ![image](../../../_assets/console-icons/gear.svg) **Settings**.
1. Set the chart parameters listed below.

   The parameters you enter will apply to the chart immediately so you do not need to save them.
1. Close the side panel after you complete the configuration.

#### Links {#chart-links}

You can add a link to an external resource or dashboard.

1. Under **{{ ui-key.yacloud_monitoring.component.juggler-modal.form.juggler-links.title }}**, click **{{ ui-key.yacloud_monitoring.quicklinks.action.add-link }}**.
1. Enter the link title to display on the chart.
1. Select **{{ ui-key.yacloud_monitoring.context-links.label.type.url }}** and enter the link text in `http(s)://<address>` format. You can add a link to any website or an external resource.
1. Select **{{ ui-key.yacloud_monitoring.context-links.target.dashboard }}** and specify:
   1. Cloud and folder where the dashboard resides. The list contains all clouds and folders you have access to.
   1. Dashboard to open via the link.
   1. **Share timeframe**. The chart will share the timeframe of the source chart.
1. Enable or disable the **Open in new tab** option.

## Alert {#alert}

Use the alert widget to display the current alert status on a dashboard. To add such widget to a dashboard, [create an alert](../alert/create-alert.md) first.

1. Click ![image](../../../_assets/console-icons/megaphone.svg) **Alert**.
1. Select an alert from the list and enter a title for it.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Escalation {#escalation}

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}

This dashboard widget displays running escalation instances from the same escalation policy. To add such widget to a dashboard, [create](../alert/create-escalation.md) an escalation policy first.

1. Click **Escalation**.
1. Enter a title for the escalation.
1. Select an escalation policy from the list.
1. Optionally, specify whether the dashboard should display all escalations or only those currently running.
1. Optionally, enter the maximum number of escalations that can be displayed on the dashboard.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Text {#text}

Use this widget to add a text comment to a dashboard. It supports text formatting, lists, headers, cuts, links, code blocks, images, and other elements.

1. Click ![image](../../../_assets/console-icons/square-letter-t.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-text }}**.
1. Enter text in the input field. Format the text as needed.
1. To add a link, image, code block, or another element, click ![image](../../../_assets/console-icons/ellipsis.svg) and select the item you need.
1. To enter text in [Markdown format](https://diplodoc.com/docs/en/syntax/), click ![image](../../../_assets/console-icons/gear.svg) and select **Markdown markup**.
   To exit the markup mode, click ![image](../../../_assets/console-icons/gear.svg) and select **Visual editor**.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Title {#heading}

Titles allow you to visually separate widgets on a dashboard.

1. Click ![image](../../../_assets/console-icons/font.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. Enter text in the input field.
1. Select the title size. There are four available title levels.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Section {#group}

A section allows you to group widgets on a dashboard and hide widget groups.

1. Click ![image](../../../_assets/console-icons/square-bars.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-group }}**.
1. Drag widgets to the section.
1. Click ![image](../../../_assets/console-icons/gear.svg) next to the section name and specify:
   1. **Section name**: Enter a name.
   1. **Section state**: Select whether to collapse or expand the section by default.
   1. **Repeat by**: Select a parameter to add sections with charts for each of its values.
   1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

To share a section, click ![image](../../../_assets/console-icons/link.svg) next to the section name. A link to the section will be copied to the clipboard.

#### See also

  * [Widget concepts](../../concepts/visualization/widget.md)
  * [{#T}](widget-management.md)
  * [Dashboard concepts](../../concepts/visualization/dashboard.md)
---
title: How to add a widget to a dashboard in {{ monitoring-full-name }}
description: In this guide, you will learn how to add a widget to a dashboard in {{ monitoring-name }}.
---

# Adding a widget to a dashboard

Dashboards are visual panels that allow you to quickly assess the status and performance of your cloud resources. You can use ready-made dashboards offered by various services or create one of your own.

A dashboard consists of widgets that allow displaying various types of information, namely [charts](#graph), [alerts](#alert), and [escalations](#escalation), as well as of widgets that help structuring information on the dashboard, i.e., [titles](#heading), [texts](#text), and [sections](#group).

Adding a widget to a dashboard involves the following steps:

1. Open a dashboard or [create a new one](create.md).
1. At the top right, click ![image](../../../_assets/console-icons/plus.svg) and select the widget you want to add.
1. Specify the widget settings.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

You can move widgets around the dashboard and resize them.

## Chart {#graph}

A chart allows you to visualize metric changes over time. You can add charts to a dashboard from the [Metrics](../metric/metric-explorer.md#add-to-dashboard) section or configure them on the dashboard. The steps you take to configure charts on the dashboard or in the [Metrics](../metric/metric-explorer.md#add-graph) section are the same.

1. Click ![image](../../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure the chart by specifying [queries](../../concepts/querying.md) and visualization of metrics.
1. Optionally, add [parameters](add-parameters.md) and configure [chart repetition](add-parameters.md#repeated-graphs).
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

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
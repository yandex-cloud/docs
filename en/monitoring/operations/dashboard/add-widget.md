---
title: How to add a widget to a dashboard in {{ monitoring-full-name }}
description: In this tutorial, you will learn how to add a widget to a dashboard in {{ monitoring-name }}.
---

# Adding a widget to a dashboard

1. Open a dashboard or [create a new one](create.md).
1. At the top right, click ![image](../../../_assets/console-icons/plus.svg) and select the widget you want to add.
1. Specify the widget settings.
1. Click ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.

## Chart {#new}

1. Click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Configure the chart by specifying queries and visualization of metrics.
1. Optionally, add [parameters](add-parameters.md) and configure [chart repetition](add-parameters.md#repeated-graphs).
1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}**.

## Alert {#alert}

[Create an alert](../alert/create-alert.md) to add it to a dashboard.

1. Click **Alert**.
1. Select an alert from the list and enter a title for it.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Escalation {#escalation}

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}

To add an escalation to a dashboard, [create](../alert/create-escalation.md) an escalation policy.

1. Click **Escalation**.
1. Enter a title for the escalation.
1. Select an escalation policy from the list.
1. Optionally, specify whether the dashboard should display all escalations or only those currently running.
1. Optionally, enter the maximum number of escalations that can be displayed on the dashboard.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Text {#text}

1. Click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-text }}**.
1. Enter the text for your heading in the input field. Format the text as needed.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Title {#heading}

1. Click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. Enter the text for your heading in the input field.
1. Select the heading size.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
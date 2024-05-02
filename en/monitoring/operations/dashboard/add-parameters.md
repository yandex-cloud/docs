---
title: "How to add a dashboard parameter to {{ monitoring-full-name }}"
description: "In this tutorial, you will learn how to add a dashboard parameter to {{ monitoring-name }}."
---

# Adding a dashboard parameter

[Parameters](../../concepts/visualization/dashboard.md#parameterization) allow you to create dashboards with customizable interactive content.

{% include [dash-parameters](../../../_includes/monitoring/dash-parameters.md) %}

To add a dashboard parameter:

1. Open the [service home page]({{ link-monitoring }}).
1. On the left side of the window, select the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** section.
1. Select the dashboard you need.
1. At the top of the page, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_monitoring.actions.common.edit }}**.
1. Click ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}**.
1. In the **{{ ui-key.yacloud_monitoring.dashboard.settings.dashboard-settings }}** window, go to the ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_monitoring.component.parametrizer.parameters }}** tab.
1. Click **{{ ui-key.yacloud_monitoring.component.parametrizer.add }}**.
1. Configure the parameter and click **{{ ui-key.yacloud_monitoring.component.parametrizer.save }}**.

You can [substitute a parameter](../../concepts/visualization/dashboard.md#templates) when [adding a widget to the dashboard](add-widget.md).
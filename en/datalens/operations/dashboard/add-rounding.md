---
title: How to configure corner rounding on a dashboard in {{ datalens-full-name }}
description: Follow this guide to configure widget corner rounding on a dashboard in {{ datalens-full-name }}.
---

# Configuring corner rounding on a dashboard in {{ datalens-full-name }}

You can set corner rounding for all dashboard widgets. This setting is configured separately for the light and dark theme.

To configure corner rounding on a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](create.md).
1. In the top-right corner, click **Edit**.
1. At the top of the screen, click ![image](../../../_assets/console-icons/gear.svg). The settings window will open on the right.
1. Under **Appearance**, select the dashboard theme to configure the background for:

   * ![image](../../../_assets/console-icons/sun.svg): Light theme.
   * ![image](../../../_assets/console-icons/moon.svg): Dark theme.

1. Set the widget rounding value. The possible values range from `0` to `24` in increments of `2`. The default value for all widgets is either `3` or `12`, depending on whether [UI customization](../../settings/appearance.md#ui-customization) is enabled and which version is used. You can also set a custom value.
1. In the top-right corner of the dashboard edit window, click **Save**.

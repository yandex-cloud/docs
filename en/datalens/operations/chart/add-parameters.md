---
title: "How to add parameters in dashboard chart settings in {{ datalens-full-name }}"
description: "Follow this guide to add parameters in dashboard chart settings."
---

# Adding parameters in dashboard chart settings

To set a parameter:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](../dashboard/create.md).
1. In the top-right corner, click **Edit**.
1. Select a chart for which you want to set a new parameter.
1. In the top-right corner of the chart, click ![image](../../../_assets/console-icons/gear.svg).
1. In the window that opens, click ![image](../../../_assets/console-icons/chevron-down.svg) **Parameters**.
1. Click ![image](../../../_assets/console-icons/plus.svg) **Add parameter** at the bottom of the list.
1. In the **Name** column, enter the parameter name (key).
1. In the **Value** column, click ![image](../../../_assets/console-icons/plus.svg) and set a value for the parameter. You can set multiple values.
1. Click **Save**.
1. In the top-right corner of the dashboard edit window, click **Save**.

{% cut "Example of adding a parameter with a date interval" %}

For example, to set the date and time [interval](../../dashboard/dashboard_parameters.md#interval) between `03-08-2018 09:00:00` and `10-08-2018 10:00:00`, set the parameter to `__interval_2018-08-03T09:00:00_2018-08-10T10:00:00`.

![image](../../../_assets/datalens/parameters/date-interval-example.png)

{% endcut %}

{% cut "Example of adding a parameter with a relative date" %}

For example, to set the date and time interval from the beginning of the last week of 2018 until today, set the parameter to `__interval_2018-12-23___relative_+0d`.

![image](../../../_assets/datalens/parameters/iso-date.png)

To build relative statistics from the beginning of the year, change `__relative_-0d` to `__relative_-0y_sy`.

{% note info %}

Note: If no casting is specified, then for the units of one day and higher, the time is cast to the start of the day, that is, `00:00:00.000`, while casting to the current time is used for smaller time units.

{% endnote %}

{% endcut %}
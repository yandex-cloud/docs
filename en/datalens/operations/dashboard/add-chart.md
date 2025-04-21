---
title: How to add a chart to a dashboard in {{ datalens-full-name }}
description: Follow this guide to add a chart to a dashboard.
---

# Adding a chart to a dashboard

To add a chart to a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](create.md).
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, hold down ![image](../../../_assets/console-icons/chart-column.svg) **Chart** and drag it to the required area.

   ![image](../../../_assets/datalens/operations/widget-select.png =500x118)

1. Specify the widget settings. Pay close attention to the following fields:

   * **Name**: Sets the name of the widget. If the **Show** option is enabled (by default), the name is displayed at the top of the widget.
   * **Chart**: Sets the widget to add. Select a chart: 

     {% list tabs %}

     - From the list of objects

       Click **Select**. Select the desired chart from the list of objects. If the chart is already selected, you can proceed to edit it. To do this, click **Open** to the right of the chart.

     - Via a link

       Click **Specify link**. Enter the chart URL in the input field. Click **OK** on the right.


     {% endlist %}

   * **Description**. This option allows adding a description for the widget. The description is displayed at the bottom of the widget. You can use either a visual editor or [Markdown](../../dashboard/markdown.md).
   * **Tooltip**. This option allows adding a tooltip to the widget. With this option on, the ![image](../../../_assets/console-icons/circle-question.svg) icon will appear next to the chart header. Hovering over the icon will bring up the tooltip text. You can use either a visual editor or [Markdown](../../dashboard/markdown.md).
   * **Auto height**: Sets the automatic height for the **Table** widget type. If this parameter is disabled, you can set the height of the widget on the page using the mouse.

1. (Optional) Under **Parameters**, list [chart parameters](../../dashboard/dashboard_parameters.md#params-chart) and set their default values. If the default values are not set, an error will be displayed on the dashboard.
1. Click **Add**. The widget will be displayed on the dashboard.

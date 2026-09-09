---
title: How to add Insight to a dashboard chart in {{ datalens-full-name }}
description: Follow this guide to add Insight for a chart to a dashboard in {{ datalens-full-name }}.
---

# Adding an insight widget to a dashboard in {{ datalens-full-name }}

To add a Neuroanalyst insight widget to the dashboard, follow these steps:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, click ![image](../../../_assets/console-icons/sparkles-fill.svg) **Insight** and drag it to a desired location.

   ![image](../../../_assets/datalens/operations/widget-select-ai.png =687x90)

1. Specify the main widget settings:

   * **Charts for analysis**. Click ![image](../../../_assets/console-icons/plus.svg) **Add** and select a chart from the list on the current dashboard tab. You can specify up to five charts from the current dashboard tab in one insight. With Neuroanalyst, you can discover data relationships not visible in individual charts.
   * **Title**. It sets the widget name; by default, it is the name of the selected chart. The name is displayed at the top of the widget if the **Header** option is enabled under **Appearance** (which it is by default).
   * **Prompt**. Enter a question for the Neuroanalyst to answer.


   Specify widget appearance settings:

   * **Title**. Option to display the insight header.
   * **Actions with insight**. Option to display an action bar at the bottom of the insight:

     * ![image](../../../_assets/console-icons/copy.svg) **Copy**. Copies the contents of the insight to the clipboard.
     * ![image](../../../_assets/console-icons/arrow-rotate-left.svg) **Once more**. Updates the insight response.
     * ![image](../../../_assets/console-icons/thumbs-up.svg) **This answer is good**. Evaluates the insight response positively.
     * ![image](../../../_assets/console-icons/thumbs-down.svg) **This answer is bad**. Evaluates the insight response negatively.

   * **Background**. It sets the widget background color and opacity for the light and dark theme individually.
   * **Rounding**. It sets the widget corner rounding.

   {% cut "Example of insight widget settings" %}

      
   ![image](../../../_assets/datalens/dashboard/ai-settings.png =452x432)
   

   {% endcut %}

1. Click **Add**. The widget will appear on the dashboard.
1. In the top-right corner of the dashboard, click **Save**. Neuroanalyst will analyze the specified chart and generate conclusions based on the data and the custom prompt. The result in **Insight** will be updated every time you open the dashboard. If the data in the chart linked to the **Insight** widget changes, an ![image](../../../_assets/console-icons/arrow-rotate-left.svg) **Update** button will appear at the top of the widget.

   {% cut "Example of insight widget contents" %}

   ![image](../../../_assets/datalens/dashboard/ai-result.png)

   {% endcut %}

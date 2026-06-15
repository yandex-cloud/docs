---
title: How to add Neuroanalyst to a dashboard chart in {{ datalens-full-name }}
description: Follow this guide to add Neuroanalyst for a chart to a dashboard in {{ datalens-full-name }}.
---

# Adding Neuroanalyst to a dashboard in {{ datalens-full-name }}

Follow these steps to add Neuroanalyst to a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, drag ![image](../../../_assets/console-icons/sparkles-fill.svg) **Neuroanalyst** where you need.

   ![image](../../../_assets/datalens/operations/widget-select-ai.png =687x90)

1. Specify the widget settings:

   * **Chart for analysis**. Click ![image](../../../_assets/console-icons/chart-column.svg) **Select chart** and select a chart from the list on the current dashboard tab.
   * **Header**. It sets the widget name; by default, it is the name of the selected chart. The name is displayed at the top of the widget if the **Header** option is enabled under **Appearance** (which it is by default).
   * **Prompt**. Enter a question for the Neuroanalyst to answer.

   {% cut "Example of Neuroanalyst settings" %}

   ![image](../../../_assets/datalens/dashboard/ai-settings.png =597x431)
   
   {% endcut %}

1. Click **Add**. The widget will appear on the dashboard.
1. In the top-right corner of the dashboard, click **Save**. Neuroanalyst will analyze the specified chart and generate conclusions based on the data and the custom prompt. The result will be updated every time you open the dashboard. If the data in the chart linked to Neuroanalyst changes after you receive the Neuroanalyst result, an ![image](../../../_assets/console-icons/arrow-rotate-left.svg) **Update** button will appear at the top of the widget.

   {% cut "Example of Neuroanalyst response" %}

   ![image](../../../_assets/datalens/dashboard/ai-result.png)
   
   {% endcut %}

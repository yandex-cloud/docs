---
title: Neuroanalyst on your dashboard in {{ datalens-full-name }}
description: In this article, you will learn about Neuroanalyst on your dashboard in {{ datalens-full-name }} and how to use it.
---

# Neuroanalyst on your dashboard in {{ datalens-full-name }}


[Neuroanalyst](../concepts/neuroanalyst.md) on your dashboard has two versions:

* [Neuroanalyst](#neuroanalyst-1) is a tool that analyzes dashboard charts, generates findings based on their data, and allows you to ask follow-up questions. Your dashboard data is its only context. It can operate throughout your dashboard or explore specific charts.

* [Neuroanalyst 2.0](#neuroanalyst-2) is an AI agent that analyzes the dataset underlying your dashboard and can return an existing chart as a response or build a new chart based on the dataset. It uses the dataset and charts from the reference tab as context. Unlike Neuroanalyst, you cannot apply it to individual charts.

## Neuroanalyst {#neuroanalyst-1}


Neuroanalyst analyzes your dashboard charts, generates findings based on their data, and allows you to ask follow-up questions. It also considers the following for context:
* [Dashboard information](../operations/dashboard/add-description.md).
* Dashboard chart header.
* [Chart information](../operations/chart/add-description.md).
* Dashboard chart [description and tooltip](../operations/dashboard/add-chart.md) (other than tables).

You can use Neuroanalyst for the entire dashboard or individual charts on the dashboard. To use Neuroanalyst on your dashboard:

{% list tabs %}

- For entire dashboard

  1. Click **Neuroanalyst** at the top of the dashboard to open the **Neuroanalyst** tab on the right.

     {% cut "Neuroanalyst for entire dashboard" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard.png)

     {% endcut %}

  1. Select a question or ask your own one, e.g., "What charts can I add to the dashboard?".

     {% cut "Question for Neuroanalyst" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-ask.png)

     {% endcut %}

     Neuroanalyst will give a detailed answer and suggest possible solutions and recommendations.

     {% cut "Neuroanalyst's answer" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-result.png)

     {% endcut %}

     At the top of the Neuroanalyst tab, you will see the list of charts used to generate the answer.
     
     {% cut "List of charts used for Neuroanalyst' answer" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-charts-list.png)

     {% endcut %}

- For individual chart on the dashboard

  1. In the top right corner of the chart on the dashboard, click ![icon](../../_assets/console-icons/ellipsis.svg) → **Find insights** to open the **Neuroanalyst** tab on the right.

     {% cut "Neuroanalyst for a dashboard chart" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-chart.png)

     {% endcut %}

  1. Select a question or ask your own, e.g., "What insights can I get from this data?".

     {% cut "Question for Neuroanalyst" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-chart-ask.png)

     {% endcut %}

     Neuroanalyst will give a detailed answer and suggest possible solutions and recommendations.

     {% cut "Neuroanalyst's answer" %}

     ![image](../../_assets/datalens/ai/ai-analytic-on-dashboard-chart-result.png)

     {% endcut %}

{% endlist %}

You can pin the chat with Neuroanalyst on top or along the side (default) of the dashboard. To change the chat position, click:
  
  * ![image](../../_assets/console-icons/pin-slash.svg): Chat on the top of the dashboard.
  * ![image](../../_assets/console-icons/pin.svg): Chat along the side of the dashboard.

All your queries to Neuroanalyst are private: logs are neither stored nor used for further fine-tuning or research.


You can [ban](../operations/dashboard/dashboard-neuroanalyst-off.md) the use of Neuroanalyst on a dashboard.


### Limits {#restrictions-1}

* The analysis can take quite a while.
* Chart description and tooltip are not added for tables.
* Neuroanalyst can only use the data you upload to the page. If the data volume is too large, it may exceed the context available for processing.


## Neuroanalyst 2.0 {#neuroanalyst-2}

Neuroanalyst 2.0 analyzes the dataset underlying your dashboard and can return an existing chart as a response or build a new chart based on the dataset. It uses the dataset and a [reference tab](#reference-tab) as context. Neuroanalyst 2.0 uses charts from the reference tab as templates when constructing new charts.

{{ datalens-name }} features the beta version of Neuroanalyst 2.0: to use it, [enable this option](#turn-on) in your dashboard settings.


### Reference tab {#reference-tab}

Neuroanalyst 2.0 uses charts from the reference tab as verified examples of using the dataset and visualizing data.

While you can select any dashboard tab, the Neuroanalyst performance will effectively depend on your selection.

When selecting a reference tab, please follow these recommendations:

* On the tab, place [wizard charts](../concepts/chart/dataset-based-charts.md) that describe your dataset from different angles and answer different questions.
* In the descriptions of your dashboard charts or widgets, provide examples of questions they help answer.
* Instead of tab selectors, use filters in charts to make your charts answer more specific questions.
* Employ charts based on a single dataset.
* Use relevant field descriptions in the dataset.

### How to enable Neuroanalyst 2.0 {#turn-on}

To enable Neuroanalyst 2.0 on your dashboard:

1. In the left-hand panel, click ![image](../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. In the top-right corner, click **Edit**.
1. Click ![image](../../_assets/console-icons/gear.svg) at the top of the screen. The settings window will open on the right.
1. If the **Neuroanalyst** option is not enabled, re-enable it (by default, it is enabled).
1. Enable the **Beta version** option.
1. [Select a reference tab](../operations/dashboard/dashboard-ai-reference-tab.md) if your dashboard has more than one tab.
1. Optionally, [hide](../operations/dashboard/dashboard-hide-tabs.md) the reference tab in the dashboard settings.
1. In the top-right corner, click **Save**.

### Limits {#restrictions-2}

* It only applies to one dataset, that underlying your reference tab.
* Neuroanalyst's recommendations include the titles of the first three charts.

---
title: Neuroanalyst on your dashboard in {{ datalens-full-name }}
description: In this article, you will learn about Neuroanalyst on your dashboard in {{ datalens-full-name }} and how to use it.
---

# Neuroanalyst on your dashboard in {{ datalens-full-name }}

{% note info %}

This feature is at the Beta testing stage.

{% endnote %}

[Neuroanalyst](../concepts/neuroanalyst.md) on your dashboard is a tool that analyzes dashboard charts, generates findings based on their data, and allows you to ask follow-up questions. It also considers the following for context:
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

## Limitations {#restrictions}

* The analysis can take quite a while.
* Chart description and tooltip are not added for tables.
* Neuroanalyst can only use the data you upload to the page. If the data volume is too large, it may exceed the context available for processing.

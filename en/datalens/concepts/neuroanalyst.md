---
title: Neuroanalyst in {{ datalens-full-name }}
description: In this article, you will learn about {{ datalens-full-name }} Neuroanalyst.
---

# Neuroanalyst in {{ datalens-full-name }}

{{ datalens-full-name }} Neuroanalyst brings together AI assistants that help you analyze projects, suggest improvements and edits, and streamline creating and editing visualizations.

* [Neuroanalyst for creating calculated fields](../concepts/calculations/formulas-helper.md) helps write formulas and answers questions regarding them.
* [Neuroanalyst on your dashboard](../dashboard/insights.md) analyzes both the dashboard as a whole and its individual charts. The dashboard Neuroanalyst operates in agent mode: to answer a question, it can pick a similar chart or build a new one based directly on the dataset. You can [add widgets with insights](../operations/dashboard/add-ai.md) from Neuroanalyst to your dashboard.
* [Neuroanalyst in Editor](../charts/editor/code-helper.md) helps you write and debug code for visualizations and answers questions about the code.
* [Neuroanalyst in your report](../reports/insights.md) analyzes charts inside a report. You can [add widgets with insights](../reports/report-operations.md#report-widget-settings) from Neuroanalyst to your reports.
* [Neuroanalyst in mailing lists](./maillists.md) analyzes and summarizes mailing list content.



## Data security and processing {#security}


* Neuroanalyst is powered by the cloud service called [{{ ai-studio-full-name }}]({{ link-docs-ai }}).



* Your data and queries stay within the {{ yandex-cloud }} infrastructure.
* Your data and queries are not used for model fine-tuning.
* You can disable Neuroanalyst and insight widgets [at various levels](#prohibit): globally for the entire {{ datalens-name }} instance or for specific dashboards and reports.
* For limits on the number of requests to Neuroanalysts, see [this section](./limits.md#datalens-ai-limits).



## Banning the use of Neuroanalyst {#prohibit}

All {{ datalens-name }} users can use Neuroanalyst by default. Any user with the `{{ roles-datalens-admin }}` role can disable this option at the {{ datalens-short-name }} instance level or for individual dashboards/reports:

{% list tabs %}


- {{ datalens-short-name }} instance


  1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
  1. Select the **Security** tab.
  1. Disable **Neuroanalyst** (on by default). As soon as you do it, the AI assistants will disappear from the {{ datalens-name }} interface for the instance users. Widgets with insights will stop working on dashboards and in reports.





- Dashboard

  {% include [datalens-dashboard-neuroanalyst-off](../../_includes/datalens/operations/datalens-dashboard-neuroanalyst-off.md) %}

- Report

  {% include [datalens-report-neuroanalyst-off](../../_includes/datalens/operations/datalens-report-neuroanalyst-off.md) %}

{% endlist %}



## Setting up a custom prompt {#user-promt}

In {{ datalens-short-name }}, you can set up a custom prompt for AI. To do this, follow these steps:

1. Click ![image](../../_assets/console-icons/gear.svg) **Settings** in the navigation panel on the left to open the settings.
1. Go to the **AI settings** tab.


1. Click **Edit**.
1. Enter a prompt in the text field and click **Save**.

With each request to the AI, the custom prompt will be added to the {{ datalens-short-name }} system prompt.


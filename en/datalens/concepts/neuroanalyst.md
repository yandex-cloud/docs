---
title: Neuroanalyst in {{ datalens-full-name }}
description: In this article, you will learn about {{ datalens-full-name }} Neuroanalyst.
---

# Neuroanalyst in {{ datalens-full-name }}

{% note info %}

This feature is at the Beta testing stage.

{% endnote %}


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


{{ datalens-full-name }} Neuroanalyst is a group of AI assistants that help you with project analysis, suggest improvements and edits, and streamline creating and editing visualizations.

* [Neuroanalyst for calculated fields](../concepts/calculations/formulas-helper.md): Helps you to create calculated fields.
* [Neuroanalyst on your dashboard](../dashboard/insights.md): Neuroanalytics on your dashboard.
* [Neuroanalyst in Editor](../charts/editor/code-helper.md): Helps you to write code and search for answers to your questions.
* [Neuroanalyst in report](../reports/insights.md): Neuroanalytics in your report.



## Data security and processing {#security}

* Neuroanalyst is based on the cloud service called [{{ foundation-models-full-name }}](../../ai-studio).
* Your data and queries stay within the {{ yandex-cloud }} infrastructure.
* The currently used model is Qwen3 235B-A22B-Instruct-2507; going forward, there will be more models to choose from.
* Your data and queries are not logged, nor used for model tuning.
* The admin can [disable generation of insights for your users](#prohibit) at the dashboard level.

{% note info %}

The number of AI queries is limited to 600 queries per user per month. We may consider increasing the limits if needed.

{% endnote %}


## Ban on Neuroanalyst {#prohibit}

{{ datalens-name }} users are able to use Neuroanalyst by default. However, the user with the `{{ roles-datalens-admin }}` role may disable this option at the {{ datalens-short-name }} instance level:
  
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Disable **Neuroanalyst** (on by default). As soon as you do it, the AI assistants will disappear from the {{ datalens-name }} interface for the instance users.



---
title: Neuroanalyst on your dashboard
description: In this article, you will learn about Neuroanalyst on your dashboard and how to use it.
---

# Neuroanalyst on your dashboard

{% note info %}

This feature is at the Beta testing stage.

{% endnote %}


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


Neuroanalyst on your dashboard is a tool that analyzes the selected dashboard chart, generates findings based on its data, and allows you to ask follow-up questions. This data is complemented by the dashboard description and dashboard chart title. For all charts, the chart description and tooltip will also be added, if any.

To enable Neuroanalyst, click ![icon](../../_assets/console-icons/ellipsis.svg) → **Find insights** in the top right corner of the dashboard chart.

{% cut "Neuroanalyst on your dashboard" %}

![image](../../_assets/datalens/release-notes/ai-analytic-on-dashboard.png)

{% endcut %}

All your queries to Neuroanalyst are private: logs are neither stored nor used for further fine-tuning or research.

## Limitations {#restrictions}

* So far the tool can only analyze data from a particular chart.
* The analysis can take quite a while.
* Chart description and tooltip are not added for tables.
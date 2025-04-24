---
title: Semantic attributes
description: In a report, a semantic attribute is the dialog's feature that sets the context for analysis based on a search query. {{ speechsense-name }} analyzes the dialog to see how close it is semantically to the search query in the context of the selected semantic attribute.
---

# Semantic attributes

In a report, a _semantic attribute_ is the dialog's feature that sets the context for analysis based on a search query. {{ speechsense-name }} analyzes the dialog to see how close it is semantically to the search query in the context of the selected semantic attribute. You can enter a search query yourself or choose one of the automatically generated [suggestions](../tags.md#suggestions).

{{ speechsense-name }} operates the following semantic attributes:

* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.reasons-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.results-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.problems }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.operator_keywords }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.client_keywords }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**: Universally applicable reset questions.

{{ speechsense-name }} presents two groups of dialogs in the report: those that do and do not conform to the specified conditions. You choose which one to use in your report. 

> For example, you selected the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** semantic attribute and specified `Vacation in Sochi` as your search query. {{ speechsense-name }} will analyze your dialogs and divide them into two groups depending on whether their topic is aligned semantically with the `Vacation in Sochi` search query.

The semantic attribute application method depends on the report type:

* [Evaluation form](evaluation-form.md): Semantic attributes are available as evaluation parameters and dialog filters.

   If a semantic attribute is used as an evaluation parameter, the report shows the share of dialogs fitting or not fitting the specified property semantically (based on what you select). For more info on how evaluation parameter values are calculated, see [{#T}](evaluation-form.md#form).

   You can only use the semantic attribute once in each report: either as a parameter or as a filter.

* [Comparison](comparison.md) and [Detailing](details.md): Semantic attributes are only available as dialog filters. You can only set a single filter with a semantic attribute.

To use semantic attributes, there must be at least 100 dialogs in the selection for your report. There are no restrictions on the maximum number; however, if the selection contains more than 1,000 dialogs, not all of them will be analyzed. {{ speechsense-name }} will randomly select only 1,000 dialogs for analysis.

For more information on setting up semantic attributes, see [this guide](../../operations/data/manage-reports.md#apply-sense-attribute).

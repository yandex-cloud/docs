---
title: Working with reports
description: Follow this guide to learn how to work with reports in {{ speechsense-name }}.
---

# Working with reports

You can use [{{ speechsense-name }} reports](../../concepts/reports/index.md) to analyze dialogs between agents and customers and evaluate agents' performance. Build a report:

* [{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}](#build-an-evaluation-form): To analyze multiple evaluation parameters.
* [{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}](#build-a-comparison-report): To compare multiple evaluation parameters over time.
* [{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}](#build-a-details-report): To analyze changes in a single evaluation parameter over time.

If you want to use a dialog feature, e.g., reason, topic, or dialog outcome, as a filter or evaluation parameter, [use a semantic attribute in your report](#apply-sense-attribute).

## Building an {{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }} {#build-an-evaluation-form}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.
1. If the project has no saved reports yet, select **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**. If it already contains reports, click **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Set up the evaluation parameter:

   1. In the **{{ ui-key.yc-ui-talkanalytics.reports.parameter.filter }}** field, select the appropriate parameter and specify its value or a range of values.

      Evaluation parameters are used as criteria for assessment of agent performance. For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/evaluation-form.md#parameters).

      If you want to use a dialog feature, e.g., reason, topic, or dialog outcome, as an evaluation parameter, [use a semantic attribute](#apply-sense-attribute).

   1. Under **{{ ui-key.yc-ui-talkanalytics.reports.parameter.weight }}**, specify a percentage.

      Weight indicates how critical a parameter is for agent performance evaluation. The higher the parameter's weight, the greater its value in the report. The total weight of all evaluation parameters must equal 100%. For more information about weight and its use, see [{#T}](../../concepts/reports/evaluation-form.md#weight).

   1. (Optional) In the **{{ ui-key.yc-ui-talkanalytics.reports.parameter.description }}** field, specify the name that will be used to caption the parameter on the chart and in the table. By default, this name matches the **{{ ui-key.yc-ui-talkanalytics.reports.parameter.filter }}** field value.

1. If you need to add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Click **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. To reuse the report, click **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.

## Switching between an {{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }} and dialogs {#go-to-a-dialog}

A report enables you to directly switch to the list of dialogs that meet the criteria specified in the report. This way, you can get more details about dialogs and analyze their specifics.

To switch from a report to a dialog list:

1. [Create a report](#build-an-evaluation-form) **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**.
1. In the report chart, click the rectangle of the evaluation parameter you need. This will open a list of dialogs according to the active filters and the parameter you selected.
1. Go to the dialog of your choice. Its page will show detailed info about the dialog, e.g, the agent's performance data in the form of dialog summary, agent and customer tags, transcript of the audio recognized using {{ speechsense-name }}.

## Building a {{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }} report {#build-a-comparison-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.
1. If the project has no saved reports yet, select **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}**. If it already contains reports, click **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}** and select the one you need.

   For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/comparison.md#parameter).

1. Specify what data you want to get: total of evaluation parameter values, average, minimum, or maximum value of the evaluation parameter.

   In the **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}** report, you can only select numerical evaluation parameters. If you select a [tag](../../concepts/tags.md) as a parameter, the total, average, minimum, or maximum number of times the tag was assigned to dialogs over the specified period will be counted.

1. To add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Click **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. To reuse the report, click **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.

## Building a {{ ui-key.yc-ui-talkanalytics.reports.details-key-value }} report {#build-a-details-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.
1. If the project has no saved reports yet, select **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}**. If it already contains reports, click **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Select the evaluation parameter whose changes you want to view.

   For more information about the parameter and how to generate a report based on it, see [{#T}](../../concepts/reports/details.md#parameter).

1. Specify what data you want to get: total of evaluation parameter values, average, minimum, or maximum value of the evaluation parameter.

   In the **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** report, you can only select numerical evaluation parameters. If you select a [tag](../../concepts/tags.md) as a parameter, the total, average, minimum, or maximum number of times the tag was assigned to dialogs over the specified period will be counted.

1. Click **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. To reuse the report, click **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **{{ ui-key.yc-ui-talkanalytics.reports.reports }}** tab.

## Applying a semantic attribute in a report {#apply-sense-attribute}

A [semantic attribute](../../concepts/reports/sense-attributes.md) is the dialog's feature that sets the context for analysis based on a search query. {{ speechsense-name }} analyzes the dialog to see how close it is semantically to the search query in the context of the selected semantic attribute.

> For example, you select the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** semantic attribute and specify `Vacation in Sochi` as your search query. {{ speechsense-name }} will analyze your dialogs to see whether or not their topic is semantically aligned with `Vacation in Sochi`.

You can apply a semantic attribute in your report:

* As a filter for dialogs (for **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**, **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}**, and **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** reports). The report will include only dialogs either relevant or not relevant to the search query in the context of the selected semantic attribute.

  > For example, you are using the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** semantic attribute and the `Vacation in Sochi` search query as a filter. The report will then include only dialogs whose topic either does or does not match the `Vacation in Sochi` search query, based on your choice.

* As an evaluation parameter (only for **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**). The semantic attribute will be one of the criteria used to evaluate the agent's performance.

  > For example, you are using the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.results-key-value }}** semantic attribute and the `Customer has booked a tour` search query as one of the evaluation parameters. In which case the agent's performance will be evaluated by whether or not the outcome of the dialog matches the `Customer has booked a tour` query.

  You can use a semantic attribute only once in each **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**: either as a parameter or as a filter.

To apply a semantic attribute to dialogs in reports:

{% list tabs %}

- As a filter

  1. In the new report window, click ![image](../../../_assets/console-icons/plus.svg) next to the **{{ ui-key.yc-ui-talkanalytics.common.period }}** field. Select **Semantic attribute** from the drop-down list.
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-period.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-attribute.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/wait-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/apply.md) %}

  1. Once you are satisfied with the grouping, specify which dialog group should be used.

     > For example, if your criterion is **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**, click one of the two buttons:
     >
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply.theme }}** to use only dialogs with the specified topic.
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply-inverted.theme }}** to use dialogs with any topic other than the specified one.

     {% note info %}

     The dialogs presented in the columns will not necessarily match those included in the report, as different periods or filters may have been used to set up the semantic attribute and generate the report.

     {% endnote %}

  You can now add more filters and parameters and build your report.

- As an evaluation parameter

  1. In the new report window, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**. Select **Semantic attribute** from the drop-down list.
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-period.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-attribute.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/wait-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/apply.md) %}

  1. Once you are satisfied with the grouping, specify which dialog group should be used.

     > For example, if your criterion is **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**, click one of the two buttons:
     >
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply.theme }}** to use the match between the dialog and the given topic as an evaluation criterion.
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply-inverted.theme }}** to use the mismatch between the dialog and the given topic as an evaluation criterion.

     {% note info %}

     The dialogs presented in the columns will not necessarily match those included in the report, as different periods or filters may have been used to set up the semantic attribute and generate the report.

     {% endnote %}

  You can now add more parameters and filters and build your report.

{% endlist %}

## Using semantic tags and semantic Pro tags for dialog evaluation {#use-sense-tags-for-dialog-evaluation}

Semantic tags can help you evaluate the agent's performance and the client's behavior, e.g., whether the agent was polite, whether the client was rude, etc. To do this:

1. [Create a semantic tag](../project/tag/create-sense-tag.md). 

   When creating a tag, select the appropriate semantic attribute and specify the relevant search query.

   > For example, if you are interested in dialogs where the customer was rude to the agent, select:
   > * Semantic attribute: **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**.
   > * Search query: **Did the customer show rudeness or aggression in the conversation at least once?**

1. Use a semantic tag as a report parameter.

Semantic Pro tags can help you evaluate the agent's performance and the client's behavior against complex semantic criteria, e.g., whether the agent was able to sell a travel package without offering a discount to the customer. To do this:

1. [Create a semantic Pro tag](../project/tag/create-sense-pro-tag.md). 

   When creating one, specify a relevant search query.

   > For example, if you are looking for dialogs where a client bought a tour to the Maldives with no discount offered, specify the search query as follows: **tour to the Maldives purchased without a discount**.

1. Use the semantic Pro tag as a report parameter.

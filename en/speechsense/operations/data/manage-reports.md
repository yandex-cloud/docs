---
title: Working with reports
description: Follow this guide to learn how to work with reports in {{ speechsense-name }}.
---

# Working with reports

You can use [{{ speechsense-name }} reports](../../concepts/reports/index.md) to analyze dialogs between agents and customers and evaluate agents' performance. Build a report:

* [Evaluation form](#build-an-evaluation-form): To analyze several evaluation parameters.
* [Comparison](#build-a-comparison-report): To compare multiple evaluation parameters over time.
* [Details](#build-a-details-report): To analyze changes in a single evaluation parameter over time.

If you want to use a dialog feature, e.g., reason, topic, or dialog outcome, as a filter or evaluation parameter, [use a semantic attribute in your report](#apply-sense-attribute).

{% note warning %}

Neuroreports will be discontinued starting February 24, 2025. Use [semantic tags](../../concepts/tags.md#sense-tags) instead.

{% endnote %}

## Building the _Evaluation form_ report {#build-an-evaluation-form}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Evaluation form**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Set up the evaluation parameter:

   1. In the **Evaluation parameters** field, select the appropriate parameter and specify a value or a range of values for it.

      Evaluation parameters are used as criteria for assessment of agent performance. For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/evaluation-form.md#parameters).

      If you want to use a dialog feature, e.g., reason, topic, or dialog outcome, as an evaluation parameter, [use a semantic attribute](#apply-sense-attribute).

   1. In the **Weight** field, enter a percentage value.

      Weight indicates how critical a parameter is for agent performance evaluation. The higher the parameter's weight, the greater its value in the report. The total weight of all evaluation parameters must equal 100%. For more information about weight and its use, see [{#T}](../../concepts/reports/evaluation-form.md#weight).

   1. (Optional) In the **Parameter name in report** field, specify the name that will be used to caption the parameter on the chart and in the table. By default, this name matches the **Evaluation parameters** field value.

1. If you need to add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Specify how to group the report data. For example, you can group by product, agent, or customer. Different grouping settings produce different data cross-sections.
1. Select the report generation period.
1. (Optional) Use the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field to select the filters to screen dialogs for the report. For more information about filters, see [{#T}](../../concepts/reports/evaluation-form.md#filters).

   If you want to pick dialogs based on their content, [use a semantic attribute](#apply-sense-attribute) as the filter.

1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Switching between _Evaluation form_ reports and dialogs {#go-to-a-dialog}

A report enables you to directly switch to the list of dialogs that meet the criteria specified in the report. This way, you can get more details about dialogs and analyze their specifics.

To switch from a report to a dialog list:

1. [Build](#build-an-evaluation-form) an **Evaluation form** report.
1. In the report chart, click the rectangle of the evaluation parameter you need. This will open a list of dialogs according to the active filters and the parameter you selected.
1. Go to the dialog of your choice. Its page will show detailed info about the dialog, e.g, the agent's performance data in the form of dialog summary, agent and customer tags, transcript of the audio recognized using {{ speechsense-name }}.

## Building a _Comparison_ report {#build-a-comparison-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Comparison**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**, and select the one you need.

   For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/comparison.md#parameter).

1. Specify what data you want to get: total of evaluation parameter values, average, minimum, or maximum value of the evaluation parameter.

   In the **Comparison** report, you can only select numerical evaluation parameters. If you select a [tag](../../concepts/tags.md) as a parameter, the total, average, minimum, or maximum number of times the tag was assigned to dialogs will be counted for the specified period.

1. To add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Specify how to group the report data. For example, you can group it by agent, customer, or dialog subject. The list of available grouping options depends on the [connection](../../operations/connection/create.md) metadata. You can get different data slices based on the way you group data. The grouping you select only affects how the data is displayed in the table.
1. Select the report generation period.
1. (Optional) Use the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field to select the filters to screen dialogs for the report. For more information about filters, see [{#T}](../../concepts/reports/comparison.md#filters).

   If you want to pick dialogs based on their content, [use a semantic attribute](#apply-sense-attribute) as the filter.

1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Building the _Details_ report {#build-a-details-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Details**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Select the evaluation parameter whose changes you want to view.

   For more information about the parameter and how to generate a report based on it, see [{#T}](../../concepts/reports/details.md#parameter).

1. Specify what data you want to get: total of evaluation parameter values, average, minimum, or maximum value of the evaluation parameter.

   In the **Details** report, you can only select numerical evaluation parameters. If you select a [tag](../../concepts/tags.md) as a parameter, the total, average, minimum, or maximum number of times the tag was assigned to dialogs will be counted for the specified period.

1. Specify how to group the report data. For example, you can group it by agent, customer, or dialog subject. The list of available grouping options depends on the [connection](../../operations/connection/create.md) metadata. You can get different data slices based on the way you group data.
1. Select the report generation period.
1. (Optional) Use the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field to select the filters to screen dialogs for the report. For more information about filters, see [{#T}](../../concepts/reports/details.md#filters).

   If you want to pick dialogs based on their content, [use a semantic attribute](#apply-sense-attribute) as the filter.

1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Applying a semantic attribute in a report {#apply-sense-attribute}

A [semantic attribute](../../concepts/reports/sense-attributes.md) is the dialog's feature that sets the context for analysis based on a search query. {{ speechsense-name }} analyzes the dialog to see how close it is semantically to the search query in the context of the selected semantic attribute.

> For example, you select the **Topics** semantic attribute and specify `Vacation in Sochi` as your search query. {{ speechsense-name }} will analyze your dialogs to see whether their topic is aligned semantically with the `Vacation in Sochi` search query.

To apply a semantic attribute to dialogs in reports:

1. Open the list of evaluation parameters or filters. Select **Semantic attribute**.
1. In the **Semantic attribute setting** window that opens, specify the period to pick the dialogs for. Add filters as needed. As the result, you will see the number of dialogs in the selection for the report. 

   {{ speechsense-name }} will analyze the specified selection of dialogs and generate [suggestions](../../concepts/tags.md#suggestions) for the specified semantic attribute. This requires at least 100 dialogs; otherwise, {{ speechsense-name }} will not be able to conduct a reliable analysis. There are no restrictions on the maximum number; however, if your selection contains more than 1,000 dialogs, {{ speechsense-name }} will randomly select only 1,000 dialogs for analysis.

   If there is not enough or too much data in the selection, adjust the period and your filters. This will change the number of dialogs in the selection.

1. Under **Criteria**, select a semantic attribute.
1. Put the cursor to the right of the semantic attribute in the same line and wait for suggestions to appear.

   {{ speechsense-name }} is now performing semantic analysis of all dialogs selected for the report and generating possible key phrases for the specified semantic attribute. If there are more than 1,000 dialogs in the selection and you are not satisfied with the suggestions that were generated, click **Refresh list** for {{ speechsense-name }} to re-select 1,000 dialogs at random and generate new suggestions.

1. Select one of the suggestions as a search query or enter the text yourself. 

1. Click **Find**.

   {{ speechsense-name }} will now analyze the dialogs again and display the results as two columns representing dialogs that do and do not conform to the specified conditions. Only one of the two mentioned groups can be added to the report.

1. If not satisfied with the suggested dialog grouping, change your semantic attribute or search query. The dialogs will then be regrouped.

   You may need to change your criterion or query a number of times.

1. Once you are satisfied with the grouping, specify which dialog group should be used.

   > For example, if your criterion is **Topics**, click one of the two buttons:
   >
   > * **Containing topic** to use only dialogs on the specified topic.
   > * **Not containing topic** to use dialogs on any topic other than the specified one.

With that done, you can add more filters and parameters and build your report.

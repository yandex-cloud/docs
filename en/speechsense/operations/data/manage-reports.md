---
title: Working with reports
description: Follow this guide to learn how to work with reports in {{ speechsense-name }}.
---

# Working with reports

You can use [{{ speechsense-name }} reports](../../concepts/reports/index.md) to analyze dialogs between agents and customers and evaluate agents' performance. Build a report:

* [Evaluation form](#build-an-evaluation-form): To analyze several evaluation parameters.
* [Comparison](#build-a-comparison-report): To compare multiple evaluation parameters over time.
* [Details](#build-a-details-report): To analyze changes in a single evaluation parameter over time.

If you want to use a reason, topic, or dialog outcome as a filter or evaluation parameter, [use a neuroparameter in your report](#apply-neuro-parameter).

## Building the _Evaluation form_ report {#build-an-evaluation-form}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Evaluation form**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Set up the evaluation parameter:

   1. In the **Evaluation parameters** field, select the appropriate parameter and specify a value or a range of values for it.

      Evaluation parameters are used as criteria for assessment of agent performance. For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/evaluation-form.md#parameters).

      If you want to select a reason, topic, or dialog outcome as an evaluation parameter, [use a neuroparameter](#apply-neuro-parameter).

   1. In the **Weight** field, enter a percentage value.

      Weight indicates how critical a parameter is for agent performance evaluation. The higher the parameter's weight, the greater its value in the report. The total weight of all evaluation parameters must equal 100%. For more information about weight and its use, see [{#T}](../../concepts/reports/evaluation-form.md#weight).

   1. (Optional) In the **Parameter name in report** field, specify the name that will be used to caption the parameter on the chart and in the table. By default, this name matches the **Evaluation parameters** field value.

1. If you need to add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Specify how to group the report data. For example, you can group by product, agent, or customer. Different grouping settings produce different data cross-sections.
1. Select the report generation period.
1. (Optional) Use the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field to select the filters to screen dialogs for the report. For more information about filters, see [{#T}](../../concepts/reports/evaluation-form.md#filters).

   If you want to pick dialogs by their content, [use a neuroparameter](#apply-neuro-parameter) as a filter.

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

   If you want to pick dialogs by their content, [use a neuroparameter](#apply-neuro-parameter) as a filter.

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

   If you want to pick dialogs by their content, [use a neuroparameter](#apply-neuro-parameter) as a filter.

1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Applying a neuroparameter in a report {#apply-neuro-parameter}

A [neuroparameter](../../concepts/reports/neuro-parameters.md) is a dialog property. {{ speechsense-name }} uses it for semantic analysis to determine whether a dialog matches this property. Let's assume you specified a particular topic as a neuroparameter. {{ speechsense-name }} will check whether that topic was mentioned in the dialog.

{% include [preview-note](../../../_includes/note-preview.md) %}

To apply a neuroparameter to dialogs in your reports:

1. Open a list of evaluation parameters or filters. In the list, select **Neuroparameter**.
1. In the **Neuroparameter setting** window that opens, specify the period to pick the dialogs from. Add filters as needed.

   As the result, you will see the number of dialogs in the selection for the report. To apply a neuroparameter, you need at least 100 dialogs. There are no restrictions on the maximum number; however, if the selection contains more than 1,000 dialogs, not all of them will be analyzed. {{ speechsense-name }} will randomly select only 1,000 dialogues for analysis.

   If there is not enough or too much data in the selection, adjust the period and your filters. This will change the number of dialogs in the selection.

1. Under **Criteria**, select the criteria for the service to analyze: **Reasons**, **Topics**, or **Outcomes**.
1. Put the cursor to the row of the selected criterion and wait for options to appear.

   {{ speechsense-name }} will semantically analyze all dialogs in the selection for the report. The service automatically highlights the reasons, topics, or outcomes of all dialogs (depending on which criterion you selected).

1. Select one of the suggested criterion values.

   If none of them are suitable, enter your own. In this case, the specified property will not depend on the choice between reasons, topics, or outcomes.

1. Click **Find**.

   After that, {{ speechsense-name }} will analyze dialogs again and find out which ones meet the specified criterion. The service will put the results of the analysis in two columns: one with dialogs that match the specified neuroparameter and the other one with those that do not. Only one of the two mentioned groups can be added to the report.

1. If the suggested dialog grouping is not satisfactory, change the neuroparameter. The dialogs will then be regrouped.

   You may need to change the criterion more than once.

1. Once you are satisfied with the dialog grouping, specify which group is to be used.

   > For example, if your criterion is **Topics**, click one of the two buttons:
   >
   > * **Containing topic** to use only dialogs on the specified topic.
   > * **Not containing topic** to use dialogs on any topic other than the specified one.

With that done, you can add more filters and parameters and build your report.

# Working with reports

You can use [reports in {{ speechsense-name }}](../../concepts/reports/index.md) to analyze recorded conversations between agents and customers and assess agent performance. Build a report:

* [Evaluation form](#build-an-evaluation-form): To analyze several evaluation parameters.
* [Details](#build-a-details-report): To analyze changes in a single evaluation parameter over time.

## Building the _Evaluation form_ report {#build-an-evaluation-form}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Evaluation form**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Set up the evaluation parameter:

   1. In the **Evaluation parameters** field, select the appropriate parameter and specify a value or a range of values for it.

      Evaluation parameters are used as criteria for assessment of agent performance. For more information about the parameters and how to generate a report based on them, see [{#T}](../../concepts/reports/evaluation-form.md#parameters).

   1. In the **Weight** field, enter a percentage value.

      Weight indicates how critical a parameter is for agent performance evaluation. The higher the parameter's weight, the greater its value in the report. The total weight of all evaluation parameters must equal 100%. For more information about weight and its use, see [{#T}](../../concepts/reports/evaluation-form.md#weight).

   1. (Optional) In the **Parameter name in report** field, specify the name that will be used to caption the parameter on the chart and in the table. By default, this name matches the **Evaluation parameters** field value.

1. To add more evaluation parameters, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Specify how to group the report data. For example, you can group by product, agent, or customer. Different grouping settings produce different data cross-sections.
1. Select the report generation period.
1. (Optional) Using the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field, select filters by which dialogs will be selected for the report. For more information about filters, see [{#T}](../../concepts/reports/evaluation-form.md#filters).
1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Switching between _Evaluation form_ reports and dialogs {#go-to-a-dialog}

A report enables you to directly switch to the list of dialogs that meet the criteria specified in the report. This way, you can get more details about dialogs and analyze their specifics.

To switch from a report to a dialog list:

1. [Build](#build-an-evaluation-form) an **Evaluation form** report.
1. In the report chart, click the rectangle of the evaluation parameter you need. This opens a list of dialogs satisfying the active filters and the selected parameter.
1. Go to the dialog you need. Its page will show the details about it, e.g, the agent's performance results in the dialog summary, agent and customer tags, and the dialog text recognized using {{ speechsense-name }}.

## Building the _Details_ report {#build-a-details-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. Go to the **Reports** tab.
1. Click **Create report** → **Details**.
1. In the window that opens, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Select the evaluation parameter whose changes you want to view.

   For more information about the parameter and how to generate a report based on it, see [{#T}](../../concepts/reports/details.md#parameter).

1. Specify what data you want to get: total of evaluation parameter values, average, minimum, or maximum value of the evaluation parameter.

   In the **Details** report, you can only select numerical evaluation parameters. If you select a [tag](../../concepts/tags.md) as a parameter, the total, average, minimum, or maximum number of times the tag was assigned to dialogs will be counted for the specified period.

1. Specify how to group the report data. For example, you can group by product, agent, or customer. Different grouping settings produce different data cross-sections.
1. Select the report generation period.
1. (Optional) Using the ![image](../../../_assets/console-icons/plus.svg) button next to the **Period** field, select filters by which dialogs will be selected for the report. For more information about filters, see [{#T}](../../concepts/reports/details.md#filters).
1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

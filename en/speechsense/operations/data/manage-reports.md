# Working with reports

You can use [reports in {{ speechsense-name }}](../../concepts/reports.md) to analyze recorded conversations between operators and customers and assess operator performance.

## Creating a report {#build-a-report}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. Go to the **Reports** tab.
1. Click **Create report** and then ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Set up the parameter:

   1. In the **Assessment parameters** field, select the appropriate parameter and specify a value or a range of values for it.

      These parameters are used as criteria for assessment of operator performance. The report will only include information about the parameters you select. For more information about the parameters and how they are used to generate a report, see [{#T}](../../concepts/reports.md#parameters).

   1. In the **Weight** field, enter a percentage value.

      Weight indicates how critical a parameter is for operator performance assessment. The higher the parameter's weight, the greater its value in the report. The total weight of all parameters must equal 100%. For more information on why you need weights and how to use them, see [{#T}](../../concepts/reports.md#weight).

   1. (Optional) In the **Report parameter name** field, enter a name for the parameter to be displayed in the report.

      The report is generated as a chart and table. The **Report parameter name** field value is used to label the parameter in the chart legend and the table column. By default, this value is the same as that of the **Assessment parameters** field.

1. To add more parameters, click ![image](../../../_assets/console-icons/plus.svg) **Add parameter**.
1. Use the ![image](../../../_assets/console-icons/plus.svg) **Add filter** button to set filters to be used to select dialogs for the report. For more information on how to filter dialogs in a more practical way, see [{#T}](../../concepts/reports.md#filters).
1. Select the connection to which you uploaded the required conversation recordings.
1. Specify how to group the report data. For example, you can group by product, operator, or customer. Different grouping settings produce different data cross-sections.
1. Click **Create report**.
1. To reuse the report, click **Save report**. Specify its name and, optionally, a description.

   The report will be available in the selected project in the **Reports** tab.

## Switching between reports and dialogs {#go-to-a-dialog}

Reports enable you to directly switch to the list of dialogs that meet the specified criteria. This way, you can get more details about dialogs and analyze their specifics.

To switch from a report to a dialog list:

1. [Create a report](#build-a-report).
1. In the report chart, click the rectangle of the parameter you need. This opens a list of dialogs satisfying the active filters and the selected parameter.
1. Go to the dialog you need. Its page will show the details about it, e.g, the operator's performance results in the dialog summarization, operator and customer tags, and the dialog text recognized using {{ speechsense-name }}.

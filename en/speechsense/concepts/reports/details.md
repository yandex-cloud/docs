---
title: _Details_ report in {{ speechsense-name }}
---

# _Details_ report in {{ speechsense-name }}

The **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** report shows how the values of the evaluation parameter change over time for each data cross-section. For example, you can build a report based on average dialog duration, group the duration values by departments, and specify the period of one year. As a result, the report will demonstrate how average dialog duration evolved in the course of the year for each department.

## How to build a report {#form}

To generate a **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** report, specify these settings:

* [Evaluation parameter](#parameter): The report will reflect the changes in this parameter.
* [Filters](#filters): Filters applied to dialogs in the report.

With the settings configured, you can now [build a report](../../operations/data/manage-reports.md#build-a-details-report). It will present the evaluation parameter values for multiple data cross-sections in [chart and table](#display) form.

### Evaluation parameter {#parameter}

_Evaluation parameter_: Parameter whose changes you can view in the report. Only numerical parameters are considered. If you select a [tag](../tags.md), its value will be the number of times the tag was assigned to dialogs.

The report considers the total, average, minimum, or maximum value of the evaluation parameter for the selected period. For example, such values may be useful in the following cases:

* Total: How many times the customer asked for a supervisor during the conversation.
* Average: Average dialog duration in seconds.
* Minimum or maximum: Agents with the smallest and largest number of violations.

In the report, you can select an evaluation parameter of one of the following types:

{% include [description-of-parameters](../../../_includes/speechsense/reports/parameters.md) %}

### Filtering in the report {#filters}

{% include notitle [filters](../../../_includes/speechsense/reports/filters.md) %}

## Visualizing and using the report data {#display}

{% include notitle [display](../../../_includes/speechsense/reports/display.md) %}

The available **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** report formats include:

* **{{ ui-key.yc-ui-talkanalytics.reports.barchart }}**: Allows you to visualize the evaluation parameter values at different points in time. On the chart, you can set the report generation period as well as the data detail level. As a result, you can get values for different time intervals: from an hour to a quarter.
* **{{ ui-key.yc-ui-talkanalytics.reports.table-key-value }}**: Shows the numerical value of the evaluation parameter for the specified period. The values are broken down by the customized data grouping.
* **XLSX file**: Contains the same table as in the {{ speechsense-name }} web interface. Use the XLSX format to save the report locally.

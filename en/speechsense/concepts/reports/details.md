---
title: "_Details_ report in {{ speechsense-name }}"
---

# _Details_ report in {{ speechsense-name }}

The **Details** report shows how the values of the evaluation parameter change over time for each data cross-section. For example, you can build a report on the average dialog duration, group its values by departments and specify the period of one year. As a result, the report will show how the average dialog duration changed throughout the year for each department.

## How to build a report {#form}

To generate the **Details** report, specify the following settings:

* [Evaluation parameter](#parameter): Report shows changes in its values.
* [Filters](#filters): Applied to dialogs in the report.

With the settings configured, you can now [build a report](../../operations/data/manage-reports.md#build-a-details-report). It will present the evaluation parameter values for multiple data cross-sections in [chart and table](#display) form.

### Evaluation parameter {#parameter}

_Evaluation parameter_: Parameter whose changes you can view in the report. Only numerical parameters are considered. If you select a [tag](../tags.md), its value will be the number of times the tag was assigned to dialogs.

The report considers the total, average, minimum, or maximum value of the evaluation parameter for the selected period. For example, such values may be useful in the following cases:

* Total: How many times the customer asked to call a supervisor during the conversation.
* Average: Average dialog duration.
* Minimum or maximum: To determine the agent with the least or most violations.

In the report, you can select an evaluation parameter of one of the following types:

{% include [description-of-parameters](../../../_includes/speechsense/reports/parameters.md) %}

### Report filtering {#filters}

{% include notitle [filters](../../../_includes/speechsense/reports/filters.md) %}

## Visualizing and using data in reports {#display}

A report provides quantitative agent performance characteristics. You can view the report in the {{ speechsense-name }} web interface as a chart and table, as well as download it in CSV format.

The available **Details** report formats include:

* **Chart**: Allows you to visualize the evaluation parameter values at different points in time. On the chart, you can set the report generation period as well as the data detail level. As a result, you can get values for different time intervals: from an hour to a quarter.
* **Table**: Shows the numerical value of the evaluation parameter for the specified period. The values are broken down by the customized data grouping.
* **CSV file**: Contains the same table as in the {{ speechsense-name }} web interface. Use the CSV format to save the report locally.

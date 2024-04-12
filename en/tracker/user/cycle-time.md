# Cycle time

A _cycle_ in {{ tracker-full-name }} is the order of issue resolution stages within a specified time period. Each stage refers to a certain status.

The **Cycle time** widget combines two data views related to working with cycles:

* The _**Cycle time** chart_ allows you to analyze the time spent on a workflow. The chart shows the total time spent on all issue stages from the first switching from the initial status to the last switching to the final status.

* _The control chart_ allows you to track deviations from a moving average cycle time calculated from a sample of issues within the specified period.

The widget combines both charts and displays:

* Issues that deviate from the cycle time.
* Cycle time dynamics on the selected percentile and moving average.
* Changes in the issue deviation band from the average cycle time.

To configure a widget, set the following:

* **Name**: Name to display in the widget header.
* **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.
* **Initial statuses**: Statuses in which work on the issue has started.
* **Final statuses**: Statuses in which the issue is considered resolved.
* **Exclude statuses**: Statuses for which the time spent should be excluded from calculations.
* **Automatic update**: Option that automatically rebuilds the widget's charts. The **Step** parameter defines the update frequency.
* **Period**: Period for generating the diagram.
* **Step**: Step value on the axis with period. As a step, you can use days, weeks, months, or sprints.
* **Working hours**: Period of working time during the day. It allows you to exclude non-working hours, weekends, and holidays from the cycle time.
* **Percentile**: Percentage of values in the data sample against which the percentile is calculated.
* **Moving average**: Option that adds an averaged time value line to the chart. It allows you to see the issue going through the cycle by the median. The chart is smoothed for better visualization, so it will not match the 50% percentile chart.
* **Standard deviation**: Option that adds a mean square deviation line to the chart. It can help you estimate how widely the values are scattered from the average. The less the width of the [standard deviation](https://www.youtube.com/watch?v=-YnNEy0odrY) band is, the more stable the command's operation is.

## Displaying issues {#graphs}

On an issue layer, the widget displays issues on the Х and Y axes, where the X axis represents a step, and the Y axis, cycle time.

To prepare the issue layer, {{ tracker-name }} collects the following data:

1. Issues are selected in the widget settings by filtering.
1. Issues are broken down by intervals.
1. Cycle time is calculated for each issue considering excluded statuses and working schedule.
1. Issues within the same step are sorted in ascending order by cycle time.
1. The obtained values are displayed as points.
1. The adjacent issues are collected in a cluster to save the space (a bigger point on the chart).

{% note info %}

When you build or update a chart for the first time, data collection may take a long time.

{% endnote %}

Your issue layer is ready. To perform analysis, you can:

* Select a chart area and zoom in on it.
* Click a point to fix a tooltip with the issue list. Open a tab from the tooltip with a preset filter of such issues to continue searching for system problems in the process.

{% note info %}

You can change the data view by switching the legend items above the chart by pressing **Ctrl** on Windows or **Command** on macOS.

{% endnote %}


---
title: Charts
description: This page covers FAQ about charts.
---

# Charts


{% include [show-top-100-values](../../_qa/datalens/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart](../../_qa/datalens/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart](../../_qa/datalens/hide-legend-in-chart.md) %}

{% include [add-two-indicators](../../_qa/datalens/add-two-indicators.md) %}

{% include [add-columns-signatures](../../_qa/datalens/add-columns-signatures.md) %}

{% include [create-grouped-column-chart](../../_qa/datalens/create-grouped-column-chart.md) %}

{% include [add-column-grouped](../../_qa/datalens/add-column-grouped.md) %}

{% include [number-of-indicators-in-color-section](../../_qa/datalens/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns](../../_qa/datalens/creating-line-chart-with-columns.md) %}

{% include [pie-chart-note](../../_qa/datalens/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../../_qa/datalens/making-logarithmic-scale.md) %}

{% include [sign-last-point](../../_qa/datalens/sign-last-point.md) %}

{% include [sign-multiple-lines](../../_qa/datalens/sign-multiple-lines.md) %}

{% include [resize-column](../../_qa/datalens/resize-column.md) %}

{% include [rename-column](../../_qa/datalens/rename-column.md) %}

{% include [null-setting-in-charts](../../_qa/datalens/null-setting-in-charts.md) %}



### Why do I get null output when creating a multi-dataset chart? {#null-in-multidataset-chart}

Possible causes:

* The `null` value is saved in the database table.
* When joining tables, you get the `null` values if one of the tables is lacking the entries that match the other table's entries according to the joining condition.

If values other than `null` must be displayed for each dataset:

* Make sure you have selected the correct fields when setting up links between datasets.
* Make sure there are no filters in place in the chart or dataset that could limit the resulting selection to data from a single dataset. Remove the filters and check how entries are displayed.
* Check the conditions that are limiting the selection (if an SQL query is used to build the dataset).
* Check alignment between entries from different datasets. Do it by selecting an entry from one dataset and finding a matching entry in the other dataset according to the joining condition. Make sure that values other than `null` are displayed in each dataset in the fields used to build your [multi-dataset chart](../../datalens/operations/chart/create-multidataset-chart.md).
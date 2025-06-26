---
title: Technical fields Measure Names and Measure Values
description: From this article, you will learn about the Measure Names and Measure Values​​ fields and how to use them in the wizard.
---

# Measure Names and Measure Values

When you add a measure to a chart section, two auxiliary fields are added to the list of dataset fields: `Measure Names` and `Measure Values`. They are missing in the original dataset field list, as {{ datalens-short-name }} creates them automatically. The `Measure Names` and `Measure Values` fields are used to create charts with multiple measures.

`Measure Names` is a **dimension** (a green field) that includes **names** of all measures in the chart. It is used to group chart values or show measure names as legends. For example, you can use `Measure Names` to build a column chart grouped by multiple measures or to label sectors in a pie chart.

`Measure Values` is a **measure** (blue field) that includes **values** of all measures in the chart. It is used to label values of each measure. For example, you can use `Measure Values` to label each line in a chart or each column in a column chart.

## Using Measure Names and Measure Values in charts {#usage}

Let's see some examples of how to use `Measure Names` and `Measure Values` in charts. As a data source, we will use a direct [connection](../../quickstart.md#create-connection) to a demo database; the dataset is based on the `SampleSuperstore` table.

**Example 1**

Create a pivot table with total sales across each product category by region.

![image](../../../_assets/datalens/concepts/measure-names-1.png)

Now, let's also use the table to show profit for each category and region. To do this, drag the `Profit` field to **Measures**. The `Measure Names` field will be added automatically to the **Columns** section. This way, you can group your chart by measure names.

![image](../../../_assets/datalens/concepts/measure-names-2.png)

You can edit grouping by table measure names. To do this, drag the `Measure Names` field to the **Rows** section.

![image](../../../_assets/datalens/concepts/measure-names-3.png)

**Example 2**

Let's use the graph to show monthly sales during a year.

![image](../../../_assets/datalens/concepts/measure-values-1.png)

Now let's add a second Y axis to show the profit.

![image](../../../_assets/datalens/concepts/measure-values-2.png)

Add labels with measure values to each line. The chart uses two measures, but you can only add one of them to the **Labels** section. To label each line in this case, add `Measure Values` to **Labels**. Every line will be labeled by values of its measure.

![image](../../../_assets/datalens/concepts/measure-values-3.png)

**Example 3**

Compare the order count and average order value by region. Add the measures to the **Y** section to build a stacked bar chart. The `Measure Names` field will be added automatically to the **Colors** section for grouping by measure name.

![image](../../../_assets/datalens/concepts/measure-names-4.png)

This is not the best way to compare measures, though. Showing an X axis grouped column chart would be a better idea. To do this, drag the `Measure Names` dimension to the **X** section.

![image](../../../_assets/datalens/concepts/measure-names-5.png)

To label each column with its respective measure value, add `Measure Values` to the **Labels** section.

![image](../../../_assets/datalens/concepts/measure-names-6.png)

## Limitations {#restrictions}


The following restrictions apply to the `Measure Names` and `Measure Values` fields:

* You cannot use `Measure Names` and `Measure Values` to filter your chart.
* You can use `Measure Values` to sort data only in the [{#T}](../../visualization-ref/area-chart.md) and [{#T}](../../visualization-ref/normalized-area-chart.md) charts after adding `Measure Names` to the **Colors** section.

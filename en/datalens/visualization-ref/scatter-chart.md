---
title: Scatter chart in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the scatter chart visualization type in {{ datalens-full-name }}.
---

# Scatter chart ![](../../_assets/datalens/scatter-chart.svg) in {{ datalens-full-name }}

A scatter chart shows the relationship between two values (dimensions or measures). Their values are represented as points. 

* A scatter chart always has two axes: the values of one dimension or measure are plotted along the X-axis and those of the other along the Y-axis. A data point that links these two values is displayed at the intersection of the X and Y coordinates.

  These data points can be distributed along the X-axis evenly or unevenly, depending on specific data.

* Use this type of chart if you need to find the dependency between dimensions and measures or show a range of values. For example, the relationship between the average order value and the number of orders for a product.

* You can also represent dependencies on a scatter chart using point sizes. The size of a point depends on the measure value: the higher the value, the larger the point size.

  {% cut "Example" %}

  For example, the size of a point may depend on the discount on a product.

    {% list tabs %}

    - Visualization

      ![scatter-chart](../../_assets/datalens/visualization-ref/scatter-chart/scatter-chart.png =800x)

    - Source table (5 rows)

      Product | Category | Average order value | Number of orders | Discount
      ----|----|----|----|-----|
      Floor cleaner liquid|	Household cleaners|	153.0 | 1 | 0 |
      Multicooker with 40 modes|	Home appliances |	3442.0 | 1 | 0 |
      Liquid detergent for colored clothes|	Household cleaners |	525.0 | 1 | 0 |
      Carpet detergent|	Household cleaners | 463.0 | 1 | 0 |
      Lemon dishwashing liquid|	Household cleaners| 362.0 | 1 | 0 |

      The dataset is built on [Sample ClickHouse](../quickstart.md) connection tables.

    {% endlist %}

    {% endcut %}


* You can use a gradient in a chart by adding a measure to the **Color** section. For example, the higher the product's average check, the darker the point.

  {% cut "Example" %}

  ![scatter-chart](../../_assets/datalens/visualization-ref/scatter-chart/gradient-scatter-chart.png)

  {% endcut %}

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
X | Dimension or measure. Sets the X-axis value. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Y | Dimension or measure. Sets the Y-axis value. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Points | Dimension. Specifies the number of points on the chart.
Point size | Measure. Sets point size depending on the measure value.
Colors | Dimension or measure. Affects the color of points.
Sorting | Dimension. You can only use a dimension from the X axis. Affects the sorting of the X axis. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Filters | Dimension or measure. Used as a filter.

## Creating a scatter chart {#create-diagram}

To create a scatter chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. Select **Scatter chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section.
1. Drag one or more measures from the dataset to the **Y** section. The values will be displayed as points at the intersection of the X and Y axes.

### Additional options

Also, you can:

* Change the color of points:

  1. Drag a dimension or measure to the **Colors** section.
  1. Click ![](../../_assets/console-icons/gear.svg) and set new colors.

* Resize points:

  1. Drag the measure to the **Point size** section.
  1. Click ![](../../_assets/console-icons/gear.svg) and set the minimum and maximum point sizes for the specified measure.

  {% note info %}

  A scatter chart isn't suitable for visualization of data over time.

  {% endnote %}

* Specify an additional dimension. To do this, drag a dimension to the **Points** section.

### Configuring display of null values {#null-settings}

{% include [datalens-chart-null-settings](../../_includes/datalens/datalens-chart-null-settings.md) %}

## Recommendations {#recomendations}

* {% include [datalens-category-text](../../_includes/datalens/datalens-category-text.md) %}
* The axis scale often varies and may start with a value other than 0. Pay attention to value signatures.
* **Colors**. When visualizing multiple measures, select colors carefully. They should be distinguishable and contrasting.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}
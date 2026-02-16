---
title: Tree chart in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the tree chart visualization type in {{ datalens-full-name }}.
---

# Tree chart ![](../../_assets/datalens/treemap.svg) in {{ datalens-full-name }}

A tree chart displays hierarchy data as a set of nested rectangles. 

* Each hierarchy level corresponds to a dimension and is shown as a colored rectangle with nested rectangles.

* The size of the rectangle directly depends on the value of the measure. A chart does not take up much space on a dashboard, even if it contains a lot of data.

{% cut "Example" %}

Sales with a breakdown by product category and subcategory.

{% list tabs %}

- Visualization

    ![tree-chart](../../_assets/datalens/visualization-ref/tree-chart/tree-chart.png)

- Source table

    | Category        | Subcategory         | Sales  |
    |------------------|----------------------|----------|
    | Home appliances | Kitchenware             | 15,000,000 |
    | Home appliances | Beauty and health products   | 17,000,000 |
    | Household goods   | Kitchen products      | 12,000,000 |
    | Household goods   | Essential goods | 8,000,000  |
    | Household cleaners    | Detergents      | 4,100,000  |
    | Household cleaners    | Cleaners    | 3,300,000  |

{% endlist %}

{% endcut %}


## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Dimensions | Dimensions. Determines the hierarchy tree of nested rectangles. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Size | Measure. One measure that determines the area of a rectangle.
Colors | Dimension or measure. Affects the shading of rectangles in a chart.
Filters | Dimension or measure. Used as a filter.

## Creating a tree chart {#create-diagram}

To create a tree chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. Select **Tree chart** as the chart type.
1. Drag one or more dimensions from the dataset to the **Dimensions** section.
1. Drag a measure from the dataset to the **Size** section. 
    The values will be displayed as rectangles. The areas of the rectangles are proportional to the corresponding values of the selected measure.
1. Drag a measure or dimension from the **Dimensions** section to the **Color** section.
    As a result, the rectangles will be colored depending on the value of the added measure or dimension. A dimension that you can add to the **Color** section must be from the **Dimensions **section.
1. Drag a dimension or measure from the dataset to the **Filters** section.
    The field can be empty. In this case, no filters are applied.

## Recommendations {#recommendations}

* Use this type of chart to show the relationship between a part and a whole.
* If there are few categories (up to six), use a pie or donut chart.
* You cannot display negative values on a tree chart.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}
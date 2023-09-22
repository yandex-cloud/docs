# Tree chart

A tree chart displays hierarchy data as a set of nested rectangles. Each hierarchy level corresponds to a dimension and is represented as a colored rectangle with nested rectangles. The size of each rectangle depends on the measure value: the higher the value, the larger the size. A chart doesn't take up much space on a dashboard even if there is a large amount of data.

For example, you can use a tree chart to visually represent sales by product category and subcategory.

![tree-chart](../../_assets/datalens/visualization-ref/tree-chart/tree-chart.png)

{% cut "Source table" %}

| Category | Subcategory | Sales |
|------------------|----------------------|----------|
| Home appliances | Kitchenware | 15000000 |
| Home appliances | Beauty and health products | 17000000 |
| Household goods | Kitchen products | 12000000 |
| Household goods | Essential goods | 8000000 |
| Household cleaners | Detergents | 4100000 |
| Household cleaners | Cleaners | 3300000 |

{% endcut %}

## Sections in the wizard {#wizard-sections}

| Section<br/> in the wizard | Description |
----- | ----
| Dimensions | Dimensions. Determines the hierarchy tree of nested rectangles. |
| Size | Measure. One measure that determines the area of a rectangle. |
| Colors | Dimension or measure. Affects the shading of rectangles in a chart. |
| Chart filters | Dimension or measure. Used as a filter. |

## Creating a tree chart {#create-diagram}

To create a tree chart:

1. On the {{ datalens-full-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select a dataset for visualization.
1. Select **Tree chart** as the chart type.
1. Drag one or more dimensions from the dataset to the **Dimensions** section.
1. Drag a measure from the dataset to the **Size** section. The values are displayed as rectangles. The areas of the rectangles are proportional to the corresponding values of the selected measure.
1. Drag a measure or dimension from the **Dimensions** section to the **Colors** section. As a result, the rectangles are colored depending on the value of the added measure or dimension. A dimension that you can add to the **Colors** section must be from the **Dimensions **section.
1. Drag a dimension or measure from the dataset to the **Chart filters** section. The field can be empty. In this case, no filters are applied.

## Recommendations {#recommendations}

* Use this type of chart to show the relationship between a part and a whole.
* If there are few categories (up to 6), use a pie or donut chart.
* You can't display negative values on a tree chart.
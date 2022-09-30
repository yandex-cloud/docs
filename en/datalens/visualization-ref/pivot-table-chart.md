# Pivot table ![](../../_assets/datalens/pivot-table.svg)

A table is a standard form of data representation with as many details as possible. Tables are most suitable for detailed analysis (a deep dive into figures) and problem detection. It's best to place tables at the end of a dashboard. Graphical representations are simpler for reading information, while tables take you deeper into the data and require more time to read.

Unlike a flat [table](table-chart.md), categories in a pivot table can be stored both in columns and rows. They may contain multiple categories, while cells at their intersection contain measure values.

Pivot tables make it easier to work with large amounts of data and let you analyze the relationship between different measures. For example, you can use this type of table to analyze product sales depending on the delivery type by brand and product category over a specific year.

![pivot-table-chart](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-chart.png)

{% cut "Source table" %}

| Categories | Product brand | Delivery type | 2019 | 2020 | 2021 | 2022 |
---------|---------|---------|---------|---------|---------|---------
| Household cleaners | BioDom | Delivery | 286192 | 836276 | 1398283 | 952801 |
| Household cleaners | City Driver | Delivery | 248020 | 699284 | 1074216 | 705072 |
| Household cleaners | Moydodyr | Delivery | 199737 | 532997 | 1090102 | 807578 |
| Household cleaners | Chistyy Dom | Delivery | 400993 | 1016930 | 1658254 | 1092608 |
| Household cleaners | BioDom | Pickup | 795267 | 2112453 | 3138349 | 2184422 |
| Household cleaners | City Driver | Pickup | 574643 | 1665665 | 2544045 | 1843545 |
| Household cleaners | Moydodyr | Pickup | 503241 | 1455449 | 2441103 | 1632025 |
| Household cleaners | Chistyy Dom | Pickup | 815338 | 2446136 | 3710564 | 2837481 |
| Household goods | 1001 necessary small things | Delivery | 701548 | 1630965 | 2592784 | 1947613 |
| Household goods | Cedar wood | Delivery | 257459 | 829961 | 1226510 | 873104 |
| Household goods | Rostov factory | Delivery | 111812 | 220937 | 584077 | 272213 |
| Household goods | Hleb-Sol | Delivery | 557311 | 1273523 | 2394572 | 1615675 |
| Household goods | 1001 necessary small things | Pickup | 1499384 | 3880210 | 6257665 | 4351725 |
| Household goods | Cedar wood | Pickup | 703202 | 1922952 | 2935546 | 2323846 |
| Household goods | Rostov factory | Pickup | 215243 | 619117 | 1078515 | 780640 |
| Household goods | Hleb-Sol | Pickup | 1053432 | 3469672 | 5271466 | 3754047 |
| Home appliances | Kitchen&Food | Delivery | 307919 | 926118 | 1413174 | 1063128 |
| Home appliances | TechBeauty | Delivery | 271553 | 768793 | 1192747 | 809543 |
| Home appliances | Razumnyy Dom | Delivery | 828609 | 2320160 | 3747059 | 2672810 |
| Home appliances | Fabrika Komforta | Delivery | 364309 | 1103700 | 1674297 | 1146209 |
| Home appliances | Kitchen&Food | Pickup | 803667 | 2254885 | 3065383 | 2243507 |
| Home appliances | TechBeauty | Pickup | 623684 | 1675606 | 2891334 | 2029385 |
| Home appliances | Razumnyy Dom | Pickup | 1917822 | 5520617 | 8538419 | 6468868 |
| Home appliances | Fabrika Komforta | Pickup | 1072286 | 2170431 | 4178690 | 2827290 |

{% endcut %}

## Sections in the wizard {#wizard-sections}

| Section<br/> in the wizard | Description |
----- | ----
| Columns | Dimensions. |
| Rows | Dimensions. |
| Measures | Measures. If you add more than one measure to a section, the **Columns** section contains the [Measure Names](../concepts/chart/measure-values.md) dimension that defines the location of the measure headers. [Measure Names](../concepts/chart/measure-values.md) can be moved to **Rows**. |
| Colors | Measure. Affects shading of all cells containing indicators. It may only contain one measure. |
| Sorting | Dimensions and measures specified in the **Columns** and **Rows** sections.<br/>You can use multiple dimensions and measures.<br/>The order of section fields affects the sorting order of table fields. |
| Chart filters | Dimension or measure. Used as a filter. |

## Creating a pivot table {#create-diagram}

{% note info %}

Not supported in [QL charts](../concepts/chart/index.md#sql-charts).

{% endnote %}

To create a pivot table:

1. On the {{ datalens-full-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select a dataset for visualization.
1. Select the **Pivot table** chart type.
1. Drag a dimension from the dataset to the **Columns** section.
1. Drag a dimension from the dataset to the **Rows** section.
1. Drag a measure from the dataset to the **Measures** section. The values are displayed in the table cells.
1. Drag a measure from the dataset to the **Colors** section. Cells with the measure are filled in with a color from the color gradient, depending on the measure value.

## Additional settings {#additional-settings}

### Renaming columns {#change-column-names}

1. Under **Columns**, click the icon to the left of the dimension or measure name.
1. In the window that opens, change the **Name** field value and click **Apply**.

### Adding a row with totals {#add-totals}

1. In the left part of the screen, click ![image](../../_assets/datalens/gear.svg) next to the chart type.
1. Enable the **Totals** settings.
1. Click **Apply**.

The **Total** row is displayed in the table. Values in the row are calculated using the same formulas as [aggregation](../concepts/dataset/data-model.md#aggregation) in the measure.

{% note info %}

* Values in the row with totals are calculated only for measures. For dimensions, the row is empty.
* The **Total** row doesn't support filtering by [measure](../concepts/dataset/data-model.md#field). You can hide the **Total** row by dragging a measure to the **Filters** or **Dashboard filters** section.
* Calculations using [LOD expressions](../concepts/lod-aggregation.md), [window functions](../function-ref/window-functions.md), and [time series functions](../function-ref/time-series-functions.md) may not work correctly in the row with totals.

{% endnote %}

## Recommendations {#recomendations}

* Use a pivot table to represent aggregate data in table format.
* Place dimensions on the left and measures on the right. This facilitates information perception.
* Make sure column names you use are short and easy to read.
* Limit the size of a table, or use filters or sorting. It's hard to read tables with a large number of rows or columns.
* You can color table cells depending on the values of a measure. This will emphasize them.
* Use tables for their intended purpose only. Don't try to replace all visual data representation forms with them.
* When posting a table on a dashboard, enable auto height in the widget settings. This will help you save dashboard space.

  {% cut "Setting up auto height" %}

  ![pivot-table-auto-height](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-auto-height.png)

  {% endcut %}

  If you use a filter, the table height will automatically adapt to the number of rows.

  {% cut "Using a filter with the auto height option enabled" %}

  If no value is set in the filter, a table displays all rows depending on the limit to the number of rows per page.

  ![pivot-table-auto-height-2](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-auto-height-2.png)

  If the number of displayed rows decreases when using the filter, the table height is reduced automatically.

  ![pivot-table-auto-height-3](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-auto-height-3.png)

  {% endcut %}

* Represent totals (or subtotals) as a column. To do this, use calculated fields based on [window functions](../concepts/window-function-tutorial.md) or [LOD expressions](../concepts/lod-aggregation.md). For example:

  * Subtotal amount of sales by product category: the `CategorySales` measure with the formula `SUM(SUM([Sales]) WITHIN [ProductCategory])`.
  * Total sales: the `TotalSales` measure with the formula `SUM(SUM([Sales]) TOTAL)`.

    {% cut "Sample table" %}

    ![pivot-table-sum](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-sum.png)

    {% endcut %}

  * Maximum order count per month grouped by product category: the `MaxCountByCategory` measure with the formula `MAX(COUNTD([OrderID] INCLUDE [ProductCategory]))`.

    {% cut "Sample table" %}

    ![pivot-table-count](../../_assets/datalens/visualization-ref/pivot-table-chart/pivot-table-count.png)

    {% endcut %}

* Use sorting. This facilitates information perception.
* Use the [URL](../function-ref/URL.md) function in table cells to enable users to follow a link.
* When displaying numeric data, specify units and the number of decimal places. For example, if you select `Millions, M` in the drop-down list of the **Units** field, the `10.3 M` value is displayed instead of `10,345,234.23` . If you set the `Precision` field value to `2`, then `123.12` is displayed instead of `123.1234`.

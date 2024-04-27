# Table ![](../../_assets/datalens/table-chart.svg)

A table is a standard form of data representation with as many details as possible. It stores data as a two-dimensional array that consists of columns and rows. Table column headers show dimension or measure names, while cells contain their values. Each row is a set of cells with each column's value. A table may also contain a row with results.

Tables are a great tool for detailed analysis (a deep dive into figures) and problem detection. At the same time, it takes longer to read information from a table than from a graph or chart. Therefore, it is a good idea to place it at the end of a dashboard.

A table is a good choice for quantitative comparison, where you can see different values of multiple categories or dimensions. The table below shows three different measures by three categories.

![table-chart](../../_assets/datalens/visualization-ref/table-chart/table-chart.png)

{% cut "Source table" %}

| Categories | Subcategories | Delivery type | Sales | Number of customers | Number of orders |
---------|---------|---------|---------|---------|---------				
| Household cleaners | Detergents | Delivery | 597729 | 250 | 256 |
| Household cleaners | Detergents | Pickup | 1352690 | 521 | 550 |
| Household cleaners | Cleaners | Delivery | 541911 | 225 | 230 |
| Household cleaners | Cleaners | Pickup | 1348868 | 493 | 518 |
| Household goods | Beauty and health products | Delivery | 263891 | 132 | 134 |
| Household goods | Beauty and health products | Pickup | 706423 | 321 | 333 |
| Household goods | Kitchen products | Delivery | 671566 | 165 | 167 |
| Household goods | Kitchen products | Pickup | 1283731 | 289 | 297 |
| Household goods | Non-essential goods | Delivery | 701818 | 210 | 213 |
| Household goods | Non-essential goods | Pickup | 1521937 | 447 | 475 |
| Home appliances | Kitchenware | Delivery | 829157 | 213 | 218 |
| Home appliances | Kitchenware | Pickup | 2048211 | 482 | 513 |
| Home appliances | Health and beauty equipment | Delivery | 944770 | 255 | 258 |
| Home appliances | Health and beauty equipment | Pickup | 2387410 | 550 | 581 |

{% endcut %}

To simplify the comparison of different values and make the information easier to comprehend, you can use advanced settings when [creating a table](#create-diagram):

* [Renaming table columns](#change-columns-names).
* [Setting up table data sorting by multiple columns](#sorting-columns).
* [Setting up the width of table columns](#set-column-width).
* [Adding a row with totals](#add-totals).
* [Adding row color](#add-column-colour).
* [Setting up a field fill color](#set-field-colour).
* [Adding a linear indicator to a column with a measure](#add-linear-indicator).

## Sections in the wizard {#wizard-sections}

| Wizard<br/>section | Description |
----- | ----
| Columns | Dimensions and measures to be used as columns. The field name appears in the column header. You can use [markup functions](../function-ref/markup-functions.md) in columns. |
| Colors | Measure. Affects shading of all cells within a row. It may only contain one measure. |
| Sorting | Dimensions and measures specified in the **Columns** section.<br/>You can use multiple dimensions and measures.<br/>The order of section fields affects the sorting order of table fields. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon. |
| Filters | Dimension or measure. Used as a filter. |

## Creating a table {#create-diagram}

To create a table:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select the **Table** chart type.
1. Drag a dimension or measure from the dataset to **Columns**. The field is displayed as a column.

   {% note info %}

   * After dragging a **Tree of strings** dimension to the **Columns** section, you will see a [tree hierarchy](../concepts/data-types.md#how-to-create-tree) in the visualization area.
   * You can change the order of columns by dragging dimensions in the **Columns** section.

   {% endnote %}

## Additional settings {#additional-settings}

### Renaming table columns {#change-columns-names}

1. Under **Columns**, click the icon to the left of the dimension or measure name.
1. In the window that opens, change the **Name** field value and click **Apply**.

### Setting up table data sorting by multiple columns {#sorting-columns}

1. On the left side of the screen above the chart, click ![image](../../_assets/console-icons/gear.svg).
1. Enable the **Pagination** setting and click **Apply**.
1. Press and hold **Ctrl** while clicking the headers of columns to change the sorting for.

### Setting up the width of table columns {#set-column-width}

1. In the top-right corner of the **Columns** section, click ![image](../../_assets/console-icons/gear.svg) (the icon is displayed when you hover over the section).
1. In the **Column width** window that opens, set up the width of each column:

   * `Auto`: Automatic column width.
   * `%`: Column width as a percentage of the table's total width.
   * `px`: Column width in pixels.

   The `%` and `px` options let you make a table cell break (by word). This may increase the number of rows in a cell.

   {% cut "Sample column width settings" %}

   ![image](../../_assets/datalens/operations/chart/table-column-setting.png)

   {% endcut %}

   {% note info %}

   The total width of a table always takes up 100% of available space regardless of the specified width of individual columns.

   {% endnote %}

1. Click **Apply**.

To set the width of any column to `Auto`, click **Reset**.

### Adding a row with totals {#add-totals}

1. On the left side of the screen above the chart, click ![image](../../_assets/console-icons/gear.svg).
1. Enable the **Totals** settings.

The **Total** row is displayed in the table. Values in the row are calculated using the same formulas as [aggregation](../concepts/dataset/data-model.md#aggregation) in the measure.

{% note info %}

Values in the **Total** row are calculated only for measures. For dimensions, the row is empty.

{% endnote %}

### Adding row colors {#add-column-colour}

1. Drag a measure to the **Color** section.
1. In the top-right corner of the **Color** section, click ![image](../../_assets/console-icons/gear.svg) (the icon is displayed when you mouse over the section).
1. Set up colors:

   * **Gradient type**: Select two or three colors.
      * Gradient color: Select a color palette for the gradient from the list.
      * Gradient direction: Change the gradient direction using the ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) icon.
   * **Set threshold values**: Set numeric thresholds for each color.

### Setting up a field fill color {#set-field-colour}

1. Under **Columns**, click the icon to the left of the dimension or measure name.
1. In the window that opens, enable **Column fill color**.
1. In the **By field** list, select the field whose values the fill will be based on.
1. Set the **Fill type**:

   {% note info %}

   You can use the **Palette** type for dimensions and the **Gradient** type for measures.

   {% endnote %}

   {% list tabs group=fill %}

   - For a dimension {#measure}

      1. Click the color scheme selection field and set a color for each dimension value.
      1. Click **Apply**.

   - For a measure {#indicator}

      1. Click the gradient selection field and set up:

         * **Gradient type**: Select two or three colors.

            * Gradient color: Select a color palette for the gradient from the list.
            * Gradient direction: Change the gradient direction using the ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) icon.

         * **Set threshold values**: Set numeric thresholds for each color.

      1. Click **Apply**.

   {% endlist %}

1. Click **Apply**.

### Adding a linear indicator to a column with a measure {#add-linear-indicator}

1. Under **Columns**, click the icon to the left of the measure name.
1. In the window that opens, enable **Linear indicator**.
1. Specify the indicator settings:

   * **Fill type**: Type of fill color for the indicator.
   * **Positive values**: Indicator color for positive values.
   * **Negative values**: Indicator color for negative values.
   * **Show labels**: This option enables displaying measure values in a cell.
   * **Show in totals**: This option enables displaying the indicator in cells with totals.
   * **Align**: Left or right alignment of the indicator position in a column. Only applies if all numbers in a column are either positive or negative.
   * **Scale**: Sets the indicator scale. If you set it manually, specify the **min** and **max** values. Make sure the **min** value is less than or equal to `0` and the **max** value is larger than or equal to `0`.

   {% cut "Sample linear indicator settings" %}

   ![image](../../_assets/datalens/operations/chart/table-linear-indicator-setting.png)

   {% endcut %}

1. Click **Apply**.

{% cut "Sample chart with a linear indicator" %}

![image](../../_assets/datalens/operations/chart/table-linear-indicator.png)

{% endcut %}

## Recommendations {#recomendations}

* Limit the size of your tables or use filters/sorting. Tables with too many rows or columns are hard to read.
* Use tables for their intended purpose only. Do not replace all data visualization types with them.
* Place dimensions on the left and measures on the right. This makes the data easier to comprehend.
* Make sure column names you use are short and readable.
* Enable the display of totals at the bottom of a table. If the **Pagination** option is selected, the `Total` row is placed on the last page.

   {% cut "Table with totals and pagination" %}

   ![table-pagination](../../_assets/datalens/visualization-ref/table-chart/table-pagination.png)

   {% endcut %}

* When posting a table on a dashboard, enable auto height in the widget settings. This will help you save dashboard space.

   {% cut "Setting up auto height" %}

   ![table-auto-height](../../_assets/datalens/visualization-ref/table-chart/table-auto-height.png)

   {% endcut %}

   If you use a filter, the table height will automatically adapt to the number of rows.

   {% cut "Using a filter with the auto height option enabled" %}

   If no value is set in the filter, a table displays all rows depending on the limit to the number of rows per page.

   ![table-auto-height-2](../../_assets/datalens/visualization-ref/table-chart/table-auto-height-2.png)

   If the number of displayed rows decreases when using the filter, the table height is reduced automatically.

   ![table-auto-height-3](../../_assets/datalens/visualization-ref/table-chart/table-auto-height-3.png)

   {% endcut %}

* Represent totals (or subtotals) as a column. To do this, use calculated fields based on [window functions](../concepts/window-function-tutorial.md) or [LOD expressions](../concepts/lod-aggregation.md). For example:

   * Subtotal amount of sales by product category: the `CategorySales` measure with the formula `SUM(SUM([Sales]) WITHIN [ProductCategory])`.
   * Total sales: the `TotalSales` measure with the formula `SUM(SUM([Sales]) TOTAL)`.

      {% cut "Sample table" %}

      ![table-sum](../../_assets/datalens/visualization-ref/table-chart/table-sum.png)

      {% endcut %}

   * Maximum order count per month grouped by product category: the `MaxCountByCategory` measure with the formula `MAX(COUNTD([OrderID] INCLUDE [ProductCategory]))`.

      {% cut "Sample table" %}

      ![table-count](../../_assets/datalens/visualization-ref/table-chart/table-count.png)

      {% endcut %}

* Use sorting. This makes the data easier to comprehend.
* Use the [URL](../function-ref/URL.md) function in table cells to enable users to follow a link.

* If a table cell contains a long text, [set up](#additional-settings) the column width to enable a row break in cells.

   {% cut "Setup example" %}

   ![table-column-width](../../_assets/datalens/visualization-ref/table-chart/table-column-width.png)

   {% endcut %}

* When displaying numeric data, specify units and the number of decimal places. For example, if you select `Millions, M` in the drop-down list of the **Units** field, the `10.3 M` value is displayed instead of `10,345,234.23`. If you set the `Precision` field value to `2`, then `123.12` is displayed instead of `123.1234`.

---
title: How to add a hierarchy to charts in {{ datalens-full-name }}
description: Follow this guide to add a hierarchy to charts in {{ datalens-full-name }}.
---

# Adding a hierarchy to charts in {{ datalens-full-name }}

{% note info %}

* You cannot use hierarchies in **Map**, **Indicator**, and **Pivot table** charts.
* You can only add one hierarchy to a chart.

{% endnote %}

To add a hierarchy:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}



1. In the left-hand panel, click ![image](../../../_assets/console-icons/chart-column.svg) **Charts** and select the chart to add a hierarchy to.



1. On the left side of the screen above the list of dimensions and measures, click ![image](../../../_assets/console-icons/plus.svg) and select **Hierarchy**.

   ![screenshot](../../../_assets/datalens/chart/chart-add-hierarchy.png)

1. Enter the hierarchy name, select dimensions, and arrange them as needed.

   ![screenshot](../../../_assets/datalens/chart/chart-hierarchy-settings.png)

1. In the bottom-right corner, click **Save**.
1. Drag your hierarchy to any available section. For example, for a **Table** chart, you can use the **Columns** section.
1. Drag other dimensions and measures to the appropriate sections.
1. In the top-right corner, click **Save**.

## Example of adding a hierarchy {#add-hierarchy-example}

As our data source, we will use a {{ CH }} demo database with a Moscow retail chain's sales data. For an example of creating a connection and dataset, see [this guide](../../quickstart.md).

1. In the top-right corner of the dataset, click **Create chart**.
1. Select the **Donut chart** visualization type.
1. Add a sales measure to the chart. To do this, drag the `Sales` field from **Measures** to the **Measures** section.
1. On the left side of the screen above the list of dataset fields, click ![image](../../../_assets/console-icons/plus.svg) and select **Hierarchy**.
1. Enter `Products` as the hierarchy name and select the dimensions in the following order: `ProductCategory`, `ProductSubcategory`, `ProductBrand`, and `ProductName`.

   ![add-hierarchy](../../../_assets/datalens/operations/chart/add-hierarchy.svg)

1. In the bottom-right corner, click **Save**.
1. Drag your hierarchy to the **Color** section.

1. Save the chart:

   1. In the top-right corner, click **Save**.
   1. In the window that opens, enter **Donut chart with hierarchy** as the chart name and click **Save**.

Adding the hierarchy to the chart will allow you to switch between levels of detail: **ProductCategory** → **ProductSubcategory** → **ProductBrand** → **ProductName**.

Check out some examples of charts with a hierarchy on [our ready-made dashboard](https://datalens.yandex/9fms9uae7ip02?tab=MNb).

#### See also {#see-also}

* [{#T}](../../dataset/data-types.md#how-to-create-tree).

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}

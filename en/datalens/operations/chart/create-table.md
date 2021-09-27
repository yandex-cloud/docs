# Creating a table

To create a table:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select the **Table** chart type.
1. Drag a dimension or measure from the dataset to the **Columns** section. The field is displayed as a column.

You can also change the names of table columns:

1. Under **Columns**, click the icon to the left of the dimension or measure name.
1. In the window that opens, change the **Name** field value and click **Apply**.

You can also add a row with total values to a table:

1. In the left part of the screen above the chart, click ![image](../../../_assets/datalens/gear.svg).
1. Enable the **Totals** settings.

The **Total** row is displayed in the table. Values in the row are calculated using the same formulas as [aggregation](../../concepts/dataset/data-model.md#aggregation) in the measure.

{% note info %}

Values in the **Total** row are calculated only for measures. For dimensions, the row is empty.

{% endnote %}
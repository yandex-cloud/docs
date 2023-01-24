# Creating a multi-dataset chart

{% note info %}

In multi-dataset charts, only linked dimensions (available in all datasets) can be used.

{% endnote %}

To create a [multi-dataset chart](../../concepts/chart/index.md#multi-dataset-charts):
1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset for visualization. If you don't have a dataset, [create one](../dataset/create.md).
1. Add another dataset. To do this, under the dataset list, click **Add dataset** and select the dataset to visualize.
1. When you add a {{ datalens-short-name }} dataset, a link is automatically created based on the first field name and data type match. In the resulting dataset link configuration window, click **Save**.
1. Repeat steps 3-4 as required.
1. Select your chart type, such as **Line chart**.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag measures from different datasets to the **Y** section. The values are displayed as charts on the Y-axis.
1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.


{% cut "Example of creating a multi-dataset chart" %}


{% include [datalens-multidataset-chart-example](../../../_includes/datalens/datalens-multidataset-chart-example.md) %}

{% endcut %}


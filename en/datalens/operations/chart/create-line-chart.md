# Creating a line chart

To create a line chart:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select **Line chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag one or more indicators from the dataset to the **Y** section. The values are displayed as a chart on the Y-axis.

   {% include [chart-signature-note](../../../_includes/datalens/operations/datalens-chart-signature-note.md) %}

1. Drag a dimension to the **Colors** section. The measure value is divided by color depending on the selected dimension.
1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.

## Configuring the display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../../_includes/datalens/datalens-chart-null-settings.md) %}

Learn more about chart sections in [{#T}](../../concepts/chart/types.md#line-chart).
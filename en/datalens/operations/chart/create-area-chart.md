# Creating an stacked area chart

To create an stacked area chart:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select **Stacked area chart** or **Normalized stacked area chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag one or more measures from the dataset to the **Y** section. The values are displayed as chart areas on the Y-axis.

   {% include [chart-signature-note](../../../_includes/datalens/operations/datalens-chart-signature-note.md) %}

Learn more about the chart sections in [{#T}](../../concepts/chart/types.md#area-chart) and [{#T}](../../concepts/chart/types.md#normalized-area-chart).

## Configuring the display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../../_includes/datalens/datalens-chart-null-settings.md) %}

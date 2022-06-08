# Creating a column chart

To create a column chart:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select **Column chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag one or more indicators from the dataset to the **Y** section. The values are displayed as columns on the Y-axis.

   {% include [chart-signature-note](../../../_includes/datalens/operations/datalens-chart-signature-note.md) %}

A stacked column chart is displayed by default.

Learn more about the chart sections in [{#T}](../../concepts/chart/types.md#bar-chart) and [{#T}](../../concepts/chart/types.md#normalized-bar-chart).

## Creating a grouped column chart {#grouped-column-chart}

To display an X-axis grouped column chart:

1. Go to the column chart that you created.

1. Depending on the number of measures in the **Y** section, follow these steps:

    {% list tabs %}

    - One measure
        1. Check if there is a dimension in the **Colors** section.
        1. Duplicate this dimension in the **X** section. The sequence of dimensions affects the grouping order.

      <iframe src="https://datalens.yandex/3qmmquiu7i1ux?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>

    - Two or more measures
        1. Drag the `Measure Names` dimension to the **Colors** section.
        1. Drag the `Measure Names` dimension to the **X** section. The sequence of dimensions affects the grouping order.

      <iframe src="https://datalens.yandex/tgc7ep00pz26n?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>

    {% endlist %}

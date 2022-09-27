# Creating a bar chart

To create a bar chart:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select **Bar chart** as the chart type.
1. Drag one or more dimensions from the dataset to the **Y** section. The values are displayed on the Y-axis.

   {% include [chart-signature-note](../../../_includes/datalens/operations/datalens-chart-signature-note.md) %}

1. Drag one or more measures from the dataset to the **X** section.

A stacked column chart is displayed by default.

Learn more about the chart sections in [{#T}](../../concepts/chart/types.md#horizontal-bar-chart) and [{#T}](../../concepts/chart/types.md#normalized-horizontal-bar-chart).

## Creating a grouped bar chart {#grouped-bar-chart}

To display an Y-axis grouped bar chart:

1. Go to the bar chart that you created.
1. Depending on the number of measures in the **X** section, follow these steps:

   {% list tabs %}

   - One measure

     1. Check if there is a dimension in the **Colors** section.
     1. Duplicate this dimension in the **Y** section. The sequence of dimensions affects the grouping order.

     <iframe src="https://datalens.yandex/5th7z71ms5w6z?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>

   - Two or more measures

     1. Drag the `Measure Names` dimension to the **Colors** section.
     1. Drag the `Measure Names` dimension to the **Y** section. The sequence of dimensions affects the grouping order.

     <iframe src="https://datalens.yandex/0oxyakxold4gu?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>

    {% endlist %}

## Configuring the display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../../_includes/datalens/datalens-chart-null-settings.md) %}

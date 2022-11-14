# Creating a multi-dataset chart

{% note info %}

In multi-dataset charts, only linked dimensions (available in all datasets) can be used.

{% endnote %}

To create a [multi-dataset chart](../../concepts/chart/index.md#multi-dataset-charts):
1. {% if product == "yandex-cloud" %}On the {{ datalens-full-name }} homepage, click **Create chart**.{% endif %}{% if product == "cloud-il" %}Open the [{{ datalens-short-name }} homepage]({{ link-datalens-main }}).{% endif %}
1. {% if product == "yandex-cloud" %}Under **Dataset**, select a dataset for visualization. If you don't have a dataset, [create one](../dataset/create.md).{% endif %}{% if product == "cloud-il" %}Go to the [workbook](../../concepts/index.md#workbooks-and-collections) where you want to create a multi-dataset chart.{% endif %}
1. {% if product == "cloud-il" %}1. On the workbook page, click **Create** → **Chart in Wizard** in the upper-right corner.{% endif %}
1. {% if product == "cloud-il" %}1. In the **Select dataset** field, select a dataset from the list.{% endif %}
1. Add another dataset. To do this, under the dataset list, click **Add dataset** and select the dataset to visualize.
1. When you add a {{ datalens-short-name }} dataset, a link is automatically created based on the first field name and data type match. In the resulting dataset link configuration window, click **Save**.
1. Repeat steps {% if product == "yandex-cloud" %}3-4{% endif %}{% if product == "cloud-il" %}5-6{% endif %} as required.
1. Select your chart type, such as **Line chart**.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag measures from different datasets to the **Y** section. The values are displayed as charts on the Y-axis.
1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.

{% if product == "yandex-cloud" %}

{% cut "Example of creating a multi-dataset chart" %}

{% if audience == "internal" %}

To implement the example, use the [connection](https://datalens.yandex-team.ru/connections/0sa8m0z2vqgqz-sample-ch).

{% endif %}

{% include [datalens-multidataset-chart-example](../../../_includes/datalens/datalens-multidataset-chart-example.md) %}

{% endcut %}

{% endif %}

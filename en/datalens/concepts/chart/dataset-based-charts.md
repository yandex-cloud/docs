# Wizard charts


The wizard is a constructor that allows you to create charts based on the data from one or more datasets (see [{#T}](./multidataset-chart.md)). You can create an unlimited number of charts based on a single dataset.



{% include [datalens-db-query-note](../../../_includes/datalens/datalens-db-query-note.md) %}


Charts allow you to quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. For more information, see [{#T}](../limits.md).

{% endnote %}

The wizard UI has the following elements:

1. At the top, you can see general information, such as the chart path and the elements for managing and saving a chart, common for all charts.
1. At the bottom, you can select a [dataset](../../dataset/index.md) to build a chart from. Once you select a dataset, you will see a list of [fields](../../dataset/data-model.md#field) you can use in the chart.
1. Dataset dimensions you can use to build your chart. You can also add a [calculated field](../calculations/index.md) to this list.
1. Dataset measures you can use to build your chart.
1. [Chart type](../../visualization-ref/index.md) selection button and the ![image](../../../_assets/console-icons/gear.svg) icon to open the [general settings](./settings.md#common-settings).
1. List of sections. The available sections depend on the selected chart type, e.g., X axis, Y axis, filters, etc. You can drag and drop fields in a section.
1. Preview area where the visualization is displayed.
1. Chart legend. The legend maps the chart colors to the field values in the **Colors** section. By clicking individual legend elements, you can change the data display in the chart. You can select multiple legend elements by pressing and holding `Ctrl`/`Cmd`. You can enable and disable the legend in the [chart settings](./settings.md).

![image](../../../_assets/datalens/concepts/widget.png)

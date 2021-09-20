# Charts

_Charts_ are the visualization of data from a dataset in the form of a table, diagram, or map.

Charts are created in a wizard based on data from one or multiple datasets (see [multi-dataset charts](#multi-dataset-charts)).
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:

1. A dataset panel where available fields are displayed: **Dimensions** and **Measures**. You can add a [calculated field](../calculations/index.md) to the list.
1. A visualization setup panel that you can use to select a [chart type](types.md). Each type has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag and drop fields. Learn more in [{#T}](settings.md).
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. Read about them in the section [{#T}](../limits.md).

{% endnote %}

## Multi-dataset charts {#multi-dataset-charts}

Multi-dataset charts display data from multiple datasets.

Queries for each dataset are processed independently of each other. You cannot create calculated fields from fields in multiple datasets.
When you add a second dataset {{ datalens-short-name }}, the link is automatically created based on the first match for the field name and field data type.

In this case, you can:

* Change links.
* Add new links.
* Delete links.

{% note info %}

  Datasets used in the chart may be non-linked.

{% endnote %}

Specifics of working with linked datasets in the chart, except for geochart layers:

* One chart can use any measures from datasets, regardless of their links.
* One chart can only use linked dimensions.
* Filters by linked dimensions are applied to all datasets.
* Filters by non-linked dimensions are applied only to their own dataset.

Working with linked datasets in geovisualizations on different layers:

* A geolayer can use any measures from datasets regardless of their links
* A geolayer can only use its linked dimensions.
* Filters by linked dimensions from the **General filters** section are applied to all datasets in all layers.
* Filters from the **General filters** section that use non-linked dimensions only apply to their own dataset in all layers.
* Filters in the **Layer filters** section that use linked dimensions apply to all datasets within the current layer.
* Filters in the **Layer filters** section that use non-linked dimensions only apply to their own dataset within the current layer.
* There are no restrictions on using non-linked dimensions in different layers.

## Publishing a chart {#public-access}

You can grant any internet user access to a chart using [{{ datalens-public }}](../datalens-public.md). This chart becomes public and any user can view it without authorization.

To grant public access to a chart:

{% include [share-note](../../../_includes/datalens/datalens-share-note.md) %}

{% include [publish-chart](../../../_includes/datalens/operations/datalens-public-chart.md) %}

## Access management {#access-management}

You can configure chart permissions.

To configure chart permissions:

{% include [manage-access](../../../_includes/datalens/operations/datalens-chart-manage-access.md) %}

For more information about types of permissions, see [{#T}](../../security/index.md).

#### See also {#see-also}

- [{#T}](../../operations/chart/create-line-chart.md)
- [{#T}](../../operations/chart/create-pivot-table.md)
- [{#T}](../../operations/chart/create-table.md)
- [{#T}](../../operations/chart/create-area-chart.md)
- [{#T}](../../operations/chart/create-column-chart.md)
- [{#T}](../../operations/chart/create-bar-chart.md)
- [{#T}](../../operations/chart/create-pie-chart.md)
- [{#T}](../../operations/chart/create-map-chart.md)
- [{#T}](../../operations/chart/publish.md)


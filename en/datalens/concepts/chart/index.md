# Charts

_Charts_ are the visualization of data from a dataset in the form of a table, diagram, or map.

{{ datalens-short-name }} includes two types of charts:

* [Dataset-based charts](#dataset-based-charts)
* [QL charts](#sql-charts)

## Dataset-based charts {#dataset-based-charts}

Charts are created in a wizard based on data from one or multiple datasets (see [multi-dataset charts](#multi-dataset-charts)).
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:

1. A dataset panel where available fields are displayed: **Dimensions** and **Measures**. You can add a [calculated field](../calculations/index.md) to the list.
1. A visualization setup panel that you can use to select a [chart type](../../visualization-ref/index.md). Each type has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag and drop fields. Learn more in [{#T}](settings.md).
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. Read about them in the section [{#T}](../limits.md).

{% endnote %}

### Multi-dataset charts {#multi-dataset-charts}

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

## QL charts {#sql-charts}

_QL charts_ are charts created from a connection if the connection target is a database. Use a SQL query to build these charts. The query is executed using the original database's SQL flavor, which helps expand visualization capabilities by using database-specific transactions.

Executing a SQL query does not set up a separate [Dataset](../dataset/index.md) object, but rather generates one on the fly and displays it in the preview panel.

Unlike [regular charts](#dataset-based-charts), the logic of using the wizard in QL charts favors the SQL query, that is, the wizard only displays data from a query.

QL chart features:

* They reduce database workload by using direct queries.
* They are only suitable for `SELECTs`.
* They enable the use of the `JOIN`, `GROUP BY`, and `SORT BY` operators as well as aggregate functions in a SQL query.
* They enable the parameterization of any part of a SQL query.
* They support a limited set of [visualizations types](../../visualization-ref/index.md).
* They have [public access](#public-access) restrictions.
* They do not support data [materialization](../dataset/settings.md#materializaton).
* They do not use [RLS](../../security/row-level-security.md) or [calculated fields](../calculations/index.md).

{% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

To create a QL chart, see the [instructions](../../operations/chart/create-sql-chart.md).

## Chart types {#chart-types}

All types of {{ datalens-full-name }} charts are presented in the [Visualization Reference](../../visualization-ref/index.md).

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

* [{#T}](../../visualization-ref/line-chart.md#create-diagram)
* [{#T}](../../visualization-ref/pivot-table-chart.md#create-diagram)
* [{#T}](../../visualization-ref/table-chart.md#create-diagram)
* [{#T}](../../visualization-ref/area-chart.md#create-diagram)
* [{#T}](../../visualization-ref/column-chart.md#create-diagram)
* [{#T}](../../visualization-ref/bar-chart.md#create-diagram)
* [{#T}](../../visualization-ref/pie-chart.md#create-diagram)
* [{#T}](../../visualization-ref/map-chart.md)
* [{#T}](../../operations/chart/create-sql-chart.md)
* [{#T}](../../operations/chart/publish.md)

# Charts

_Charts_ are the visualization of data from a dataset in the form of a table, diagram, or map.

{{ datalens-short-name }} includes two types of charts:

* [Dataset-based charts](#dataset-based-charts)
* [QL charts](#sql-charts)

## Dataset-based charts {#dataset-based-charts}

Charts are created in a wizard based on data from one or more datasets (see [multi-dataset charts](#multi-dataset-charts)).
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:
1. A dataset panel where available fields are displayed: **Dimensions** and **Measures**. You can add a [calculated field](../calculations/index.md) to the list.
1. A visualization setup panel that you can use to select a [chart type](../../visualization-ref/index.md). Each type has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag and drop fields. For more information, see [{#T}](settings.md).
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. For more information, see [{#T}](../limits.md).

{% endnote %}

### Multi-dataset charts {#multi-dataset-charts}

Multi-dataset charts display data from multiple datasets.

Queries for each dataset are processed independently of each other. You cannot create calculated fields from fields in multiple datasets.
When you add a second {{ datalens-short-name }} dataset, a link is automatically created based on the first match for the field name and field data type.

In this case, you can:

* Change links.
* Add new links.
* Delete links.

{% note info %}

Datas in a chart don't have to be linked.

{% endnote %}

Features of working with linked datasets in charts, except for geochart layers:

* One chart can use any measures from datasets, regardless of their links.
* One chart can only use linked dimensions.
* Filters by linked dimensions are applied to all datasets.
* Filters by non-linked dimensions are applied only to their own dataset.

Features of working with linked datasets in geovisualizations on different layers:

* A geolayer can use any measures from datasets regardless of their links
* A geolayer can only use its linked dimensions.
* Filters by linked dimensions from the **General filters** section are applied to all datasets in all layers.
* Filters from the **General filters** section that use non-linked dimensions only apply to their own dataset in all layers.
* Filters in the **Layer filters** section that use linked dimensions apply to all datasets within the current layer.
* Filters in the **Layer filters** section that use non-linked dimensions only apply to their own dataset within the current layer.
* There are no restrictions on using non-linked dimensions in different layers.

## QL charts {#sql-charts}

_QL charts_ are charts created from a connection if the connection source is a database, {{ prometheus-name }}, or {{ monitoring-short-name }}. To create such charts, direct queries to the source are used. Depending on the chart type, the query can be run in the source database's SQL dialect, as well as the {{ prometheus-name }} or {{ monitoring-short-name }} query languages. This helps you to expand visualization capabilities by using language-specific transactions.

Running a query does not create a separate [Dataset](../dataset/index.md) object: a chart is generated on the fly and displayed in the preview panel.

Unlike [dataset-based charts](#dataset-based-charts), the logic of a visualization area in QL charts favors queries against the source, that is, the visualization area only displays the data queried.


The following types of QL charts are supported:

* **SQL**. They let you build visualizations with flexible dataset management based on parameterization of an SQL query to the source DB.

   SQL chart specifics:

   * Reduce database workload by using direct queries.
   * Are only suitable for `SELECT` queries.
   * Enable the use of `JOIN`, `GROUP BY`, and `SORT BY` queries and aggregate functions in SQL queries.
   * Enable the parameterization of any part of a SQL query.
   * Support a limited set of [visualizations types](../../visualization-ref/index.md).
   * They do not support [RLS](../../security/row-level-security.md) and [calculated fields](../calculations/index.md).

     {% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

* **{{ prometheus-name }}**. They let you create a chart based on {{ prometheus-name }} data (see the [example](https://datalens.yandex-team.ru/ql/ssvptrd5tqh0k)). You can't build a dataset on top of this source. You can only work with it using QL charts.

* **{{ monitoring-short-name }}**. They let you create a chart based on {{ monitoring-full-name }} data (see the [example](https://datalens.yandex-team.ru/ql/99c6irbpsmam1)). You can't build a dataset on top of this source. You can only work with it using QL charts. You can also `export` a chart from {{ monitoring-short-name }} to {{ datalens-short-name }}. You can edit, save, and place it on a dashboard.



To create a QL chart, see the [instructions](../../operations/chart/create-sql-chart.md).

## Chart types {#chart-types}

You can find all the {{ datalens-full-name }} chart types in the [Visualization reference](../../visualization-ref/index.md).




## Publishing a chart {#public-access}

You can grant any internet user access to a chart using [{{ datalens-public }}](../datalens-public.md). This chart becomes public and any user can view it without authorization.

Granting public access to a chart increases the number of DB queries, so keep in mind that the load on the database will increase.

To grant public access to a chart:

{% include [share-note](../../../_includes/datalens/datalens-share-note.md) %}

1. On the navigation page, find the chart and open it.
1. At the top of the wizard interface, click ![image](../../../_assets/datalens/share.svg).
1. In the window that opens, enable **Access via link**. {{ datalens-short-name }} automatically grants access to related objects.
1. Copy the public link and click **Apply**.




## Access management {#access-management}

You can configure chart permissions.

To configure chart permissions:

{% include [manage-access](../../../_includes/datalens/operations/datalens-chart-manage-access.md) %}

For more information about types of permissions, see [{#T}](../../security/index.md).


#### See also {#see-also}

- [{#T}](../../operations/chart/create-chart.md)
- [{#T}](../../operations/chart/create-sql-chart.md)
- [{#T}](../../visualization-ref/index.md)
- [{#T}](../../operations/chart/publish.md)

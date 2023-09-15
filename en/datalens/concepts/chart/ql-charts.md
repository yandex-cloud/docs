# QL charts. overview

_QL charts_ are charts created from a connection if the connection source is a database, {{ prometheus-name }}, or {{ monitoring-short-name }}. To create such charts, direct queries to the source are used. Depending on the chart type, the query can be run in the source database's SQL dialect, as well as the {{ prometheus-name }} or {{ monitoring-short-name }} query languages. This helps you to expand visualization capabilities by using language-specific transactions.

Running a query does not create a separate [Dataset](../dataset/index.md) object: a chart is generated on the fly and displayed in the preview panel.

Unlike [dataset-based charts](#dataset-based-charts), the logic of a visualization area in QL charts favors queries against the source, that is, the visualization area only displays the data queried.

{% note alert %}

If users are granted [permission to view](../../security/manage-access#permission-read) your QL chart, they will be able to make any queries to any source data of this QL chart.

{% endnote %}

The following types of QL charts are supported:

* **SQL**. They allow you to build visualizations with flexible dataset management based on parameterization of an SQL query to the source DB.

  SQL chart specifics:

  * Reduce database workload by using direct queries.
  * Are only suitable for `SELECT` queries.
  * Enable the use of `JOIN`, `GROUP BY`, and `SORT BY` queries and aggregate functions in SQL queries.
  * Enable the parameterization of any part of a SQL query.
  * Support a limited set of [visualizations types](../../visualization-ref/index.md).
  * They do not support [RLS](../../security/row-level-security.md) and [calculated fields](../calculations/index.md).

    {% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

* **{{ prometheus-name }}**. They let you create a chart based on {{ prometheus-name }} data (see the [example](https://datalens.yandex-team.ru/ql/ssvptrd5tqh0k)). You can't build a dataset on top of this source. You can only work with it using QL charts.

  {% include [datalens-prometheus-ch-example](../../../_includes/datalens/datalens-prometheus-ch-example.md) %}

  * **{{ monitoring-short-name }}**. They let you create a chart based on {{ monitoring-full-name }} data (see the [example](https://datalens.yandex-team.ru/ql/99c6irbpsmam1)). You can't build a dataset on top of this source. You can only work with it using QL charts.

  {% include [datalens-monitoring-ch-example](../../../_includes/datalens/datalens-monitoring-ch-example.md) %}

{% include [datalens-monitoring-prometheus-access-note](../../../_includes/datalens/datalens-monitoring-prometheus-access-note.md) %}

To create a QL chart, see the [instructions](../../operations/chart/create-sql-chart.md).

#### See also {#see-also}

- [{#T}](../../operations/chart/create-sql-chart.md)
- [{#T}](../../concepts/chart/index.md)
- [{#T}](../../operations/chart/create-chart.md)

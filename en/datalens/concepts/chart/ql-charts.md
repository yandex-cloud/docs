---
title: 'QL charts: Overview'
description: In this tutorial, you will learn about QL charts and their features.
---

# QL charts: Overview


_QL charts_ are charts created from a connection if the connection source is a database, {{ prometheus-name }}, or {{ monitoring-short-name }}. To create such charts, one uses direct queries to the source. Depending on the chart type, the query can be run in the source database's SQL dialect, as well as the {{ prometheus-name }} or {{ monitoring-short-name }} query languages. This helps you to expand visualization capabilities by using language-specific transactions.


Running a query does not create a separate [dataset](../../dataset/index.md) object: a chart is generated on the fly and displayed in the preview panel.

Unlike [dataset-based charts](dataset-based-charts.md), the logic of a visualization area in QL charts favors queries against the source, i.e., the visualization area only displays the data from the query.


{% note alert %}

If users are granted [permission to view](../../security/manage-access#permission-read) your QL chart, they will be able to make any queries to any source data of this QL chart.

{% endnote %}

The following types of QL charts are supported:

* **SQL**. These allow you to build visualizations with flexible dataset management based on parameterization of an SQL query to the source DB.

  SQL charts:

  * Reduce database workload by using direct queries.
  * Are only suitable for `SELECT` queries.
  * Enable the use of `JOIN`, `GROUP BY`, and `SORT BY` queries and aggregate functions in SQL queries.
  * Enable the parameterization of any part of a SQL query.
  * Support a limited set of [visualizations types](../../visualization-ref/index.md).
  * Do not support [RLS](../../security/row-level-security.md) and [calculable fields](../calculations/index.md).

    {% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}


* **{{ prometheus-name }}**. These allow you to create a chart based on {{ prometheus-name }}. You cannot build a dataset on top of this source. You can only work with it using QL charts.

  {% include [datalens-prometheus-ch-example](../../../_includes/datalens/datalens-prometheus-ch-example.md) %}

* **{{ monitoring-short-name }}**. These allow you to create a chart based on {{ monitoring-full-name }}. You cannot build a dataset on top of this source. You can only work with it using QL charts.

  {% include [datalens-monitoring-ch-example](../../../_includes/datalens/datalens-monitoring-ch-example.md) %}

{% include [datalens-monitoring-prometheus-access-note](../../../_includes/datalens/datalens-monitoring-prometheus-access-note.md) %}



To create a QL chart, follow [this guide](../../operations/chart/create-sql-chart.md).

#### See also {#see-also}

* [{#T}](../../operations/chart/create-sql-chart.md)
* [{#T}](../../concepts/chart/index.md)
* [{#T}](../../operations/chart/create-chart.md)

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
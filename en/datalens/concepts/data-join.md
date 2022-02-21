---
title: Combining Yandex DataLens data
description: 'When creating a dashboard in Yandex DataLens, a link is often used that determines the influence of a selector on one or more charts, as well as on other selectors. Relationship allows you to filter the values of selectors and charts. The article describes how to combine data from different datasets to set up communication between widgets.'
---
# Combining {{ datalens-full-name }} data

{{ datalens-full-name }} uses a [connection](connection.md) to retrieve data from a source (DB, CSV, Yandex.Metrica, and so on). You can create datasets, charts, and selectors from the connection's data. If the source has multiple tables, you can join them to build the required set of data. You can link data from different datasets at the chart level or through selector links.

## Methods of combining data {#data-join}

You can use different methods to combine data:

* [{#T}](#dataset-join)

  * [{#T}](#ui-join)
  * [{#T}](#add-connection)
  * [{#T}](#sql-join)

* [{#T}](#chart-join)

  * [{#T}](#sql-chart)
  * [{#T}](#datasets-chart)

* [{#T}](#selector-join)

### At the dataset level {#dataset-join}

To combine data at the dataset level, you can [add tables](#ui-join) to the workspace or write a [SQL query](#sql-join).
It's also possible to combine data based on [multiple CSV connections](#add-connection) in a single dataset.

#### Adding tables {#ui-join}

You can combine data through the dataset creation interface by dragging tables to the workspace and configuring links between them via the [JOIN operator](dataset/data-model.md#source). For an example of combining data by adding tables, see the [use case](../../solutions/datalens/data-from-ch-visualization.md#step2). 

#### Adding a connection {#add-connection}

In the dataset creation interface, you can combine data from two or more CSV connections. You can drag tables from different sources to the workspace and set up links between them using the [JOIN operator](dataset/data-model.md#source).

{% note warning %}

No other connection type, except CSV, supports combining data from different sources in a single dataset.

{% endnote %}

#### SQL query {#sql-join}

In a dataset, you can add an [ad-hoc SQL query](dataset/settings.md#sql-request-in-datatset) to the data source. When a data source is accessed, the query code is run as a subquery. You can use the output of the query as final dataset data or combine it with other source tables via the interface.

### At the chart level {#chart-join}

{{ datalens-short-name }} enables you to combine data at the chart level. To combine data at the chart level, you can use a [QL chart](#sql-chart) or [multi-dataset charts](#datasets-chart).

#### QL chart {#sql-chart}

[QL charts](chart/index.md#sql-charts) are charts created from a connection if there is a database at the other end of the connection. Running a SQL query does not create a separate Dataset object. One is generated on the fly and displayed in the preview panel. For more information, see the instructions for [{#T}](../operations/chart/create-sql-chart.md).

#### Multi-dataset charts {#datasets-chart}

[Multi-dataset charts](chart/index.md#multi-dataset-charts) are charts that visualize data from different datasets. Queries for each dataset are processed independently of each other. For more information, see the instructions for [{#T}](../operations/chart/create-sql-chart.md).

### At the selector link level {#selector-join}

You can add a selector to a dashboard to modify query output in its associated widgets:

* On the dashboard, selectors and charts built from a single dataset link automatically.
* Selectors and charts built from different datasets can be linked manually using aliases.

Before creating a link, make sure that the field used by the selector as a filter is included in the dataset the chart is built from. Otherwise, the link will not work. For more information, see the instructions for [{#T}](../operations/dashboard/create-alias.md).


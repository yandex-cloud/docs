# Dataset settings

Dataset settings determine how the dataset uses the source data.

## Connecting multiple tables {#multi-table}

If multiple tables are available from a data source, you can merge them using the JOIN operator.
When the tables are joined, a link is created between them. When you create a link, you specify the fields from the source table and merged table.

You can use the following types of JOIN operators:

* [INNER](https://en.wikipedia.org/wiki/Join_(SQL)#Inner_join)
* [LEFT](https://en.wikipedia.org/wiki/Join_(SQL)#Left_outer_join)
* [RIGHT](https://en.wikipedia.org/wiki/Join_(SQL)#Right_outer_join)
* [FULL](https://en.wikipedia.org/wiki/Join_(SQL)#Full_outer_join)

## Data source operation modes {#mode}

You can run your dataset in one of two modes, depending on the data source.

Datasets can work with data sources in the following modes:

- [Direct access](#direct). {{ datalens-short-name }} executes all the data queries on the data source side.
- [Materialization](#materialization). {{ datalens-short-name }} pre-saves the data to the database and then works with the data.

{% note info %}

Materialization mode is not available for Yandex.Metrica API and AppMetrica API sources.
To configure the database to populate from these sources, you can use [connections via the Logs API](#metrica-appmetrica-logs-api).

{% endnote %}

### Direct access {#direct}

All data requests are executed on the data source side.

### Materialization {#materializaton}

Materialization is the process of uploading data from the data source to the {{ datalens-short-name }} database.
You can run materialization as a one-time process or periodically on a schedule.

#### One-time materialization {#one-time-materialization}

Data is uploaded to the materialization DB once. Then {{ datalens-short-name }} only makes queries to the materialized data.

To sync {{ datalens-short-name }} storage with the source, you can reload the data.

{% note info %}

If you use a CSV file as the data source, {{ datalens-short-name }} automatically materializes the dataset.

{% endnote %}

#### Periodic materialization {#periodic-materialization}

Data is uploaded to the {{ datalens-short-name }} materialization DB according to a schedule. The schedule is set in the dataset settings.

For example, every second week on Thursday at 03:00.

The minimum available interval is once a day.

#### Connecting via the Logs API for Yandex.Metrica and AppMetrica sources {#metrica-appmetrica-logs-api}

For Metrica and AppMetrica sources, the {{ datalens-short-name }} materialization database is unavailable for populating with data. To set up automatic data loading from these sources, you can create a connection to the [Metrica Logs API](../../operations/connection/create-metrica-logs-api.md) or the [AppMetrica Logs API](../../operations/connection/create-appmetrica-logs-api.md) and set the data update frequency. This will load data from Yandex.Metrica or AppMetrica into the {{ CH }} database, which will serve as the dataset source.

For AppMetrica, you can also [export data to Yandex.Cloud](https://appmetrica.yandex.com/docs/cloud/index.html).

## Default filters for new charts {#default-filters}

In a dataset, you can [create](../../operations/dataset/create-filter.md) a default filter. It will be applied to any new chart created from data in the current dataset.

{% note info %}

- You can create a filter for an individual chart in the chart settings.
- Default filters are not applied to data in the dataset preview area.

{% endnote %}

Default filters for new charts will enable you:

* To reduce the amount of data requested from a source when building a chart.
* To add customized filters to new charts created from data in the same dataset.

## Access management {#access-management}

You can configure permissions for an entire dataset. For more information, see [{#T}](../../operations/dataset/manage-access.md).

You can also set data permissions at the row level (_Row-level security_ or _RLS_). Learn more in [{#T}](../../operations/dataset/manage-row-level-security.md).

## Executing SQL queries in datasets {#sql-request-in-datatset}

You can define a dataset data source using ad-hoc SQL queries over database connections. When a data source is accessed, a query code executes as a subquery. For more information about using SQL queries in a dataset, see [{#T}](../../operations/dataset/add-data.md).
When using SQL queries in datasets, we recommend:

* Restricting the user specified in the connection to `read-only` access.
* Assigning users that should not have ad-hoc query privileges `Execute` access to the connection and the associated datasets.

You can enable or disable the use of subqueries as a source when [creating](../../operations/index.md#creating-connection) or editing a connection.

#### See also {#see-also}

- [{#T}](../../operations/dataset/create.md)
- [{#T}](../../operations/dataset/materialize.md)
- [{#T}](../calculations/index.md)
- [{#T}](../calculations/index.md#how-to-create-calculated-field)


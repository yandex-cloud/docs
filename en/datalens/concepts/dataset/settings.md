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

### Direct access {#direct}

In direct access mode, {{ datalens-short-name }} materializes only part of the data for dataset preview.

All data requests are executed on the data source side.

{% note info %}

You can only use direct access for the following data sources:

- Yandex.Metrica API
- AppMetrica API

{% endnote %}

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

The minimum available interval is once a day.

## Default filters {#default-filters}

In a dataset, you can [create](../../operations/dataset/create-filter.md) a default filter. It will be applied to any new chart created from data in the current dataset.

{% note info %}

You can create a filter for an individual chart in the chart settings.

{% endnote %}

Default filters enable you:

* To reduce the amount of data requested from a source when building a chart.
* To add customized filters to new charts created from data in the same dataset.

## Access management {#access-management}

You can configure permissions for an entire dataset. For more information, see [{#T}](../../operations/dataset/manage-access.md).

You can also set data permissions at the row level (_Row-level security_ or _RLS_). Learn more in [{#T}](../../operations/dataset/manage-row-level-security.md).

#### See also {#see-also}

- [{#T}](../../operations/dataset/create.md)
- [{#T}](../../operations/dataset/materialize.md)
- [{#T}](../calculations/index.md)
- [{#T}](../calculations/index.md#how-to-create-calculated-field)


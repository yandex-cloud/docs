# Dataset settings

A dataset works with sources in direct access mode: {{ datalens-short-name }} runs all data queries on the source side. Dataset settings determine how the dataset uses the source data.


## Connecting multiple tables {#multi-table}

If multiple tables are available in the data source, you can [merge](../../operations/dataset/join-data.md) them using the JOIN operator.
When the tables are joined, a link is created between them. When you create a link, you specify the fields from the source table and merged table.

You can use the following types of JOIN operators:

* [INNER](https://en.wikipedia.org/wiki/Join_(SQL)#Inner_join)
* [LEFT](https://en.wikipedia.org/wiki/Join_(SQL)#Left_outer_join)
* [RIGHT](https://en.wikipedia.org/wiki/Join_(SQL)#Right_outer_join)
* [FULL](https://en.wikipedia.org/wiki/Join_(SQL)#Full_outer_join)

## Default filters for new charts {#default-filters}

In a dataset, you can [create](../../operations/dataset/create-filter.md) a default filter. It will be applied to any new chart created from data in the current dataset.

{% note info %}

* You can create a filter for an individual chart in the chart settings.
* Default filters are not applied to data in the dataset preview area.

{% endnote %}

Default filters for new charts will enable you to:

* Reduce the amount of data requested from a source when building a chart.
* Add customized filters to new charts created from data in the same dataset.


## Access management {#access-management}

You can configure permissions for an entire dataset.  For more information, see [{#T}](../../security/manage-access.md). 

You can also set data permissions at the row level (_Row-level security_ or _RLS_). For more information, see [{#T}](../../security/row-level-security.md).


## Running SQL queries in datasets {#sql-request-in-datatset}

You can define a dataset data source using ad-hoc SQL queries over database connections. When a data source is accessed, the query code runs as a subquery. For more information about using SQL queries in a dataset, see [{#T}](../../operations/dataset/add-data.md).
When using SQL queries in datasets, we recommend:

* Restricting the user specified in the connection to `read-only` access.
* Assigning users that should not have ad-hoc query privileges the `Execute` access to the connection and the associated datasets.

You can enable or disable the use of subqueries as a source when [creating](../connection.md) or editing a connection.

## Default preview {#preview-default}

By default, the dataset data uploaded from the source is displayed in the preview area. You can disable default data preview. To do this, click ![image](../../../_assets/console-icons/gear.svg) → ![image](../../../_assets/console-icons/check.svg) **Enable default preview** in the top-right corner of the dataset and save the dataset. Now, when you open the dataset, the data will not appear in the preview area. To display the data, click **Preview** at the top of the screen.

#### See also {#see-also}

* [{#T}](../../operations/dataset/create.md)
* [{#T}](../calculations/index.md)
* [{#T}](../calculations/index.md#how-to-create-calculated-field)

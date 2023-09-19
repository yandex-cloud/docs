
# Visualizing data from CHYT


This section explains how to connect CHYT using public clique as a data source for {{ datalens-short-name }}.

## Getting started {#before-you-begin}

To use a {{ ytsaurus-name }} table as a data source, select the CHYT clique you will be working with.

{% note info %}

A clique is a virtual cluster in CHYT. It is represented by an operation and has an ID (`operation_id`) or alias (`alias`). There are public and private cliques.

{% endnote %}


When working with CHYT, you can use the public `*ch_public` clique.

## Prepare a data table on {{ ytsaurus-name }} {#prepare-table}

Before creating a connector in CHYT, prepare your table on {{ ytsaurus-name }}:

- The table must be static. [Learn more about static tables in {{ ytsaurus-name }}](https://ytsaurus.tech/docs/ru/user-guide/storage/static-tables).

- The table must be schematized. {{ datalens-short-name }} executes a query to a table and receives its schema to form a dataset. [Learn more about schemas in {{ ytsaurus-name }}](https://ytsaurus.tech/docs/ru/user-guide/storage/static-schema).

{% note tip %}

We recommend:

* Sorting tables by the basic fields the filtering is done by. For instance, you can sort tables by fields that contain dates.
* Enabling [columnar chunk storage format](https://ytsaurus.tech/docs/ru/user-guide/storage/chunks#columns) using the `optimize_for = scan` attribute. This will enable {{ datalens-short-name }} to handle a table faster.

{% endnote %}

## Create a chart {#create-chart}


To create a chart in {{ datalens-short-name }}, you need to create a connection and dataset over it.

#### Create a connection {#create-connection}

To work with CHYT, create a **CHYT** connection.

{% include [datalens-yt-connection](../../_includes/datalens/internal/datalens-yt-connection.md) %}

You can go straight to creating a dataset from the connection creation interface. To do this, in the upper-right corner, click **Create dataset**.

#### Create a dataset {#create-dataset}

After creating a connection, you can create a dataset over it.

1. In the left-hand navigation menu, click ![icon-datasets](../../_assets/datalens/nav-datasets.svg) and then click **Create dataset** in the top-right corner.
1. In the window that opens, in the **Connections** section, click **+ Add**. Select the **CHYT** connection that you created earlier.

1. Select the source indication method:

   - **Table**: One table on {{ ytsaurus-name }}. URL from the browser or a full path to a table.

   - **List**: Multiple tables on {{ ytsaurus-name }}. URL from the browser or a full path to a table. Use a new row for each table.

   - **Range**: A range of tables on {{ ytsaurus-name }}. You can set your own table range using the **Start with** and **Finish at** fields. {{ datalens-short-name }} will add all the tables specified in the range to the dataset in alphabetical order. If the limit values are left blank, {{ datalens-short-name }} will use all the tables in the specified folder. You can also set only one limit value.

      {% note info %}

      For example, there are twenty tables in a folder and they are named `table_1`, `table_2`, `table_3`, ... . If you specify the limit values as `1` and `5` , {{ datalens-short-name }} will use only five tables from the folder.

      {% endnote %}

   - **SQL**: Selecting data for a dataset via an SQL query. We recommend copying a query from Query in ClickHouse syntax and then pasting it into the field.

      {% note warning %}

      First process a query from Query: delete all `;` symbols. An entire Query query from {{ datalens-short-name }} is executed as a subquery.

      {% endnote %}

1. Click **Save**. Make sure that the data is displayed in the dataset preview.

1. Click Save in the upper-right corner. Enter the dataset name and click **Create**. The dataset appears in the available list.

Above the created dataset, you can create various charts and place them on dashboards.

## Frequently asked questions {#questions}


{% cut "Error in the interface Access to table was denied" %}

`ERR.DS_API.DB.CHYT.TABLE_ACCESS_DENIED `

The {{ ytsaurus-name }} token user has no access to the selected table. Use a different token (from a user who has access to the table) or grant access to the table to the user with a token specified in the connection.
If you do not know who created the connection, create a new one.

{% endcut %}

{% cut "Error in the interface Clique not running" %}

`ERR.DS_API.CLIQUE_STOPPED`

The CHYT clique specified in the current connection is not running. Restart the clique.

{% endcut %}

{% cut "Error in the interface Column used in join expression is not a key column" %}

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN`

When you use a CHYT connection, key columns of {{ ytsaurus-name }} tables are significant. In multi-table datasets, you can link tables (execute JOIN) only by key columns of joined tables. To do this, the following requirements must be met:
* All the columns used to join two tables must form a part of the key for both of them.
* The keys of both tables must begin with exactly those columns.
* The columns must be listed in the same order in the keys of both tables.

To work around this issue, recreate the source tables and specify the keys that will meet the above requirements.

{% endcut %}


{% cut "Error in the interface {{ ytsaurus-name }} table has no schema. Only schematized tables are supported" %}

`ERR.DS_API.DB.CHYT.TABLE_HAS_NO_SCHEMA`

The {{ ytsaurus-name }} table that I use has no schema. You cannot use such tables in {{ datalens-short-name }}. Recreate the table with a schema (specify the data types)

{% endcut %}


{% cut "Requested database column does not exist error in the interface" %}

See [more info](../../datalens/troubleshooting/errors/ERR-DS_API-DB-COLUMN_DOES_NOT_EXIST.md).

{% endcut %}

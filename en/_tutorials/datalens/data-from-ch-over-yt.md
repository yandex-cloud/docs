# Visualizing data from ClickHouse over YT (CHYT)

This section explains how to connect CHYT using your clique as a data source for {{ datalens-short-name }}.

## Before you begin {#before-you-begin}

To use a YT table as a data source, select the CHYT clique you will be working with.

{% note info %}

A clique is a virtual ClickHouse cluster in YT. It is represented by an operation and has an ID (`operation_id`) or alias (`alias`). There are public and private cliques.

{% endnote %}

When working with CHYT and especially large YT tables, we recommend creating your own (private) clique.
If you do not have a private clique yet, you can [create it](https://yt.yandex-team.ru/docs/description/chyt/cliques/start) or use a public `*ch_datalens` clique. A public clique has limited resources and does not guarantee stability:

| Specifics | A public clique  | A private clique |
---- | ---- | ----
| Resources | Shared pool (non-guaranteed 16 instances of 8 cores each) | Dedicated pool (guaranteed capacity) |
| Query timeout | 30 seconds | 60 minutes (1 hour) |
| Available clusters | `Hahn` , `Arnold`, `Vanga` | `Hahn` , `Arnold` |

A public clique can become unavailable at any time due to queries from other users or be occupied by someone else's computations. Do not use a public clique to build processes that are important to you.

### Clique parameters {#clique-parameters}

When running a private clique, we recommend using the parameters for complex types:

    yt clickhouse start-clique --clickhouse-config '{yt={settings={composite={enable_conversion=1;default_yson_format="pretty"}}}}' …

In many cases, we also recommend specifying UTC as the system timezone. Full example:

    yt clickhouse start-clique --clickhouse-config '{engine={timezone="UTC"};yt={settings={composite={enable_conversion=1;default_yson_format="pretty"}}}}' …

For more information, see the [ticket](https://st.yandex-team.ru/BI-1977).

### Vanga {#vanga-cluster}

[Vanga](https://yt.yandex-team.ru/vanga/dashboard) is a YT cluster located in several data centers, which ensures fault tolerance during drills and other data center outages.

To use a cluster, [order an account and HDD quota for a Vanga cluster](https://yt.yandex-team.ru/docs/description/common/quota_request#sozdanie-akkaunta-i-diskovoj-kvoty-pod-novyj-proekt). Due to cluster specifics, it's not a good idea to order a compute pool and create a private clique.

Use a public `*ch_datalens` clique (see the [connection example](https://datalens.yandex-team.ru/connections/lr98fmzgsod0g)).

You can transfer data to the cluster via [Transfer Manager](https://transfer-manager.yt.yandex-team.ru/).

Updates with user-visible downtime occur approximately [several times a year](https://infra.yandex-team.ru/timeline?preset=a2tm531oiYL&from=1483218000000&to=1672520400000&status=all&types=major_issue%7Cmajor_maintenance). They are announced in infra at least 24 business hours before the work is performed.

For more information, see the [ticket](https://st.yandex-team.ru/BI-846).

{% note warning %}

Discuss with the [CHYT team](https://t.me/joinchat/DPeS0xFdpaSZoCWTYnhnnw) the use of SSD disks for tables. This will speed up clique operations. 

{% endnote %}

## Prepare a data table on YT {#prepare-table}

Before creating a connector in CHYT, prepare your table on YT:

- The table must be static. [Learn more about static tables in YT](https://arcanum.yandex-team.ru/arc/trunk/arcadia/yt/docs/description/storage/static_tables_overview.md).

- The table must be schematized. {{ datalens-short-name }} executes a query to a table and receives its schema to form a dataset. [Learn more about schemas in YT](https://arcanum.yandex-team.ru/arc/trunk/arcadia/yt/docs/description/storage/static_tables_overview.md).

{% note tip %}

We recommend enabling a [columnar chunk storage format](https://yt.yandex-team.ru/docs/description/storage/chunks#optimize_for) using the `optimize_for = scan` attribute. This will enable {{ datalens-short-name }} to handle a table more quickly.

{% endnote %}

## Create a chart {#create-chart}

There are two ways to create a chart:

* In [YT](#yt-chart).
* In [{{ datalens-short-name }}](#datalens-chart).

### Creating chart in YT {#yt-chart}

You can create a chart in YT for the tables stored on Arnold, Hahn, and Vanga clusters. You do not need to create a connection and dataset.

To create a chart in YT:

1. On the table view page in YT, click **DataLens**.
1. In the resulting window, edit the chart.
1. In the upper-right corner, click**Save** to save the chart.

Depending on the cluster, a public connection to CHYT with authenticating as a user is used.

{% note warning %}

A public `*ch_datalens` clique is used in the connection. Do not use it in production processes. To work with {{ datalens-short-name }}, we recommend [creating ](https://yt.yandex-team.ru/docs/description/chyt/cliques/start) a private clique.

{% endnote %}

A dataset is created automatically. It will be automatically deleted after 24 hours if no changes have been made to it and no charts have been built and saved based on it.

To allow other users to view the chart, give them access to the YT table or replace the connection in the dataset. To replace it, use a connection with a user token or robot with rights to the table in the source.

We do not recommend building charts and dashboards over tables in TMP. Once the table is deleted, they will become unavailable.

### Creating chart in DataLens {#datalens-chart}

To create a chart in {{ datalens-short-name }}, you need to create a connection and dataset over it.

#### Create a connection {#create-connection}

To work with ClickHouse over YT, you need to create a **CH over YT** connection.

{% include [datalens-yt-connection](../../_includes/datalens/internal/datalens-yt-connection.md) %}

You can go straight to creating a dataset from the connection creation interface. To do this, in the upper-right corner, click **Create dataset**.

#### Create a dataset {#create-dataset}

After creating a connection, you can create a dataset over it.

1. Go to [https://datalens.yandex-team.ru/datasets/](https://datalens.yandex-team.ru/datasets/) and click **Create** in the upper-right corner.

1. In the menu on the left, select **Dataset**.

1. In the window that opens, in the **Connections** section, click **+ Add**. Select **CH over YT** connection that you created earlier.

1. Select the source indication method:

   - **Table**: One table on YT. URL from the browser or a full path to a table.

   - **List**: Multiple tables on YT. URL from the browser or a full path to a table. Each table from a new row.

   - **Range**: A range of tables on YT. You can set your own table range using the **Start with** and **Finish at** fields. {{ datalens-short-name }} will add all the tables specified in the range to the dataset in alphabetical order. If the limit values are left blank, {{ datalens-short-name }} will use all the tables in the specified folder. You can also set only one limit value.

      {% note info %}

      For example, there are twenty tables in a folder and they are named `table_1`, `table_2`, `table_3`, ... . If you specify the limit values as `1` and `5` , {{ datalens-short-name }} will use only five tables from the folder.

      {% endnote %}

   - **SQL**: Selecting data for a dataset via an SQL query. We recommend copying a query from YQL in ClickHouse syntax and then pasting it into the field.

      {% note warning %}

      Pre-process a query from YQL: delete `use hahn` (`use arnold`) rows and all `;` symbols. An entire YQL query from {{ datalens-short-name }} is executed as a subquery.

      {% endnote %}

1. Click **Save**. Make sure that the data is displayed in the dataset preview.

1. Click Save in the upper-right corner. Enter the dataset name and click **Create**. The dataset appears in the available list.

Above the created dataset, you can create various charts and place them on dashboards.

## Frequently asked questions {#questions}

{% cut "Why do I use my own clique?" %}

A public clique does not guarantee stability.
Do not use a public clique for production processes.

{% endcut %}

{% cut "Error in the interface Access to table was denied" %}

`ERR.DS_API.DB.CHYT.TABLE_ACCESS_DENIED `

The YT-token user has no access to the object. Use a different token (from a user who has access to the table) or grant access to the table to the user with a token specified in the connection.
If you do not know who created the connection, create a new one.

{% endcut %}

{% cut "Error in the interface Clique not running" %}

`ERR.DS_API.CLIQUE_STOPPED`

The CHYT clique specified in the current connection is not running. Restart the clique.

{% endcut %}

{% cut "Error in the interface Column used in join expression is not a key column" %}

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN`

When you use the CHYT connection, key columns of the YT tables are significant. In multi-table datasets, you can link tables (execute JOIN) only by key columns of joined tables. Make sure to meet the following requirements:
* All columns used in table links must be part of the key for the tables involved;
* Keys of both tables must begin with those columns.
* Columns must be listed in the same order in the keys of both tables.

To work around this issue, recreate the source tables and specify the keys that will meet the above requirements.

{% endcut %}

{% cut "Error in the interface YT table has no schema. Only schematized tables are supported" %}

`ERR.DS_API.DB.CHYT.TABLE_HAS_NO_SCHEMA`

The YT table that I use doesn't have a schema. You can't use such tables in {{ datalens-short-name }}. Recreate the table with a schema (specify the data types)

{% endcut %}

{% cut "Error in the interface Requested database column does not exist" %}

See [more info](../../datalens/troubleshooting/errors/ERR-DS_API-DB-COLUMN_DOES_NOT_EXIST.md).

{% endcut %}

---
title: "SQL queries in {{ mpg-name }}"
description: "{{ mpg-name }} lets you visualize the data structure in your {{ PG }} cluster and send SQL queries to databases from the {{ yandex-cloud }} management console. To do this, log in to the management console, open the cluster page you need, and go to the SQL tab."
---

# SQL queries in the management console

{{ mpg-name }} lets you:

* Visualize the structure of the data and the query execution plans in your {{ PG }} cluster.
* Run SQL queries against databases from the {{ yandex-cloud }} management console.

{% note warning %}

You cannot use SQL commands to do anything that requires superuser access.

{% endnote %}

To connect to a {{ mpg-name }} cluster and manipulate its data from the management console:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the desired cluster.
1. [Enable the option](../operations/update.md#change-additional-settings) **Access from the management console** if it's not enabled.
1. Select the **SQL** tab.

{% include [web-sql-auth](../../_includes/mdb/web-sql-auth.md) %}

See a reference list of supported queries in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql.html).

## Data structure visualization {#data-structure-visualization}

Once you have logged in, you can see the structure of the selected database and its tables:

![structure](../../_assets/mdb/pg-web-sql-structure.png)

Click on the table to see the first 1000 rows of the `SELECT *` query result for this table, 20 rows per page (the management console doesn't support full navigation through all the DB data). In the **Query result offset** field, you can set the offset for showing the results table.

Hover over the column header to see the type of column data:

![table](../../_assets/mdb/pg-web-sql-table.png)


## SQL queries {#sql-queries}

The query input window is open on the right. Start typing your query to see suggested keyword options:

![suggest](../../_assets/mdb/pg-web-sql-suggest.png)

Enter your query and click **Execute**. The results table or error message is shown in the results panel that is under the editor control buttons.

![result](../../_assets/mdb/pg-web-sql-result.png)

## Query analysis {#sql-analyze}

To display a visualization of a SQL query execution plan:

1. Enter your query.
1. Click on the drop-down menu button next to **Run**.
1. Choose the visualization method:

   * **Query analysis**: A query is executed using `EXPLAIN ANALYZE`. A query plan is built using data received during execution. The tabs will display accurate information about the query properties:
      * **Cost**: The cost of parts of a query (in relative units).
      * **Time**: The time to execute an entire query and its component parts.
      * **Buffers**: Information about I/O operations and RAM usage for each part of a query.
   * **Query plan**: A query does not run, and its plan is constructed using the `EXPLAIN` command based on statistics collected by {{ PG }}. The **Cost** tab displays a rough estimate of the cost of the entire query and its parts (in relative units).

   For both, it will highlight the slow and the resource-intensive parts of the query.

   For more information, see the {{ PG }} documentation:

   * [Cost units for parts of a request](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).
   * [Using `EXPLAIN` and `EXPLAIN ANALYZE`](https://www.postgresql.org/docs/current/using-explain.html).

1. To view a detailed query execution plan as a tree, click ![full-screen](../../_assets/full-screen.svg). To exit this mode, press **Esc**.

   Each part of a query displays as a box showing the absolute and relative execution times. If one part of a query takes much longer to execute than the others or uses resource-heavy operations, the box will be marked with labels showing the reason.

   To get more detailed information about a part of a query, click on the desired box, and it will display a panel with the following tabs:

   * **Stats**: The execution cost (in relative units).
   * **I/O & Buffers**: Information on I/O operations and RAM usage.
   * **Misc**: General information regarding a query, such as a list of the fields involved.
   * **Info**: Supplemental information, such as the names of the tables and indexes queried.

## Query restrictions in the management console {#query-restrictions-in-the-management-console}

* If you close or reload the page, the query text and its results are lost. In this case, each request that you run from the management console is executed regardless of the browser state.
* The management console outputs only the first 1000 rows of the result.
* If a cluster query takes more than 10 minutes, the management console reports an error instead of printing the result, even if the query eventually finishes processing.
* If your cluster has multiple {{ PG }} hosts, queries from the management console are sent to the current master host.
* The list of tables is taken from the _public_ schema. You can make queries to tables from other schemas by explicitly specifying the schema, for example: `SELECT * from information_schema.column_udt_usage`.

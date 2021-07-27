---
title: SQL Queries in Managed Service for PostgreSQL
description: 'Managed Service for PostgreSQL allows you to visualize the data structure on your PostgreSQL cluster and send SQL queries to databases from the Yandex.Cloud management console. To do this, log into the management console, open the page of the required cluster and go to the SQL tab.'

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# SQL queries in Managed Service for PostgreSQL

{{ mpg-name }} lets you visualize the data structure in your {{PG}} cluster and send SQL queries to databases from the {{ yandex-cloud }} management console. To do this, log in to [management console]({{ link-console-main }}), open the cluster page and go to the **SQL** tab.

See a reference list of supported queries in the [{{PG}} documentation](https://www.postgresql.org/docs/current/sql.html).

{% note warning %}

You can't use SQL commands to perform actions that require superuser privileges.

{% endnote %}

## Access to the cluster from the management console {#sql-cluster-access}

To connect to a {{ mpg-name }} cluster from the management console and operate its data, activate the **Access from management console** option when [creating a cluster](cluster-create.md) or [changing its settings](update.md#change-additional-settings).

{% include [web-sql-auth](../../_includes/mdb/web-sql-auth.md) %}

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

## Query restrictions in the management console {#query-restrictions-in-the-management-console}

* If you close or reload the page, the query text and its results are lost. In this case, each request that you run from the management console is executed regardless of the browser state.
* The management console outputs only the first 1000 rows of the result.
* If a cluster query takes more than 10 minutes, the management console reports an error instead of printing the result, even if the query eventually finishes processing.
* If your cluster has multiple {{PG}} hosts, queries from the management console are sent to the current master host.
* The list of tables is taken from the _public_ schema. You can make queries to tables from other schemas by explicitly specifying the schema, for example: `SELECT * from information_schema.column_udt_usage`.


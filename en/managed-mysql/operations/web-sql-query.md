---
title: "SQL queries in {{ mmy-name }}"
description: "{{ mmy-name }} lets you visualize the data structure in your cluster and send SQL queries to databases from the {{ yandex-cloud }} management console. To do this, log in to the management console, open the cluster page you need, and go to the SQL tab."
---

# SQL queries in Managed Service for MySQL

{{ mmy-name }} allows you to visualize the data structure in your cluster and send SQL queries to databases from the {{ yandex-cloud }} management console. To do this, log in to the [management console]({{ link-console-main }}), open the cluster page you need, and go to the **SQL** tab.

## Access to the cluster from the management console {#sql-cluster-access}

To connect to a {{ mmy-name }} cluster from the management console and operate its data, activate the **Access from management console** option when [creating a cluster](cluster-create.md) or [changing its settings](update.md#change-additional-settings).

{% include [web-sql-auth](../../_includes/mdb/web-sql-auth.md) %}

## Data structure visualization {#data-structure-visualization}

Once you are logged in, you can access the structure of the selected database and the database tables:

Click the table to see the first 1000 rows of the `SELECT *` query result for this table (the management console doesn't support full navigation of all database data). To see the type of column data, hover over the column header.

To display the results table from the desired row, set the corresponding number in the **Query result offset** field. A maximum of 20 rows can be displayed on one page. Use the **<** and **>** buttons to quickly increase and decrease the number of the start row by 20.

## SQL queries {#sql-queries}

The query input window is open on the right. Start typing your query to see suggested keywords. Finish the query and click **Execute**. The results table or error message is shown in the results panel under the buttons.

## Query restrictions in the management console {#query-restrictions-in-the-management-console}

The main query restriction in the management console is that the text of queries and their results are displayed until you close or reload the page in your browser. But if a query was run successfully, {{ mmy-name }} processes it regardless of the state of the management console.

In addition, keep the following in mind:
* The management console will only display the first 1000 rows of results, even if there is actually more data.
* When a cluster query takes more than 10 minutes to complete, the management console will report an error as a result, even if the query was eventually processed successfully.

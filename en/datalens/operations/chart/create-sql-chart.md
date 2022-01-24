# Creating a SQL chart

You can create a SQL chart using one of the following methods:

{% list tabs %}

- From the home page
    1. On the {{ datalens-short-name }} home page, click **Charts** in the menu on the right.
    1. In the upper right-hand corner, click **Create chart** → **SQL chart**.
    1. In the resulting window, click **Select connection**.
    1. In the list, select a database connection that you have access to. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
    1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
    1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
    1. In the lower left-hand corner, click **Start**.

- From a connection
   1. Go to an existing database connection.
   1. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
   1. In the upper right-hand corner, click **Create SQL chart**.
   1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
   1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
   1. In the lower left-hand corner, click **Start**.

{% endlist %}

After the query runs, a visualization of your data will be displayed.

{% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

Extras:

In [SQL charts](../../concepts/chart/index.md#sql-charts), you can control selector settings from the **Parameters** tab in the chart editing area, and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.


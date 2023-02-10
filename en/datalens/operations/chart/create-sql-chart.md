# Creating a QL chart

{% if product == "yandex-cloud" %}

{% if audience != "internal" %}

You can create a QL chart using one of the following methods:

{% list tabs %}

- From the home page

   1. Go to the [{{ datalens-short-name }}]({{ link-datalens-main }}) home page.
   1. In the left-hand menu, select **Charts**.
   1. In the upper left-hand corner, click **Create chart** → **QL chart**.
   1. In the resulting window, click **Select connection**.
   1. In the list, select a database connection that you have access to. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
   1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
   1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
   1. In the lower left-hand corner, click **Start**.

- From a connection

   1. Go to an existing database connection.
   1. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
   1. In the top right-hand corner, click **Create QL chart**.
   1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
   1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
   1. In the lower left-hand corner, click **Start**.

{% endlist %}

After the query runs, a visualization of your data will be displayed.

{% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

{% else %}

You can create a QL chart using one of the following methods:

* [From the home page](#main-page).
* [From a connection](#connection).


## Creating a QL chart from the main page {#main-page}

1. Go to the [{{ datalens-short-name }}](https://datalens.yandex-team.ru) home page.
1. In the left-hand menu, select **Charts**.
1. In the upper left-hand corner, click **Create chart** → **QL chart**.
1. In the window that opens, select a **Chart type**:

   {% list tabs %}

   - SQL

      1. Click **Select connection**.
      1. In the list, select a database connection that you have access to. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
      1. Click **Create**.
      1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
      1. In the lower left-hand corner, click **Start**.

      After the query runs, a visualization of your data will be displayed.


   - {{ prometheus-name }}

      1. Click **Select connection**.
      1. In the list, select a {{ prometheus-name }} connection that you have access to.
      1. Click **Create**.
      1. Click **Add query** and specify a query in the {{ prometheus-name }} language.
      1. In the lower left-hand corner, click **Start**.

      After the query runs, a visualization of your data will be displayed.

      QL charts built on the {{ prometheus-name }} data can be parameterized similarly to SQL charts. This type of charts also has mandatory global parameters created automatically when building a QL chart. You can override default values of these parameters.

      | Parameter | Data type | Description |
      |---|---|---|
      | from | datetime | Lower time limit. |
      | to | datetime | Upper time limit. |
      | step | number | Step on the time scale (seconds). |

      On the dashboard, you can use a single selector for the date with a special `interval` name instead of the two selectors — `from` and `to`.

   - {{ monitoring-short-name }}

      {% note info %}

      For the {{ monitoring-short-name }} chart type, a public connection shared within the company is created. All Yandex employees have access to the connection.

      You can't select another connection or create a custom connection to {{ monitoring-short-name }}.

      {% endnote %}

      1. Click **Create**.
      1. Click **Add query** and specify a query in the {{ monitoring-short-name }} language.
      1. In the lower left-hand corner, click **Start**.

      After the query runs, a visualization of your data will be displayed.

      QL charts built on the {{ monitoring-short-name }} data can be parameterized similarly to SQL charts. This type of charts also has mandatory global parameters created automatically when building a QL chart. You can override default values of these parameters.

      | Parameter | Data type | Description |
      |---|---|---|
      | from | datetime | Lower time limit. |
      | to | datetime | Upper time limit. |

      On the dashboard, you can use a single selector for the date with a special `interval` name instead of the two selectors — `from` and `to`.

   {% endlist %}

## Creating a QL chart using a connection {#connection}

1. Go to an existing database connection.
1. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. In the top right-hand corner, click **Create QL chart**.
1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
1. In the lower left-hand corner, click **Start**.

After the query runs, a visualization of your data will be displayed.

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

To create a QL chart:

1. Open the [{{ datalens-short-name }} homepage]({{ link-datalens-main }}).
1. Go to the [workbook](../../concepts/index.md#workbooks-and-collections) to create a QL chart in.
1. On the workbook page, click **Create** → **QL chart** in the upper-right corner.
1. In the **Select connection to start** field, click **Select**.
1. In the list, select a database connection that you have access to. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
1. In the lower left-hand corner, click **Start**.

After the query runs, a visualization of your data will be displayed.

{% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

{% endif %}

## Adding selector parameters {#selector-parameters}

In [QL charts](../../concepts/chart/index.md#sql-charts), you can control selector parameters from the **Parameters** tab in the chart editing area and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.

You cannot use parameters of the `date-interval` and the `datetime-interval` types in query code unless they have the `_from` and `_to` suffixes. For a parameter named `interval`, for instance, you need to specify:

* `interval_from` to get the start of the range.
* `interval_to` to get the end of the range.

To add a parameter:

1. Go to the **Parameters** tab when creating a chart.
1. Click **Add parameter**.
1. Set the value type to `date-interval` (`datetime-interval`).
1. Name the parameter.
1. Set the range start and end values.

{% cut "Sample query" %}

```sql
SELECT toDate(Date) as datedate, count ('Oreder ID')
FROM samples.SampleLite
WHERE not_var{{interval_from}} < datedate AND datedate < not_var{{interval_to}}
GROUP BY datedate
ORDER BY datedate
```

{% endcut %}
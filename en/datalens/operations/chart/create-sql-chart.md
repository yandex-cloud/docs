# Creating a QL chart



You can create a QL chart using one of the following methods:

* [From the home page](#main-page).
* [From a connection](#connection).

{% include [datalens-monitoring-prometheus-access-note](../../../_includes/datalens/datalens-monitoring-prometheus-access-note.md) %}

QL charts have the same [general settings](../../concepts/chart/settings.md#common-settings) and [section settings](../../concepts/chart/settings.md#section-settings) available as charts based on a dataset. Only some [measure settings](../../concepts/chart/settings.md#indicator-settings) are supported for chart fields.

## Creating a QL chart from the main page {#main-page}


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).


1. In the left-hand panel, select ![image](../../../_assets/datalens/chart.svg) **Charts**.
1. Click **Create chart** → **QL chart**.
1. In the window that opens, select a **Chart type**:

   {% list tabs %}

   - SQL

     1. Click **Select connection**.
     1. In the list, select a database connection that you have access to. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
     1. Click **Create**.
     1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
     1. In the bottom-left corner, click **Start**.

     After the query runs, a visualization of your data will be displayed.

     {% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}

   - {{ prometheus-name }}

     1. Click **Select connection**.
     1. In the list, select a {{ prometheus-name }} connection that you have access to.
     1. Click **Create**.
     1. Click **Add query** and specify a query in the {{ prometheus-name }} language.
     1. In the bottom-left corner, click **Start**.

     After the query runs, a visualization of your data will be displayed.

     {% include [datalens-prometheus-ch-example](../../../_includes/datalens/datalens-prometheus-ch-example.md) %}

     QL charts built on the {{ prometheus-name }} data can be parameterized similarly to SQL charts. This type of charts also has mandatory global parameters created automatically when building a QL chart. You can override default values of these parameters.

     | Parameter | Data type | Description |
     |---|---|---|
     | from | datetime | Lower time limit |
     | to | datetime | Upper time limit |
     | step | number | Step on the time scale (seconds) |

     On the dashboard, you can use a single selector for the date with a special `interval` name instead of the two selectors — `from` and `to`.

   - {{ monitoring-short-name }}

     
     1. Click **Select connection**.
     1. In the list, select a {{ monitoring-short-name }} connection that you have access to.
     1. Click **Create**.
     1. Click **Add query** and specify a query in the {{ monitoring-short-name }} language.
     1. In the bottom-left corner, click **Start**.


     After the query runs, a visualization of your data will be displayed.

     {% include [datalens-monitoring-ch-example](../../../_includes/datalens/datalens-monitoring-ch-example.md) %}

     QL charts built on the {{ monitoring-short-name }} data can be parameterized similarly to SQL charts. This type of charts also has mandatory global parameters created automatically when building a QL chart. You can override default values of these parameters.

     | Parameter | Data type | Description |
     |---|---|---|
     | from | datetime | Lower time limit |
     | to | datetime | Upper time limit |

     On the dashboard, you can use a single selector for the date with a special `interval` name instead of the two selectors — `from` and `to`.

   {% endlist %}

## Creating a QL chart using a connection {#connection}

1. Go to an existing database connection.
1. Make sure **SQL query access level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. In the top-right corner, click **Create QL chart**.
1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
1. In the bottom-left corner, click **Start**.

After the query runs, a visualization of your data will be displayed.



## Adding selector parameters {#selector-parameters}

In [QL charts](../../concepts/chart/index.md#sql-charts), you can control selector parameters from the **Parameters** tab in the chart editing area and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.

You cannot use parameters of the `date-interval` and the `datetime-interval` types in query code unless they have the `_from` and `_to` suffixes. For a parameter named `interval`, for instance, you need to specify:

* `interval_from` to get the start of the range.
* `interval_to` to get the end of the range.

To add a parameter:

1. Go to the **Parameters** tab when creating a chart.
1. Click **Add parameter**.
1. Set the value type for the parameter, e.g., `date-interval`.
1. Name the parameter, e.g., `interval`.
1. Set the range start and end values, e.g., `2017-01-01 — 2019-12-31`.

   ![image](../../../_assets/datalens/parameters/date-interval.png =450x167)

In your query, use a parameter name with `_from` and `_to` postfixes to get the interval start and end, respectively. For example, use `interval_from` to get the interval start (`2017-01-01`) and `interval_to` to get the interval end (`2019-12-31`).

{% cut "Sample query" %}

```sql
SELECT toDate(Date) as datedate, count ('Order ID')
FROM samples.SampleLite
WHERE not_var{{interval_from}} < datedate AND datedate < not_var{{interval_to}}
GROUP BY datedate
ORDER BY datedate
```

{% endcut %}

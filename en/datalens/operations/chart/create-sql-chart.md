---
title: Creating a QL chart
description: Follow this guide to create a QL chart.
---

# Creating a QL chart



You can create a QL chart using one of the following methods:

* [From the home page](#main-page).
* [From a connection](#connection).

{% include [datalens-monitoring-prometheus-access-note](../../../_includes/datalens/datalens-monitoring-prometheus-access-note.md) %}

QL charts have the same [general settings](../../concepts/chart/settings.md#common-settings) and [section settings](../../concepts/chart/settings.md#section-settings) as the dataset-based charts. Only certain [measure settings](../../concepts/chart/settings.md#indicator-settings) are supported for chart fields.

At each step, you can [undo/redo](../../concepts/chart/settings.md#undo-redo) any change within the current version.

## Creating a QL chart from the main page {#main-page}


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).


1. In the left-hand panel, select ![image](../../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **QL chart**.
1. In the window that opens, select a **Chart type**:

   {% list tabs %}

   - SQL

     1. Click **Select connection**.
     1. In the list, select a database connection that you have access to. Make sure **Raw SQL level** → **Allow subqueries in datasets and queries from charts** is enabled.
     1. Click **Create**.
     1. In the **Query** tab, enter your query using the SQL dialect of the database you are querying.
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
     | to | datetime | Upper time limit. |
     | step | number | Step on the time scale (seconds) |

     {% note info %}

     On the dashboard, you can use a single selector for the date with the special `interval` name instead of the two selectors, `from` and `to`.

     {% endnote %}

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
     | to | datetime | Upper time limit. |

     {% note info %}

     On the dashboard, you can use a single selector for the date with the special `interval` name instead of the two selectors, `from` and `to`.

     {% endnote %}

   {% endlist %}

## Creating a QL chart using a connection {#connection}

1. Go to an existing database connection.
1. Make sure **Raw SQL level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. In the top-right corner, click **Create QL chart**.
1. In the **Query** tab, enter your query using the SQL dialect of the database you are querying.
1. In the bottom-left corner, click **Start**.

After the query runs, a visualization of your data will be displayed.


## Adding selector parameters {#selector-parameters}

In [QL charts](../../concepts/chart/index.md#sql-charts), you can control selector parameters from the **Parameters** tab in the chart editing area and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.

To add a parameter:

1. Go to the **Parameters** tab when creating a chart.
1. Click **Add parameter**.
1. Set the value type for the parameter, e.g., `date-interval`.
1. Name the parameter, e.g., `interval`.
1. Set the default values, e.g., `2017-01-01 — 2019-12-31`.

   ![image](../../../_assets/datalens/parameters/date-interval.png =450x167)

   There are several ways to configure the parameters of the `date`, `datetime`, `date-interval`, and `datetime-interval` types:

   * **Exact date** to specify an exact value.
   * **Offset from the current date** to specify a relative value that will be updated automatically.
   
   Use presets to quickly fill in the values.

To manage parameter values on the dashboard, [create a selector](../dashboard/add-selector.md) with manual input and specify a parameter name in the **Field or parameter name** field.

### Intervals {#params-interval}

The `date-interval` and the `datetime-interval` type parameters can be used in query code only with the `_from` and `_to` postfixes. For example, for the `interval` parameter set to `2017-01-01 — 2019-12-31`, specify:

* `interval_from` to get the start of the interval (`2017-01-01`).
* `interval_to` to get the end of the interval (`2019-12-31`).

{% cut "Request example" %}

```sql
SELECT toDate(Date) as datedate, count ('Oreder ID')
FROM samples.SampleLite
WHERE not_var{{interval_from}} < datedate AND datedate < not_var{{interval_to}}
GROUP BY datedate
ORDER BY datedate
```

{% endcut %}

### Substituting parameter values in a QL chart query {#params-in-select}

Parameter values from a selector arrive to a QL chart as a:

* Single value if one element is selected.
* [Tuple](https://docs.python.org/3/library/stdtypes.html#tuples) if multiple values are selected.

If a query for {{ CH }} or {{ PG }} connections has the `in` operator before a parameter, the substituted value is always converted into a tuple. In the case of other connections, there is no automatic conversion. A query with the `in` operator will run correctly if you select one or more values.

{% cut "Example of a query with `in`" %}

```sql
SELECT sum (Sales) as Sales, Category
FROM samples.SampleLite
WHERE Category in not_var{{category}} 
GROUP BY Category
ORDER BY Category
```

{% endcut %}

If the query has `=` before a parameter, the query will only run correctly if a single value is selected.

{% cut "Example of a query with `=`" %}

```sql
SELECT sum (Sales) as Sales, Category
FROM samples.SampleLite
WHERE Category = not_var{{category}} 
GROUP BY Category
ORDER BY Category
```

{% endcut %}

### Null choice in selector and parameters {#empty-selector}

If a selector has no value selected and no default value is set for a parameter, a null value is provided to a query. In which case all values will be selected in [dataset-based charts](../../concepts/chart/dataset-based-charts.md), and the filter for the relevant column will disappear when generating a query.

To enable a similar behavior in QL charts, you can use a statement like this in your query:

```sql
AND
CASE
    WHEN LENGTH(not_var{{param}}::VARCHAR)=0 THEN TRUE
    ELSE column IN not_var{{param}}
END
```

#### See also {#see-also}

* [{#T}](../../concepts/chart/index.md)
* [{#T}](../dashboard/add-chart.md)

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
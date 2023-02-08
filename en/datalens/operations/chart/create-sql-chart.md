# Creating a QL chart



You can create a QL chart using one of the following methods:

{% list tabs %}

- From the home page

  1. Go to the [{{ datalens-short-name }}]({{ link-datalens-main }}) home page.
  1. In the left-hand menu, select **Charts**.
  1. In the upper left-hand corner, click **Create chart** → **QL chart**.
  1. In the resulting window, click **Select connection**.
  1. In the list, select a database connection that you have access to. Make sure **Raw SQL level** → **Allow subselects in datasets and queries from charts** is enabled.
  1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
  1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
  1. In the lower left-hand corner, click **Start**.

- From a connection

  1. Go to an existing database connection.
  1. Make sure **Raw SQL level** → **Allow subselects in datasets and queries from charts** is enabled.
  1. In the top right-hand corner, click **Create QL chart**.
  1. Use the **Query** tab to enter a query in the flavor of SQL native to the database you are accessing.
  1. Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.
  1. In the lower left-hand corner, click **Start**.

{% endlist %}

After the query runs, a visualization of your data will be displayed.

{% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}




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
SELECT toDate(Date) as datedate, count ('Order ID')
FROM samples.SampleLite
WHERE not_var{{interval_from}} < datedate AND datedate < not_var{{interval_to}}
GROUP BY datedate
ORDER BY datedate
```

{% endcut %}
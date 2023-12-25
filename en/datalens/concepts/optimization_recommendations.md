# Optimization best practices

To render charts and selectors, {{ datalens-short-name }} does not store data inside; instead, it sends queries to the source database. These queries and any computations (formulas in calculated fields) are run on the data source side. Therefore, to speed up queries and rendering of the obtained data, you need to optimize the source data.

To optimize data operations, follow the recommendations below:

1. Work on the source data structure:

   * Do your best to store the data in a format that does not require any complex operations when querying it. If possible, calculate the data on the DB side first. This will allow you to minimize computations using {{ datalens-short-name }} formulas.
   * Explicitly declare data types on the DB side to avoid type conversions in large tables. For example, do not store dates as text.
   * Sort tables by frequently used dimensions (usually, these are dates).
   * When building data marts with a large number of rows, make sure to store aggregate and detailed data in different tables and datasets. This will decrease the load on the source when running data queries.
   * Build systems of materialized tables on the DB side with different levels of detail for different charts and user tasks. Do not use a single large table for all tasks:

      * If most charts on a dashboard only show the sales amount by month, there is no need to store daily data. You can aggregate the data on the DB side and materialize a table.
      * If the chart data needs to be split by day, you can use a table with a higher level of detail.

      In this case, you can configure date selectors so that they filter all charts at the same time.

   * Create separate materialized reference tables for selectors to avoid selecting unique field values from large tables when generating a list of values for the selectors.
   * When using [Join](data-join.md), a subquery is run to the full set of table fields. These operations are highly resource-consuming and will degrade dashboard performance for most databases. Therefore, to make your dashboards run faster:

      * If possible, change the table structure so that the number of joins in a dataset is decreased.
      * If possible, join the data on the DB side and materialize the table.

   * Consider the specifics of storing and accessing the data in the DB you connect to. For example, {{ CH }} cannot use indexes by nullable fields. Therefore, whenever possible, replace `NULL` with non-empty table values as long as this does not lead to incorrect calculation results.

1. Reduce the load on the source when running data operations:

   * Try to exclude fields that are not used to create charts from a dataset.
   * We recommend adding fields at the dataset level instead of doing so at the chart level.
   * If you know for sure that certain table rows will not be used in a dashboard, remove them in advance by using prefiltering. Remove unnecessary columns from non-columnar databases.
   * If possible, do not create datasets based on SQL queries. In this case, a custom SQL query will be run each time you access the database.
   * Do not output a large number of points on a chart. In {{ datalens-short-name }}, there is a limit that will help you follow this recommendation. However, note that the fewer points a chart has, the faster it runs.

1. Optimize the load on the source when setting up a dashboard:

   * Set dashboard selector values and use the defaults. The list of values set in a selector creates a condition for filtering chart data. If no value is selected, all data is returned. This increases the load on the source.
   * Optimize the dashboard structure. Queries to the source are run for each chart in the current tab. It may take much time to load a tab if there are too many charts. Place as few charts per tab as possible considering how often they are used at the same time.
      * Reduce the use of [auto updates](dashboard.md#auto-update) for your dashboard data. Do not set its update frequency to a value larger than that of the source data update frequency.
   * Use the **Number of simultaneously loaded widgets** option in the dashboard settings.

1. Consider the service specifics:

   * Each time you switch between the dashboard tabs, the service queries the source data again. On the one hand, this ensures that data displayed to users is always up-to-date. On the other, this is inefficient if data changes are not frequent.
   * Each time after you set selector values, the service accesses the source and updates the data. If you use multiple selectors on your dashboard, the number of queries to the source increases.


1. Use the {{ datalens-short-name }} tools that help optimize data operations:

   * [Chart inspector](./chart/inspector.md), a {{ datalens-short-name }} tool that helps you troubleshoot data loading and browser rendering issues.
   * [Caching](caching.md) of frequently requested source data to quickly access it.



{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}